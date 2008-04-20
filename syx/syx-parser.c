/* 
   Copyright (c) 2007-2008 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#include "syx-object.h"

#include <assert.h>
#include <string.h>
#include "syx-error.h"
#include "syx-types.h"
#include "syx-memory.h"
#include "syx-bytecode.h"
#include "syx-parser.h"
#include "syx-interp.h"
#include "syx-utils.h"

static syx_varsize _syx_parser_find_temporary_name (SyxParser *self, syx_symbol name);
static syx_varsize _syx_parser_find_argument_name (SyxParser *self, syx_symbol name);
static syx_varsize _syx_parser_find_instance_name (SyxParser *self, syx_symbol name);
static syx_bool _syx_parser_parse_term (SyxParser *self);
static syx_bool _syx_parser_parse_name_term (SyxParser *self, syx_symbol name);

static void _syx_parser_parse_message_pattern (SyxParser *self);
static void _syx_parser_parse_block_message_pattern (SyxParser *self);
static void _syx_parser_parse_method_message_pattern (SyxParser *self);

static void _syx_parser_parse_primitive (SyxParser *self);
static void _syx_parser_parse_temporaries (SyxParser *self);

static void _syx_parser_parse_body (SyxParser *self);
static void _syx_parser_parse_statement (SyxParser *self);
static void _syx_parser_parse_expression (SyxParser *self);
static void _syx_parser_parse_assignment (SyxParser *self, syx_symbol assign_name);
static void _syx_parser_parse_block (SyxParser *self);
static syx_varsize _syx_parser_parse_optimized_block (SyxParser *self, SyxBytecodeSpecial branch_type, syx_bool do_pop);
static void _syx_parser_parse_array (SyxParser *self);
static SyxOop _syx_parser_parse_literal_array (SyxParser *self);

static void _syx_parser_do_continuation (SyxParser *self, syx_bool super_receiver);
static syx_bool _syx_parser_do_key_continuation (SyxParser *self, syx_bool super_receiver);
static syx_bool _syx_parser_do_binary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade);
static syx_bool _syx_parser_do_unary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade);

/*!
  Create a new SyxParser to parse the code later.

  \param method a CompiledMethod or CompiledBlock
  \param instance_names list of instance variable names
*/
SyxParser *
syx_parser_new (SyxLexer *lexer, SyxOop method, SyxOop klass)
{
  SyxParser *self;
  if (!lexer || !SYX_IS_OBJECT (method))
    return NULL;
  
  self = (SyxParser *) syx_malloc (sizeof (SyxParser));

  self->lexer = lexer;
  self->method = method;
  self->klass = klass;
  self->_in_block = FALSE;

  self->bytecode = syx_bytecode_new ();
  self->_temporary_scopes_top = 0;
  self->_argument_scopes_top = 0;
  self->instance_names = syx_class_get_all_instance_variable_names (klass);

  self->_duplicate_indexes_top = 0;

  return self;
}

void
_syx_scope_free (SyxParserScope *scope)
{
  int i;
  for (i=0; i < scope->top; i++)
    syx_free (scope->stack[i]);
}

/* Free current temporary scopes and arguments */
void
_syx_parser_free_temporaries (SyxParser *self)
{
  _syx_scope_free (self->_temporary_scopes + self->_temporary_scopes_top);
}

void
_syx_parser_free_arguments (SyxParser *self)
{
  _syx_scope_free (self->_argument_scopes + self->_argument_scopes_top);
}

/*!
  Free all memory used by the parser.

  \param free_segment TRUE frees the instance_names (not its contents) and the lexer
*/
void
syx_parser_free (SyxParser *self, syx_bool free_segment)
{
  syx_bytecode_free (self->bytecode);

  if (free_segment)
    {
      if (self->instance_names)
        syx_free (self->instance_names);
      syx_lexer_free (self->lexer, TRUE);
    }

  syx_free (self);
}

/*!
  Do parse.

  \return TRUE if parsing was successful, otherwise FALSE
*/
syx_bool
syx_parser_parse (SyxParser *self, syx_bool skip_message_pattern)
{
  SyxToken token;

  token = syx_lexer_next_token (self->lexer);
  if (token.type == SYX_TOKEN_END)
    return TRUE;

  self->_temporary_scopes[self->_temporary_scopes_top].top = 0;
  self->_argument_scopes[self->_argument_scopes_top].top = 0;

  if (!skip_message_pattern)
    _syx_parser_parse_message_pattern (self);

  if (!self->_in_block)
    _syx_parser_parse_primitive (self);

  _syx_parser_parse_temporaries (self);

  if (self->_in_block)
    syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_NIL);

  _syx_parser_parse_body (self);

  syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_SELF_RETURN);

  SYX_CODE_BYTECODES(self->method) = syx_byte_array_new_ref (self->bytecode->code_top * sizeof (syx_uint16),
                                                             (syx_uint8 *)self->bytecode->code);
  SYX_CODE_LITERALS(self->method) = syx_array_new_ref (self->bytecode->literals_top,
                                                       self->bytecode->literals);
  
  SYX_CODE_STACK_SIZE(self->method) = syx_small_integer_new (self->bytecode->stack_size + 1);
  SYX_CODE_TEXT(self->method) = syx_string_new (self->lexer->text +
                                                syx_find_first_non_whitespace (self->lexer->text));
  SYX_CODE_CLASS(self->method) = self->klass;

  /* Free arguments and temporaries of this scope */
  _syx_parser_free_arguments (self);
  _syx_parser_free_temporaries (self);

  return TRUE;
}

static syx_varsize
_syx_parser_find_temporary_name (SyxParser *self, syx_symbol name)
{
  syx_varsize i, top, scope_index;
  SyxParserScope *scope;
  if (!name)
    return -1;

  top = 0;
  for (scope_index=self->_temporary_scopes_top; scope_index >= 0; scope_index--)
    {
      scope = self->_temporary_scopes + scope_index;
      for (i=scope->top-1; i >= 0; i--)
        {
          if (!strcmp (scope->stack[i], name))
            return i + top;
        }
      top += scope->top;
    }

  return -1;
}

static syx_varsize
_syx_parser_find_argument_name (SyxParser *self, syx_symbol name)
{
  syx_varsize i, index, scope_index;
  SyxParserScope *scope;
  if (!name)
    return -1;

  index = 0;
  for (scope_index=self->_argument_scopes_top; scope_index >= 0; scope_index--)
    {
      scope = self->_argument_scopes + scope_index;
      for (i=0; i < scope->top; i++, index++)
        {
          if (!strcmp (scope->stack[i], name))
            return index;
        }
    }

  return -1;
}

static syx_varsize
_syx_parser_find_instance_name (SyxParser *self, syx_symbol name)
{
  syx_varsize i;

  if (!self->instance_names)
    return -1;

  if (!name)
    return -1;

  for (i=0; self->instance_names[i]; i++)
    {
      if (!strcmp (self->instance_names[i], name))
        return i;
    }

  return -1;
}

static SyxOop
_syx_parser_find_class_variable_name (SyxParser *self, syx_symbol name)
{
  SyxOop klass = self->klass;
  SyxOop binding;

  if (syx_object_get_class (klass) == syx_metaclass_class)
    klass = SYX_METACLASS_INSTANCE_CLASS (klass);

  for (; !SYX_IS_NIL(klass); klass=SYX_CLASS_SUPERCLASS(klass))
    {
      binding = syx_dictionary_binding_at_symbol_if_absent (SYX_CLASS_CLASS_VARIABLES (klass), name, syx_nil);
      if (!SYX_IS_NIL (binding))
        return binding;
    }

  return syx_nil;
}

static syx_bool
_syx_parser_parse_term (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_bool super_term = FALSE;
  switch (token.type)
    {
    case SYX_TOKEN_NAME_CONST:
      super_term = _syx_parser_parse_name_term (self, token.value.string);
      syx_token_free (token);
      break;
    case SYX_TOKEN_STR_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_string_new (token.value.string));
      syx_token_free (token);
      break;
    case SYX_TOKEN_INT_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_small_integer_new (token.value.integer));
      syx_token_free (token);
      break;
#ifdef HAVE_LIBGMP
    case SYX_TOKEN_LARGE_INT_CONST:
      syx_bytecode_push_literal (self->bytecode,
                                 syx_large_integer_new_mpz (token.value.large_integer));
      syx_token_free (token);
      break;
#endif
    case SYX_TOKEN_FLOAT_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_float_new (token.value.floating));
      syx_token_free (token);
      break;
    case SYX_TOKEN_SYM_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_symbol_new (token.value.string));
      syx_token_free (token);
      break;
    case SYX_TOKEN_CHAR_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_character_new (token.value.character));
      syx_token_free (token);
      break;
    case SYX_TOKEN_ARRAY_BEGIN:
      syx_bytecode_push_literal (self->bytecode, _syx_parser_parse_literal_array (self));
      syx_token_free (token);
      break;
    case SYX_TOKEN_BINARY:
      if (!strcmp (token.value.string, "("))
        {
          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
          _syx_parser_parse_expression (self);
          token = syx_lexer_get_last_token (self->lexer);
          if (! (token.type == SYX_TOKEN_CLOSING && token.value.character == ')'))
            syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected ) after sub expression"));
          break;
        }
      else if (!strcmp (token.value.string, "["))
        {
          _syx_parser_parse_block (self);
          break;
        }
      else if (!strcmp (token.value.string, "{"))
        {
          _syx_parser_parse_array (self);
          break;
        }
      else if (!strcmp (token.value.string, "-"))
        {
          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
          if (token.type == SYX_TOKEN_INT_CONST)
            syx_bytecode_push_literal (self->bytecode, syx_small_integer_new (-token.value.integer));

#ifdef HAVE_LIBGMP
          else if (token.type == SYX_TOKEN_LARGE_INT_CONST)
            {
              mpz_neg (*token.value.large_integer, *token.value.large_integer);
              syx_bytecode_push_literal (self->bytecode,
                                         syx_large_integer_new_mpz (token.value.large_integer));
            }
#endif /* HAVE_LIBGMP */

          else if (token.type == SYX_TOKEN_FLOAT_CONST)
            syx_bytecode_push_literal (self->bytecode, syx_float_new (-token.value.floating));
          else
            syx_signal(SYX_ERROR_INTERP, syx_string_new ("Negation not followed by number"));

          syx_token_free (token);
          break;
        }
      /* We continue here because of weird binary token used as expression start */

    default:
      switch (token.type)
        {
        case SYX_TOKEN_END:
          syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unexpected end of input"));
          break;
        case SYX_TOKEN_STRING_ENTRY:
          syx_signal (SYX_ERROR_INTERP, syx_string_new ("Invalid expression start: %s", token.value.string));
          syx_token_free (token);
          break;
        case SYX_TOKEN_CLOSING:
          syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unexpected closing: %c", token.value.character));
          break;
        default:
          syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected expression"));
          break;
        }
    }

  syx_lexer_next_token (self->lexer);
  return super_term;
}

static syx_bool
_syx_parser_parse_name_term (SyxParser *self, syx_symbol name)
{
  syx_varsize pos;
  SyxOop binding;

  if (!strcmp (name, "self") || !strcmp (name, "super"))
    {
      syx_bytecode_push_argument (self->bytecode, 0);
      if (!strcmp (name, "super"))
        return TRUE;
      return FALSE;
    }

  if (!strcmp (name, "nil"))
    {
      syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_NIL);
      return FALSE;
    }
  else if (!strcmp (name, "true"))
    {
      syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_TRUE);
      return FALSE;
    }
  else if (!strcmp (name, "false"))
    {
      syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_FALSE);
      return FALSE;
    }
  else if (!strcmp (name, "thisContext"))
    {
      syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_CONTEXT);
      return FALSE;
    }

  pos = _syx_parser_find_argument_name (self, name);
  if (pos >= 0)
    {
      syx_bytecode_push_argument (self->bytecode, pos + 1);
      return FALSE;    
    }

  pos = _syx_parser_find_temporary_name (self, name);
  if (pos >= 0)
    {
      syx_bytecode_push_temporary (self->bytecode, pos);
      return FALSE;
    }

  pos = _syx_parser_find_instance_name (self, name);
  if (pos >= 0)
    {
      syx_bytecode_push_instance (self->bytecode, pos);
      return FALSE;
    }

  binding = _syx_parser_find_class_variable_name (self, name);
  if (!SYX_IS_NIL (binding))
    syx_bytecode_push_binding_variable (self->bytecode, binding);
  else
    syx_bytecode_push_binding_variable (self->bytecode,
                                        syx_dictionary_binding_at_symbol (syx_globals, name));

  return FALSE;
}

static void
_syx_parser_parse_primitive (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_int32 prim_index;

  SYX_METHOD_PRIMITIVE(self->method) = syx_small_integer_new (-1);

  if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "<")))
    return;
  syx_token_free (token);

  token = syx_lexer_next_token (self->lexer);
  if (token.type != SYX_TOKEN_NAME_COLON)
    syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected name colon"));

  if (!strcmp (token.value.string, "primitive:"))
    {
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (token.type != SYX_TOKEN_STR_CONST)
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected a string containing the primitive to be called"));
      
      prim_index = syx_primitive_get_index (token.value.string);
      if (prim_index < 0)
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unknown primitive named", token.value.string));
      syx_token_free (token);
      
      token = syx_lexer_next_token (self->lexer);
      if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ">")))
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected >"));
      syx_token_free (token);
      
      SYX_METHOD_PRIMITIVE (self->method) = syx_small_integer_new (prim_index);
      
      syx_lexer_next_token (self->lexer);
    }
  else if (!strcmp (token.value.string, "cCall:"))
    {
      syx_token_free (token);
      
      token = syx_lexer_next_token (self->lexer);

      if (token.type != SYX_TOKEN_STR_CONST)
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected a string containing the primitive to be called"));
      syx_bytecode_gen_literal (self->bytecode, syx_symbol_new (token.value.string));
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ">"))
        {
          syx_token_free (token);
          syx_bytecode_gen_literal (self->bytecode, syx_nil);
          SYX_METHOD_PRIMITIVE (self->method) = syx_small_integer_new (-2);
          syx_lexer_next_token (self->lexer);
          return;
        }

      if (! (token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "plugin:")))
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected plugin:"));
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (token.type != SYX_TOKEN_STR_CONST)
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected a string containing the plugin name"));
      syx_bytecode_gen_literal (self->bytecode, syx_symbol_new (token.value.string));
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ">")))
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected >"));
      syx_token_free (token);

      syx_lexer_next_token (self->lexer);

      SYX_METHOD_PRIMITIVE(self->method) = syx_small_integer_new (-2);
    }
  else
    syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected primitive or cCall"));

  return;
}

static void
_syx_parser_parse_temporaries (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  SyxParserScope *scope = self->_temporary_scopes + self->_temporary_scopes_top;

  if (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "|"))
    {
      syx_token_free (token);
      token = syx_lexer_next_token (self->lexer);
      while (token.type == SYX_TOKEN_NAME_CONST)
        {
          scope->stack[scope->top++] = syx_strdup (token.value.string);
          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
        }
      if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "|")))
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Temporary list not terminated by bar"));
      syx_token_free (token);

      syx_lexer_next_token (self->lexer);
    }
    
  /* we choose the maximum number so we can hold all the temporaries without forgetting
     previous parsed optimized blocks. */
  if (SYX_IS_NIL (SYX_CODE_TEMPORARIES_COUNT (self->method))
      || scope->top > SYX_SMALL_INTEGER (SYX_CODE_TEMPORARIES_COUNT (self->method)))
    SYX_CODE_TEMPORARIES_COUNT(self->method) = syx_small_integer_new (scope->top);
}

static void
_syx_parser_parse_body (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  while (TRUE)
    {
      while (token.type == SYX_TOKEN_CLOSING)
        {
          if (self->_in_block && token.value.character == ']')
            return;
          
          if (token.value.character == '.')
            {
              token = syx_lexer_next_token (self->lexer);
              /* Do not pop from the stack multiple times */
              if (token.type != SYX_TOKEN_CLOSING && token.type != SYX_TOKEN_END)
                syx_bytecode_pop_top (self->bytecode);
            }
          else
            token = syx_lexer_next_token (self->lexer);
        }

      if (token.type == SYX_TOKEN_END)
        break;

      _syx_parser_parse_statement (self);
      token = syx_lexer_get_last_token (self->lexer);
    }

  if (self->_in_block)
    syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected ] after block body"));
}

static void
_syx_parser_parse_statement (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  if (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "^"))
    {
      syx_token_free (token);
      syx_lexer_next_token (self->lexer);
      _syx_parser_parse_expression (self);
      syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_STACK_RETURN);
    }
  else
    _syx_parser_parse_expression (self);
}

static void
_syx_parser_parse_expression (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_string assign_name;
  syx_bool super_term = FALSE;

  if (token.type == SYX_TOKEN_NAME_CONST)
    {
      assign_name = syx_strdup (token.value.string);
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ":="))
        {
          syx_token_free (token);
          syx_lexer_next_token (self->lexer);
          _syx_parser_parse_assignment (self, assign_name);
        }
      else /* Not an assignment, let it be a name term then */
        super_term = _syx_parser_parse_name_term (self, assign_name);

      syx_free (assign_name);
    }
  else
    super_term = _syx_parser_parse_term (self);

  /* After we got the initial object, we can do message continuation on it
     specifying if 'super' has been requested instead of self */
  _syx_parser_do_continuation (self, super_term);
}

static void
_syx_parser_parse_assignment (SyxParser *self, syx_symbol assign_name)
{
  syx_varsize pos;
  SyxOop binding;

  pos = _syx_parser_find_temporary_name (self, assign_name);
  if (pos >= 0)
    {
      _syx_parser_parse_expression (self);
      syx_bytecode_assign_temporary (self->bytecode, pos);
      return;
    }

  pos = _syx_parser_find_instance_name (self, assign_name);
  if (pos >= 0)
    {
      _syx_parser_parse_expression (self);
      syx_bytecode_assign_instance (self->bytecode, pos);
      return;
    }

  binding = _syx_parser_find_class_variable_name (self, assign_name);
  if (!SYX_IS_NIL (binding))
    {
      _syx_parser_parse_expression (self);
      syx_bytecode_assign_binding_variable (self->bytecode, binding);
      return;
    }
  
  syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unassignable variable named: %s\n", assign_name));
}

static void
_syx_parser_do_continuation (SyxParser *self, syx_bool super_receiver)
{
  SyxToken token;
  self->_duplicate_indexes_top++;

  super_receiver = _syx_parser_do_key_continuation (self, super_receiver);
  
  token = syx_lexer_get_last_token (self->lexer);
  while (token.type == SYX_TOKEN_CLOSING && token.value.character == ';')
    {
      syx_bytecode_duplicate_at (self->bytecode, self->_duplicate_indexes[self->_duplicate_indexes_top - 1]);
      syx_bytecode_pop_top (self->bytecode);
      syx_token_free (token);
      syx_lexer_next_token (self->lexer);
      _syx_parser_do_key_continuation (self, super_receiver);
      token = syx_lexer_get_last_token (self->lexer);
    }

  self->_duplicate_indexes_top--;
}

static syx_varsize
_syx_parser_parse_optimized_block (SyxParser *self, SyxBytecodeSpecial branch_type, syx_bool do_pop)
{
  syx_int8 scope_top;
  syx_uint16 jump;
  syx_bool block_state;
  SyxToken token;
  syx_int32 i;

  syx_bytecode_do_special (self->bytecode, branch_type);
  syx_bytecode_gen_code (self->bytecode, 0);
  jump = self->bytecode->code_top - 1;

  if (do_pop)
    syx_bytecode_pop_top (self->bytecode);
  
  block_state = self->_in_block;
  self->_in_block = TRUE;

  token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "["))
    {
      syx_token_free (token);
      syx_lexer_next_token (self->lexer);
      /* we need to restore the current scope after the optimized block has been parsed */
      scope_top = self->_temporary_scopes[self->_temporary_scopes_top].top;
      _syx_parser_parse_temporaries (self);
      _syx_parser_parse_body (self);
      for (i=scope_top; i < self->_temporary_scopes[self->_temporary_scopes_top].top; i++)
        syx_free (self->_temporary_scopes[self->_temporary_scopes_top].stack[i]);
      self->_temporary_scopes[self->_temporary_scopes_top].top = scope_top;
      token = syx_lexer_next_token (self->lexer);
    }
  else
    {
      /* a variable or such has been used, like ifTrue: trueBlock */
      _syx_parser_do_binary_continuation (self, _syx_parser_parse_term (self), FALSE);
      syx_bytecode_gen_message (self->bytecode, FALSE, 0, "value");
    }

  self->_in_block = block_state;
  self->bytecode->code[jump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
  return jump;
}

static syx_bool
_syx_parser_do_key_continuation (SyxParser *self, syx_bool super_receiver)
{
  SyxToken token;
  syx_char selector[256] = {0};
  syx_int8 num_args;
  syx_bool super_term;
  syx_uint16 jump, conditionJump, loopJump;
  SyxBytecodeSpecial branchType;

  super_receiver = _syx_parser_do_binary_continuation (self, super_receiver, TRUE);

  token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_NAME_COLON)
    {
      self->_duplicate_indexes[self->_duplicate_indexes_top - 1] = self->bytecode->code_top;
      
      if (!strcmp (token.value.string, "ifTrue:"))
        {
          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
          jump = _syx_parser_parse_optimized_block (self, SYX_BYTECODE_BRANCH_IF_TRUE, FALSE);

          token = syx_lexer_get_last_token (self->lexer);
          if (token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "ifFalse:"))
            {
              syx_token_free (token);
              token = syx_lexer_next_token (self->lexer);
              
              /* skip ifFalse: block if condition is true */
              syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_BRANCH);
              syx_bytecode_gen_code (self->bytecode, 0);
              conditionJump = self->bytecode->code_top - 1;

              /* jump here if condition is false */
              self->bytecode->code[jump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
              jump = _syx_parser_parse_optimized_block (self, SYX_BYTECODE_BRANCH, TRUE);
              /* We don't need any jump after ifFalse: */
              self->bytecode->code[jump] = 0;

              /* jump here if condition was true */
              self->bytecode->code[conditionJump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
            }

          return FALSE;
        }
      else if (!strcmp (token.value.string, "ifFalse:"))
        {
          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
          jump = _syx_parser_parse_optimized_block (self, SYX_BYTECODE_BRANCH_IF_FALSE, FALSE);

          token = syx_lexer_get_last_token (self->lexer);
          if (token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "ifTrue:"))
            {
              syx_token_free (token);
              token = syx_lexer_next_token (self->lexer);

              /* skip ifTrue: block if condition is false */
              syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_BRANCH);
              syx_bytecode_gen_code (self->bytecode, 0);
              conditionJump = self->bytecode->code_top - 1;

              /* jump here if condition is true */
              self->bytecode->code[jump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
              jump = _syx_parser_parse_optimized_block (self, SYX_BYTECODE_BRANCH, TRUE);
              /* We don't need any jump after ifFalse: */
              self->bytecode->code[jump] = 0;

              /* jump here if condition was false */
              self->bytecode->code[conditionJump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
            }

          return FALSE;
        }
      else if (!strcmp (token.value.string, "whileTrue:") || !strcmp (token.value.string, "whileFalse:"))
        {
          if (!strcmp (token.value.string, "whileTrue:"))
            branchType = SYX_BYTECODE_BRANCH_IF_TRUE;
          else
            branchType = SYX_BYTECODE_BRANCH_IF_FALSE;

          syx_token_free (token);
          token = syx_lexer_next_token (self->lexer);
          loopJump = self->bytecode->code_top;
          syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_DUPLICATE);
          syx_bytecode_gen_message (self->bytecode, FALSE, 0, "value");
          conditionJump = _syx_parser_parse_optimized_block (self, branchType, FALSE);
          syx_bytecode_pop_top (self->bytecode);
          syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_BRANCH);
          syx_bytecode_gen_code (self->bytecode, loopJump);
          self->bytecode->code[conditionJump] = SYX_COMPAT_SWAP_16 (self->bytecode->code_top);
          syx_bytecode_pop_top (self->bytecode);

          return FALSE;
        }

      num_args = 0;
      while (token.type == SYX_TOKEN_NAME_COLON)
        {
          strcat (selector, token.value.string);
          num_args++;
          syx_token_free (token);
          syx_lexer_next_token (self->lexer);

          super_term = _syx_parser_parse_term (self);
          _syx_parser_do_binary_continuation (self, super_term, FALSE);

          token = syx_lexer_get_last_token (self->lexer);
        }

      syx_bytecode_gen_message (self->bytecode, super_receiver, num_args, selector);

      return FALSE;
    }
  return super_receiver;
}

static syx_bool
_syx_parser_do_binary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade)
{
  syx_string selector;
  SyxToken token;
  syx_bool super_term;

  super_receiver = _syx_parser_do_unary_continuation (self, super_receiver, do_cascade);

  token = syx_lexer_get_last_token (self->lexer);
  while (token.type == SYX_TOKEN_BINARY)
    {
      selector = syx_strdup (token.value.string);
      
      if (do_cascade)
        {
          self->_duplicate_indexes[self->_duplicate_indexes_top - 1] = self->bytecode->code_top;
          do_cascade = FALSE;
        }

      syx_token_free (token);
      syx_lexer_next_token (self->lexer);
      super_term = _syx_parser_parse_term (self);
      _syx_parser_do_unary_continuation (self, super_term, FALSE);
      token = syx_lexer_get_last_token (self->lexer);

      syx_bytecode_gen_message (self->bytecode, super_receiver, 1, selector);
      syx_free (selector);
    }

  return super_receiver;
}

static syx_bool
_syx_parser_do_unary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  while (token.type == SYX_TOKEN_NAME_CONST)
    {
      if (do_cascade)
        self->_duplicate_indexes[self->_duplicate_indexes_top - 1] = self->bytecode->code_top;

      syx_bytecode_gen_message (self->bytecode, super_receiver,
                                0, token.value.string);
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      super_receiver = FALSE;
    }

  return super_receiver;
}

static void
_syx_parser_parse_block (SyxParser *self)
{
  SyxOop closure;
  SyxOop old_method = self->method;
  SyxBytecode *old_bytecode = self->bytecode;
  syx_bool block_state = self->_in_block;
  syx_token_free (syx_lexer_get_last_token (self->lexer));

  self->method = syx_block_new ();
  self->bytecode = syx_bytecode_new ();
  self->_in_block = TRUE;
  self->_temporary_scopes_top++;
  self->_argument_scopes_top++;

  syx_parser_parse (self, FALSE);

  closure = syx_block_closure_new (self->method);
  self->method = old_method;
  syx_bytecode_free (self->bytecode);
  self->bytecode = old_bytecode;
  self->_in_block = block_state;
  self->_temporary_scopes_top--;
  self->_argument_scopes_top--;

  syx_bytecode_push_block_closure (self->bytecode, closure);
}

static void
_syx_parser_parse_array (SyxParser *self)
{
  syx_varsize num_elements = 0;
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  syx_token_free (token);
  token = syx_lexer_next_token (self->lexer);
  while (! (token.type == SYX_TOKEN_END || (token.type == SYX_TOKEN_CLOSING && token.value.character == '}')))
    {
      _syx_parser_parse_expression (self);
      num_elements++;
      token = syx_lexer_get_last_token (self->lexer);
      if (token.type == SYX_TOKEN_CLOSING && token.value.character == '.')
        token = syx_lexer_next_token (self->lexer);
    }

  syx_bytecode_push_array (self->bytecode, num_elements);
}

static SyxOop 
_syx_parser_parse_literal_array (SyxParser *self)
{
  SyxOop elements[256];
  syx_varsize top = 0;
  SyxToken token;

  token = syx_lexer_next_token (self->lexer);
  while (! (token.type == SYX_TOKEN_END || (token.type == SYX_TOKEN_CLOSING && token.value.character == ')')))
    {
      switch (token.type)
        {
        case SYX_TOKEN_ARRAY_BEGIN:
          elements[top++] = _syx_parser_parse_literal_array (self);
          break;
        case SYX_TOKEN_INT_CONST:
          elements[top++] = syx_small_integer_new (token.value.integer);
          break;
        case SYX_TOKEN_BINARY:
          if (!strcmp (token.value.string, "("))
            {
              elements[top++] = _syx_parser_parse_literal_array (self);
              syx_token_free (token);
              break;
            }
        case SYX_TOKEN_NAME_CONST:
        case SYX_TOKEN_NAME_COLON:
        case SYX_TOKEN_SYM_CONST:
          elements[top++] = syx_symbol_new (token.value.string);
          syx_token_free (token);
          break;
        case SYX_TOKEN_STR_CONST:
          elements[top++] = syx_string_new (token.value.string);
          syx_token_free (token);
          break;
        case SYX_TOKEN_CHAR_CONST:
          elements[top++] = syx_character_new (token.value.character);
          break;
        default:
          syx_signal (SYX_ERROR_INTERP, syx_string_new ("Illegal text in literal array\n"));
          break;
        }

      token = syx_lexer_next_token (self->lexer);
    }

  return syx_array_new_ref (top, elements);
}

static void
_syx_parser_parse_method_message_pattern (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_char selector[0xFF] = {0};
  SyxParserScope *scope = self->_argument_scopes + self->_argument_scopes_top;

  switch (token.type)
    {
    case SYX_TOKEN_NAME_CONST:
      /* Unary message pattern */
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (token.value.string);
      syx_token_free (token);

      syx_lexer_next_token (self->lexer);
      break;
    case SYX_TOKEN_BINARY:
      /* Binary message pattern */
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (token.value.string);
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
      if (token.type != SYX_TOKEN_NAME_CONST)
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected name constant for argument name\n"));
      scope->stack[scope->top++] = syx_strdup (token.value.string);
      syx_token_free (token);

      syx_lexer_next_token (self->lexer);
      break;
    case SYX_TOKEN_NAME_COLON:
      /* Keyword message pattern */
      while (token.type == SYX_TOKEN_NAME_COLON)
        {
          strcat (selector, token.value.string);
          syx_token_free (token);

          token = syx_lexer_next_token (self->lexer);
          if (token.type != SYX_TOKEN_NAME_CONST)
            syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected name constant for argument name\n"));
          scope->stack[scope->top++] = syx_strdup (token.value.string);
          syx_token_free (token);

          token = syx_lexer_next_token (self->lexer);
        }
      
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (selector);
      break;
    default:
      syx_signal (SYX_ERROR_INTERP, syx_string_new ("Invalid message pattern\n"));
    }

  SYX_CODE_ARGUMENTS_COUNT(self->method) = syx_small_integer_new (scope->top);
}

static void
_syx_parser_parse_block_message_pattern (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  SyxParserScope *scope = self->_argument_scopes + self->_argument_scopes_top;

  if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ":")))
    {
      SYX_CODE_ARGUMENTS_COUNT(self->method) = syx_small_integer_new (0);
      return;
    }

  while (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, ":"))
    {
      syx_token_free (token);
      token = syx_lexer_next_token (self->lexer);
      assert (token.type == SYX_TOKEN_NAME_CONST);
      scope->stack[scope->top++] = syx_strdup (token.value.string);
      syx_token_free (token);

      token = syx_lexer_next_token (self->lexer);
    }

  if (! (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "|")))
    syx_signal (SYX_ERROR_INTERP, syx_string_new ("Expected | after block message pattern\n"));

  syx_token_free (token);
  syx_lexer_next_token (self->lexer);

  SYX_CODE_ARGUMENTS_COUNT(self->method) = syx_small_integer_new (scope->top);
  return;
}

static void
_syx_parser_parse_message_pattern (SyxParser *self)
{
  if (self->_in_block)
    _syx_parser_parse_block_message_pattern (self);
  else
    _syx_parser_parse_method_message_pattern (self);
}
