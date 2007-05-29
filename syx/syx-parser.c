#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include <string.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-bytecode.h"
#include "syx-parser.h"
#include "syx-interp.h"
#include "syx-utils.h"

static syx_varsize find_temporary_name (SyxParser *self, syx_symbol name);
static syx_varsize find_argument_name (SyxParser *self, syx_symbol name);
static syx_varsize find_instance_name (SyxParser *self, syx_symbol name);
static syx_bool parse_term (SyxParser *self, SyxToken token);
static syx_bool parse_name_term (SyxParser *self, syx_symbol name);

static void parse_message_pattern (SyxParser *self);
static void parse_block_message_pattern (SyxParser *self);
static void parse_method_message_pattern (SyxParser *self);

static void parse_primitive (SyxParser *self);
static void parse_temporaries (SyxParser *self);

static void parse_body (SyxParser *self);
static void parse_statement (SyxParser *self);
static void parse_expression (SyxParser *self);
static void parse_assignment (SyxParser *self, syx_symbol assign_name);
static void parse_block (SyxParser *self);
static void parse_array (SyxParser *self);
static SyxObject *parse_literal_array (SyxParser *self);
static void do_continuation (SyxParser *self, syx_bool super_receiver);
static syx_bool key_continuation (SyxParser *self, syx_bool super_receiver);
static syx_bool binary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade);
static syx_bool unary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade);

SyxParser *
syx_parser_new (SyxLexer *lexer, SyxObject *method, syx_symbol *instance_names, syx_bool in_block, SyxParser *parent_parser)
{
  SyxParser *self;
  g_return_val_if_fail (lexer != NULL, NULL);
  g_return_val_if_fail (SYX_IS_POINTER (method), NULL);
  
  self = syx_malloc (sizeof (SyxParser ));

  self->lexer = lexer;
  self->method = method;
  self->in_block = in_block;

  self->bytecode = syx_bytecode_new ();
  self->temporary_names = g_ptr_array_new ();
  self->argument_names = g_ptr_array_new ();
  self->instance_names = instance_names;
  self->parent_parser = parent_parser;
  self->duplicate_indexes = NULL;

  return self;
}

syx_bool
syx_parser_parse (SyxParser *self, GError **error)
{
  SyxToken token = SYX_TOKEN_INIT;

  syx_lexer_next_token (self->lexer, &token);
  if (token.type == SYX_TOKEN_END)
    return TRUE;

  parse_message_pattern (self);
  if (!self->in_block)
    parse_primitive (self);

  self->temporary_scopes = g_queue_new ();

  parse_temporaries (self);
  parse_body (self);
  syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_SELF_RETURN);

  SYX_METHOD_BYTECODES(self->method) = syx_array_new (self->bytecode->code->len,
						       (SyxObject **) self->bytecode->code->data);
  SYX_METHOD_LITERALS(self->method) = syx_array_new (self->bytecode->literals->len,
						     (SyxObject **) self->bytecode->literals->pdata);
  SYX_METHOD_ARGUMENTS_COUNT(self->method) = syx_small_integer_new (self->argument_names->len);
  SYX_METHOD_TEMPORARIES_COUNT(self->method) = syx_small_integer_new (self->temporary_names->len);
  SYX_METHOD_STACK_SIZE(self->method) = syx_small_integer_new (self->bytecode->stack_size + 1);

  return TRUE;
}

static syx_varsize
find_temporary_name (SyxParser *self, syx_symbol name)
{
  SyxParser *cur;
  syx_varsize pos, i, scope_index;
  syx_int32 *scope;
  g_return_val_if_fail (name != NULL, -1);

  for (cur=self, pos=0; cur; cur=cur->parent_parser)
    {
      scope = g_queue_peek_head (cur->temporary_scopes);
      for (scope_index=0; scope; scope_index++)
	{
	  for (i=scope[0]; i < scope[1]; i++)
	    {
	      if (!strcmp (cur->temporary_names->pdata[i], name))
		return pos+i+1;
	    }
	  scope = g_queue_peek_nth (cur->temporary_scopes, scope_index);
	}
      pos += cur->temporary_names->len;
    }

  return 0;
}

static syx_varsize
find_argument_name (SyxParser *self, syx_symbol name)
{
  SyxParser *cur;
  syx_varsize pos, i;
  g_return_val_if_fail (name != NULL, -1);

  for (cur=self, pos=0; cur; cur=cur->parent_parser)
    {
      for (i=0; i < cur->argument_names->len; i++, pos++)
	{
	  if (!g_strcasecmp (cur->argument_names->pdata[i], name))
	    return pos + 1;
	}
    }

  return 0;
}

static syx_varsize
find_instance_name (SyxParser *self, syx_symbol name)
{
  if (!self->instance_names)
    return 0;

  syx_varsize i;
  g_return_val_if_fail (name != NULL, FALSE);

  for (i=0; self->instance_names[i]; i++)
    {
      if (!g_strcasecmp (self->instance_names[i], name))
	return i + 1;
    }

  return 0;
}

static syx_bool
parse_term (SyxParser *self, SyxToken token)
{
  syx_bool super_term = FALSE;
  switch (token.type)
    {
    case SYX_TOKEN_NAME_CONST:
      super_term = parse_name_term (self, g_value_get_string (token.value));
      break;
    case SYX_TOKEN_STR_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_string_new (g_value_get_string (token.value)));
      break;
    case SYX_TOKEN_INT_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_small_integer_new (g_value_get_int (token.value)));
      break;
    case SYX_TOKEN_SYM_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_symbol_new (g_value_get_string (token.value)));
      break;
    case SYX_TOKEN_CHAR_CONST:
      syx_bytecode_push_literal (self->bytecode, syx_character_new (g_value_get_char (token.value)));
      break;
    case SYX_TOKEN_ARRAY_BEGIN:
      syx_bytecode_push_literal (self->bytecode, parse_literal_array (self));
      break;
    case SYX_TOKEN_BINARY:
      if (!G_VALUE_STRCMP (token.value, "("))
	{
	  syx_lexer_next_token (self->lexer, &token);
	  parse_expression (self);
	  token = syx_lexer_get_last_token (self->lexer);
	  if (! (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == ')'))
	    g_error ("Expected ) after sub expression");
	}
      else if (!G_VALUE_STRCMP (token.value, "["))
	parse_block (self);
      else if (!G_VALUE_STRCMP (token.value, "{"))
	parse_array (self);
      break;
    default:
      g_error ("Invalid expression start %s\n", g_value_get_string (token.value));
    }

  syx_lexer_next_token (self->lexer, &token);
  return super_term;
}

static syx_bool
parse_name_term (SyxParser *self, syx_symbol name)
{
  syx_varsize pos;

  if (!g_strcasecmp (name, "self") || !g_strcasecmp (name, "super"))
    {
      syx_bytecode_push_argument (self->bytecode, 0);
      if (!g_strcasecmp (name, "super"))
	return TRUE;
      return FALSE;
    }

  pos = find_argument_name (self, name);
  if (pos > 0)
    {
      syx_bytecode_push_argument (self->bytecode, pos);
      return FALSE;    
    }
  
  pos = find_temporary_name (self, name);
  if (pos > 0)
    {
      syx_bytecode_push_temporary (self->bytecode, pos - 1);
      return FALSE;
    }

  pos = find_instance_name (self, name);
  if (pos > 0)
    {
      syx_bytecode_push_instance (self->bytecode, pos - 1);
      return FALSE;
    }

  if (!g_strcasecmp (name, "nil"))
    syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_NIL);
  else if (!g_strcasecmp (name, "true"))
    syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_TRUE);
  else if (!g_strcasecmp (name, "false"))
    syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_FALSE);
  else if (!g_strcasecmp (name, "thisContext"))
    syx_bytecode_push_constant (self->bytecode, SYX_BYTECODE_CONST_CONTEXT);
  else
    syx_bytecode_push_global (self->bytecode, syx_symbol_new (name));

  return FALSE;
}

static void
parse_primitive (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_int32 prim_index;

  if (! (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, "<")))
    return;

  syx_lexer_next_token (self->lexer, &token);
  if (! (token.type == SYX_TOKEN_NAME_COLON && !G_VALUE_STRCMP (token.value, "primitive:")))
    g_error ("expected primitive:");

  syx_lexer_next_token (self->lexer, &token);
  if (token.type != SYX_TOKEN_STR_CONST)
    g_error ("expected a string containing the primitive to be called\n");

  prim_index = syx_primitive_get_index (g_value_get_string (token.value));
  if (prim_index < 0)
    g_error ("unknown primitive named %s\n", g_value_get_string (token.value));

  syx_lexer_next_token (self->lexer, &token);
  if (! (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, ">")))
    g_error ("expected >");

  syx_bytecode_gen_instruction (self->bytecode, SYX_BYTECODE_DO_PRIMITIVE, prim_index);
  
  syx_lexer_next_token (self->lexer, &token);
  return;
}

static void
parse_temporaries (SyxParser *self)
{
  syx_int32 *scope = g_new0 (syx_int32, 2);
  scope[0] = scope[1] = self->temporary_names->len;

  SyxToken token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, "|"))
    {
      syx_lexer_next_token (self->lexer, &token);
      while (token.type == SYX_TOKEN_NAME_CONST)
	{
	  g_ptr_array_add (self->temporary_names,
			   g_strdup (g_value_get_string (token.value)));
	  scope[1]++;
	  syx_lexer_next_token (self->lexer, &token);
	}
      if (! (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, "|")))
	g_error ("Temporary list not terminated by bar");
      syx_lexer_next_token (self->lexer, &token);
    }

  g_queue_push_head (self->temporary_scopes, scope);
}

static void
parse_body (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  syx_bool closed_brace = FALSE;

  while (token.type != SYX_TOKEN_END)
    {
      if (self->in_block && token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == ']')
	{
	  closed_brace = TRUE;
	  break;
	}
      
      parse_statement (self);
      
      token = syx_lexer_get_last_token (self->lexer);
      if (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == '.')
	{
	  syx_lexer_next_token (self->lexer, &token);
	  if (token.type == SYX_TOKEN_CLOSING || token.type == SYX_TOKEN_END)
	    continue;
	  syx_bytecode_pop_top (self->bytecode);
	}
    }

  if (self->in_block && !closed_brace)
    g_error ("Expected ] after block body\n");
}

static void
parse_statement (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, "^"))
    {
      syx_lexer_next_token (self->lexer, &token);
      parse_expression (self);
      syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_STACK_RETURN);
    }
  else
    parse_expression (self);
}

static void
parse_expression (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  gchar *assign_name;
  syx_bool super_term = FALSE;

  if (token.type == SYX_TOKEN_NAME_CONST)
    {
      assign_name = g_strdup (g_value_get_string (token.value));
      syx_lexer_next_token (self->lexer, &token);
      if (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, ":="))
	{
	  syx_lexer_next_token (self->lexer, &token);
	  parse_assignment (self, assign_name);
	  g_free (assign_name);
	}
      else // Not an assignment, let it be a name term then
	super_term = parse_name_term (self, assign_name);
    }
  else
    super_term = parse_term (self, token);
    
  /* After we got the initial object, we can do message continuation on it
     specifying if 'super' has been requested instead of self */

  do_continuation (self, super_term);
}

static void
parse_assignment (SyxParser *self, syx_symbol assign_name)
{
  syx_varsize pos;
  
  pos = find_temporary_name (self, assign_name);
  if (pos > 0)
    {
      parse_expression (self);
      syx_bytecode_assign_temporary (self->bytecode, pos - 1);
      return;
    }

  pos = find_instance_name (self, assign_name);
  if (pos > 0)
    {
      parse_expression (self);
      syx_bytecode_assign_instance (self->bytecode, pos - 1);
      return;
    }
  
  g_error ("unassignable variable named: %s\n", assign_name);
}

static void
do_continuation (SyxParser *self, syx_bool super_receiver)
{
  SyxToken token = SYX_TOKEN_INIT;
  glong index[2] = {0, 0};

  g_trash_stack_push (&self->duplicate_indexes, &index);
  super_receiver = key_continuation (self, super_receiver);
  
  token = syx_lexer_get_last_token (self->lexer);
  while (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == ';')
    {
      syx_bytecode_duplicate_at (self->bytecode, ((glong *)g_trash_stack_peek (&self->duplicate_indexes))[1]);
      syx_bytecode_pop_top (self->bytecode);
      syx_lexer_next_token (self->lexer, &token);
      key_continuation (self, super_receiver);
      token = syx_lexer_get_last_token (self->lexer);
    }

  (void) g_trash_stack_pop (&self->duplicate_indexes);
}

static void
save_duplicate_index (SyxParser *self)
{
  glong *last_index = (glong *)g_trash_stack_peek (&self->duplicate_indexes);
  last_index[1] = self->bytecode->code->len;
}

static gulong
parse_optimized_block (SyxParser *self, SyxBytecodeSpecial branch_type, syx_bool do_pop)
{
  gulong jump;
  syx_bool block_state;
  SyxToken token;

  syx_bytecode_do_special (self->bytecode, branch_type);
  syx_bytecode_gen_code (self->bytecode, 0);
  jump = self->bytecode->code->len - 1;

  if (do_pop)
    syx_bytecode_pop_top (self->bytecode);
  
  block_state = self->in_block;
  self->in_block = TRUE;

  token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, "["))
    {
      syx_lexer_next_token (self->lexer, &token);
      parse_temporaries (self);
      parse_body (self);
      g_queue_pop_head (self->temporary_scopes);
      syx_lexer_next_token (self->lexer, &token);
    }
  else
    {
      binary_continuation (self, parse_term (self, token), FALSE);
      syx_bytecode_gen_message (self->bytecode, FALSE, 0, syx_symbol_new ("value"));
    }

  self->in_block = block_state;
  self->bytecode->code->data[jump] = self->bytecode->code->len;
  return jump;
}

static syx_bool
key_continuation (SyxParser *self, syx_bool super_receiver)
{
  SyxToken token;
  GString *selector;
  guint num_args;
  syx_bool super_term;
  gulong jump, conditionJump, loopJump;

  super_receiver = binary_continuation (self, super_receiver, TRUE);

  token = syx_lexer_get_last_token (self->lexer);
  if (token.type == SYX_TOKEN_NAME_COLON)
    {
      save_duplicate_index (self);
      
      if (!G_VALUE_STRCMP (token.value, "ifTrue:"))
	{
	  syx_lexer_next_token (self->lexer, &token);
	  parse_optimized_block (self, SYX_BYTECODE_BRANCH_IF_TRUE, FALSE);

	  token = syx_lexer_get_last_token (self->lexer);
	  if (token.type == SYX_TOKEN_NAME_COLON && !G_VALUE_STRCMP (token.value, "ifFalse:"))
	    {
	      syx_lexer_next_token (self->lexer, &token);
	      jump = parse_optimized_block (self, SYX_BYTECODE_BRANCH, TRUE);
	      // We don't need any jump
	      self->bytecode->code->data[jump] = 0;
	    }

	  return FALSE;
	}
      else if (!G_VALUE_STRCMP (token.value, "ifFalse:"))
	{
	  syx_lexer_next_token (self->lexer, &token);
	  parse_optimized_block (self, SYX_BYTECODE_BRANCH_IF_FALSE, FALSE);

	  token = syx_lexer_get_last_token (self->lexer);
	  if (token.type == SYX_TOKEN_NAME_COLON && !G_VALUE_STRCMP (token.value, "ifTrue:"))
	    {
	      syx_lexer_next_token (self->lexer, &token);
	      jump = parse_optimized_block (self, SYX_BYTECODE_BRANCH, TRUE);
	      // We don't need any jump
	      self->bytecode->code->data[jump] = 0;
	    }

	  return FALSE;
	}
      else if (!G_VALUE_STRCMP (token.value, "whileTrue:"))
	{
	  syx_lexer_next_token (self->lexer, &token);
	  loopJump = self->bytecode->code->len;
	  syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_DUPLICATE);
	  syx_bytecode_gen_message (self->bytecode, FALSE, 0, syx_symbol_new ("value"));
	  conditionJump = parse_optimized_block (self, SYX_BYTECODE_BRANCH_IF_TRUE, FALSE);
	  syx_bytecode_pop_top (self->bytecode);
	  syx_bytecode_do_special (self->bytecode, SYX_BYTECODE_BRANCH);
	  syx_bytecode_gen_code (self->bytecode, loopJump);
	  self->bytecode->code->data[conditionJump] = self->bytecode->code->len;
	  syx_bytecode_pop_top (self->bytecode);

	  return FALSE;
	}

      selector = g_string_new (NULL);
      num_args = 0;
      while (token.type == SYX_TOKEN_NAME_COLON)
	{
	  g_string_append (selector, g_value_get_string (token.value));
	  num_args++;
	  syx_lexer_next_token (self->lexer, &token);

	  super_term = parse_term (self, token);
	  binary_continuation (self, super_term, FALSE);

	  token = syx_lexer_get_last_token (self->lexer);
	}

      syx_bytecode_gen_message (self->bytecode, super_receiver, num_args, syx_symbol_new (selector->str));
      g_string_free (selector, TRUE);
      return FALSE;
    }
  return super_receiver;
}

static syx_bool
binary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade)
{
  SyxObject *selector;
  SyxToken token;
  syx_bool super_term;

  super_receiver = unary_continuation (self, super_receiver, do_cascade);

  token = syx_lexer_get_last_token (self->lexer);
  while (token.type == SYX_TOKEN_BINARY)
    {
      selector = syx_symbol_new (g_value_get_string (token.value));
      
      if (do_cascade)
	save_duplicate_index (self);

      syx_lexer_next_token (self->lexer, &token);
      super_term = parse_term (self, token);
      unary_continuation (self, super_term, FALSE);
      token = syx_lexer_get_last_token (self->lexer);

      syx_bytecode_gen_message (self->bytecode, super_receiver, 1, selector);
    }

  return super_receiver;
}

static syx_bool
unary_continuation (SyxParser *self, syx_bool super_receiver, syx_bool do_cascade)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  while (token.type == SYX_TOKEN_NAME_CONST)
    {
      if (do_cascade)
	save_duplicate_index (self);

      syx_bytecode_gen_message (self->bytecode, super_receiver,
				0, syx_symbol_new (g_value_get_string (token.value)));
      syx_lexer_next_token (self->lexer, &token);
      super_receiver = FALSE;
    }

  return super_receiver;
}

static void
parse_block (SyxParser *self)
{
  SyxObject *closure;
  SyxObject *method = syx_block_new ();
  SyxParser *sub_parser = syx_parser_new (self->lexer, method, self->instance_names, TRUE, self);
  syx_parser_parse (sub_parser, NULL);

  closure = syx_block_closure_new (method);
  syx_bytecode_push_block_closure (self->bytecode, closure);
}

static void
parse_array (SyxParser *self)
{
  guint num_elements = 0;
  SyxToken token = SYX_TOKEN_INIT;

  syx_lexer_next_token (self->lexer, &token);
  while (! (token.type == SYX_TOKEN_END || (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == '}')))
    {
      parse_expression (self);
      num_elements++;
      token = syx_lexer_get_last_token (self->lexer);
      if (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == '.')
	syx_lexer_next_token (self->lexer, &token);
    }

  syx_bytecode_push_array (self->bytecode, num_elements);
}

static SyxObject *
parse_literal_array (SyxParser *self)
{
  GPtrArray *elements = g_ptr_array_new ();
  SyxToken token = SYX_TOKEN_INIT;

  syx_lexer_next_token (self->lexer, &token);
  while (! (token.type == SYX_TOKEN_END || (token.type == SYX_TOKEN_CLOSING && g_value_get_char (token.value) == ')')))
    {
      switch (token.type)
	{
	case SYX_TOKEN_ARRAY_BEGIN:
	  g_ptr_array_add (elements, parse_literal_array (self));
	  break;
	case SYX_TOKEN_INT_CONST:
	  g_ptr_array_add (elements, syx_small_integer_new (g_value_get_int (token.value)));
	  break;
	case SYX_TOKEN_BINARY:
	  if (!G_VALUE_STRCMP (token.value, "("))
	    {
	      g_ptr_array_add (elements, parse_literal_array (self));
	      break;
	    }
	case SYX_TOKEN_NAME_CONST:
	case SYX_TOKEN_NAME_COLON:
	case SYX_TOKEN_SYM_CONST:
	  g_ptr_array_add (elements, syx_symbol_new (g_value_get_string (token.value)));
	  break;
	case SYX_TOKEN_STR_CONST:
	  g_ptr_array_add (elements, syx_string_new (g_value_get_string (token.value)));
	  break;
	default:
	  g_error ("illegal text in literal array\n");
	  break;
	}

      syx_lexer_next_token (self->lexer, &token);
    }

  return syx_array_new (elements->len, elements->pdata);
}

static void
parse_method_message_pattern (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);
  GString *selector;

  switch (token.type)
    {
    case SYX_TOKEN_NAME_CONST:
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (g_value_get_string (token.value));
      syx_lexer_next_token (self->lexer, &token);
      break;
    case SYX_TOKEN_BINARY:
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (g_value_get_string (token.value));
      syx_lexer_next_token (self->lexer, &token);
      if (!token.type == SYX_TOKEN_NAME_CONST)
	g_error ("Expected name constant for argument name\n");
      g_ptr_array_add (self->argument_names, g_strdup (g_value_get_string (token.value)));

      syx_lexer_next_token (self->lexer, &token);
      break;
    case SYX_TOKEN_NAME_COLON:
      selector = g_string_new (NULL);
      while (token.type == SYX_TOKEN_NAME_COLON)
	{
	  g_string_append (selector, g_value_get_string (token.value));
	  syx_lexer_next_token (self->lexer, &token);
	  if (!token.type == SYX_TOKEN_NAME_CONST)
	    g_error ("Expected name constant for argument name\n");
	  g_ptr_array_add (self->argument_names, g_strdup (g_value_get_string (token.value)));

	  syx_lexer_next_token (self->lexer, &token);
	}
      SYX_METHOD_SELECTOR(self->method) = syx_symbol_new (selector->str);
      g_string_free (selector, TRUE);
      break;
    default:
      g_error ("Invalid message pattern\n");
    }
}

static void
parse_block_message_pattern (SyxParser *self)
{
  SyxToken token = syx_lexer_get_last_token (self->lexer);

  if (! (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, ":")))
    return;

  while (token.type == SYX_TOKEN_BINARY && !G_VALUE_STRCMP (token.value, ":"))
    {
      syx_lexer_next_token (self->lexer, &token);
      g_assert (token.type == SYX_TOKEN_NAME_CONST);
      g_ptr_array_add (self->argument_names, g_strdup (g_value_get_string (token.value)));

      syx_lexer_next_token (self->lexer, &token);
    }

  if (! (token.type == SYX_TOKEN_BINARY && !g_strcasecmp (g_value_get_string (token.value), "|")))
    g_error ("Expected | after block message pattern");

  syx_lexer_next_token (self->lexer, &token);
}

static void
parse_message_pattern (SyxParser *self)
{
  self->in_block ? parse_block_message_pattern (self) : parse_method_message_pattern (self);
}
