/* 
   Copyright (c) 2007 Luca Bruno

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

#include "syx-memory.h"
#include "syx-platform.h"
#include "syx-types.h"
#include "syx-object.h"
#include "syx-init.h"
#include "syx-scheduler.h"
#include "syx-error.h"
#include "syx-utils.h"
#include "syx-parser.h"
#include "syx-lexer.h"
#include "syx-scheduler.h"
#include "syx-memory.h"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifdef HAVE_STDARG_H
  #include <stdarg.h>
#endif

#ifdef HAVE_WINDOWS_H
  #include <windows.h>
#endif

#ifdef HAVE_LIBDL
  #include <dlfcn.h>
#endif

/*! \page syx_utils Syx Utils
    
    \section sec Description

    syx-utils.c: This module collects some useful functions like parsing class declarations and interfacing Smalltalk from C
*/

static syx_bool _syx_cold_parse_methods (SyxLexer *lexer);
static syx_bool _syx_cold_parse_class (SyxLexer *lexer);
static SyxOop _syx_cold_parse_vars (SyxLexer *lexer, syx_bool capitalized);
static syx_uint8 _syx_sem_lock = 0;

/* A cold parser */

#define _IS_EXL_MARK(token) (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "!"))

static SyxOop
_syx_cold_parse_vars (SyxLexer *lexer, syx_bool capitalized)
{
  SyxOop vars;
  SyxOop vars_raw[256];
  syx_varsize vars_size;
  SyxToken token;

  /* Fetch variable names using the lexer */
  token = syx_lexer_next_token (lexer);
  for (vars_size=0; token.type != SYX_TOKEN_END; vars_size++)
    {
      if (token.type != SYX_TOKEN_NAME_CONST)
	{
	  syx_token_free (token);
	  syx_error ("Expected names for variables\n");
	}

      if (capitalized && !isupper (token.value.string[0]))
	{
	  syx_token_free (token);
	  syx_error ("First letter must be uppercase");
	}

      vars_raw[vars_size] = syx_symbol_new (token.value.string);
      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }

  /* Create the array */
  vars = syx_array_new_size (vars_size);
  /* Copy out of the stack */
  memcpy (SYX_OBJECT_DATA (vars), vars_raw, sizeof (SyxOop ) * vars_size);

  return vars;
}

static syx_bool
_syx_cold_parse_class (SyxLexer *lexer)
{
  SyxToken token = syx_lexer_get_last_token (lexer);
  SyxOop superclass, subclass;
  syx_string subclass_name;
  syx_bool existing_class = TRUE;

  SyxOop inst_vars, class_vars;
  SyxLexer *inst_vars_lexer, *class_vars_lexer;
  syx_varsize super_inst_vars_size;
  syx_int32 i;

  if (token.type != SYX_TOKEN_NAME_CONST)
    {
      syx_error ("Expected a name constant");
      syx_token_free (token);
      return FALSE;
    }

  if (!strcmp (token.value.string, "nil"))
    superclass = syx_nil;
  else
    superclass = syx_globals_at (token.value.string);
  
  token = syx_lexer_next_token (lexer);
  if (!(token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "subclass:")))
    {
      syx_token_free (token);
      syx_error ("Expected #subclass:");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_SYM_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a symbol constant");
      return FALSE;
    }

  subclass_name = strdup (token.value.string);
  syx_token_free (token);
  subclass = syx_globals_at_if_absent (subclass_name, syx_nil);

  if (strcmp (subclass_name, "Object"))
    {
      if (SYX_IS_NIL (subclass))
	existing_class = FALSE;
      else
	{
	  existing_class = TRUE;
	  if (SYX_OOP_NE (SYX_CLASS_SUPERCLASS(subclass), superclass))
	    {
	      SYX_CLASS_SUPERCLASS(subclass) = superclass;
	      SYX_CLASS_SUPERCLASS(syx_object_get_class (subclass)) = syx_object_get_class (superclass);
	    }
	}
    }

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_COLON)
    {
      syx_token_free (token);
      syx_error ("Expected #instanceVariableNames:");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a string as argument for #instanceVariableNames:");
      return FALSE;
    }
  inst_vars_lexer = syx_lexer_new (token.value.string);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_COLON)
    {
      syx_token_free (token);
      syx_error ("Expected #classVariableNames:");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a string as argument for #classVariableNames:");
      return FALSE;
    }
  class_vars_lexer = syx_lexer_new (token.value.string);

  token = syx_lexer_next_token (lexer);
  if (!_IS_EXL_MARK (token))
    {
      syx_token_free (token);
      syx_error ("Class definition must terminate with an exlamation mark");
      return FALSE;
    }
  syx_token_free (token);

  if (!existing_class)
    {
      subclass = syx_class_new (superclass);
      SYX_CLASS_NAME(subclass) = syx_symbol_new (subclass_name);
      syx_globals_at_put (SYX_CLASS_NAME(subclass), subclass);
    }
  syx_free (subclass_name);

  // Parse instance variables
  inst_vars = _syx_cold_parse_vars (inst_vars_lexer, FALSE);
  syx_lexer_free (inst_vars_lexer, TRUE);

  // Fetch superclass instanceSize
  if (SYX_IS_NIL (superclass))
    super_inst_vars_size = 0;
  else
    super_inst_vars_size = SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE (superclass));

  SYX_CLASS_INSTANCE_VARIABLES(subclass) = inst_vars;
  SYX_CLASS_INSTANCE_SIZE(subclass) = syx_small_integer_new (super_inst_vars_size
							     + SYX_OBJECT_SIZE (inst_vars));

  // Now parse class variables
  class_vars = _syx_cold_parse_vars (class_vars_lexer, TRUE);
  syx_lexer_free (class_vars_lexer, TRUE);

  SYX_CLASS_CLASS_VARIABLES(subclass) = syx_dictionary_new (SYX_OBJECT_SIZE (class_vars)); 

  // translate from array to dictionary
  for (i=0; i < SYX_OBJECT_SIZE(class_vars); i++)
    syx_dictionary_at_const_put (SYX_CLASS_CLASS_VARIABLES(subclass),
				 SYX_OBJECT_DATA(class_vars)[i], syx_nil);
  // get rid of this
  syx_object_free (class_vars);

  return TRUE;
}

static syx_bool
_syx_cold_parse_methods (SyxLexer *lexer)
{
  SyxToken token;
  SyxOop class;
  SyxParser *parser;
  SyxLexer *method_lexer;
  //syx_symbol category;
  syx_string chunk;

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_CONST)
    return FALSE;

  class = syx_globals_at (token.value.string);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type == SYX_TOKEN_NAME_CONST && !strcmp (token.value.string, "class"))
    {
      class = syx_object_get_class (class);
      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }

  if (! (token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "methodsFor:")))
    return FALSE;
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    return FALSE;

  //  category = strdup (token.value.string);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (!_IS_EXL_MARK (token))
    return FALSE;
  syx_token_free (token);

  if (SYX_IS_NIL (SYX_CLASS_METHODS (class)))
    {
      SYX_CLASS_METHODS(class) = syx_dictionary_new (50);
    }

  while (TRUE)
    {
      chunk = syx_lexer_next_chunk (lexer);
      method_lexer = syx_lexer_new (chunk);
      if (!method_lexer)
	break;

      parser = syx_parser_new (method_lexer, syx_method_new (), class);
      syx_parser_parse (parser);

      syx_dictionary_at_const_put (SYX_CLASS_METHODS(class),
				   SYX_METHOD_SELECTOR(parser->method),
				   parser->method);

      syx_parser_free (parser, TRUE);
    }
  
  return TRUE;
}

//! Parse simple declarations like classes and methods
/*!
  \return TRUE if no error has occurred
*/
syx_bool
syx_cold_parse (SyxLexer *lexer)
{
  SyxToken token;
  syx_bool parseOk = TRUE;

  token = syx_lexer_next_token (lexer);
  while (parseOk && token.type != SYX_TOKEN_END)
    {
      if (_IS_EXL_MARK (token))
	parseOk = _syx_cold_parse_methods (lexer);
      else
	parseOk = _syx_cold_parse_class (lexer);

      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }
  
  syx_token_free (token);
  return parseOk;
}

//! Parse a declaration file
/*!
  \return TRUE if no error has occurred
*/
syx_bool
syx_cold_file_in (syx_symbol filename)
{
  SyxLexer *lexer;
  syx_string buffer;
  syx_int32 fd, count;
  struct stat statbuf;
  
  if ((fd = open (filename, O_RDONLY)) < 0)
     {
	syx_error ("can't open %s\n", filename);
	return FALSE;
     }
   
  if ((fstat (fd, &statbuf)) < 0)
     {
	syx_error ("can't obtain size of %s\n", filename);
	return FALSE;
     }

  buffer = syx_malloc (statbuf.st_size + 1);
  count = read (fd, buffer, statbuf.st_size);
  buffer[count - 1] = '\0';
   
  close (fd);
   
  lexer = syx_lexer_new (buffer);
  if (!lexer)
    {
      syx_free (buffer);
      return FALSE;
    }

  if (!syx_cold_parse (lexer))
    {
      syx_lexer_free (lexer, TRUE);
      return FALSE;
    }

  syx_lexer_free (lexer, TRUE);
  return TRUE;
}

//! Send a signal to a Semaphore to wake up waiting processes
/*!
  The function is thread-safe
*/
void
syx_semaphore_signal (SyxOop semaphore)
{
  // wait
  while (_syx_sem_lock != 0);
  // acquire
  _syx_sem_lock++;

  SyxOop signals;
  SyxOop list;
  syx_int32 i=0;

  list = SYX_SEMAPHORE_LIST(semaphore);
  signals = SYX_SMALL_INTEGER (SYX_SEMAPHORE_SIGNALS(semaphore));
  signals++;

  while (signals > 0 && SYX_OBJECT_SIZE (list) > 0)
    {
      SYX_PROCESS_SUSPENDED (SYX_OBJECT_DATA(list)[i]) = syx_false;
      signals--;
      i++;
    }

  // create a new array without signaled processes
  SYX_SEMAPHORE_LIST(semaphore) = syx_array_new_ref (SYX_OBJECT_SIZE(list) - i,
						     SYX_OBJECT_DATA(list) + i);
  SYX_SEMAPHORE_SIGNALS(semaphore) = syx_small_integer_new (signals);

  // release
  _syx_sem_lock--;
}

//! Put the active process in waiting state until semaphore is signaled
/*!
  The function is thread-safe
*/
void
syx_semaphore_wait (SyxOop semaphore)
{
  // wait
  while (_syx_sem_lock != 0);
  // acquire
  _syx_sem_lock++;

  SyxOop process;
  SyxOop list = SYX_SEMAPHORE_LIST (semaphore);
  
  process = syx_processor_active_process;
  SYX_PROCESS_SUSPENDED (process) = syx_true;
  syx_object_grow_by (list, 1);
  SYX_OBJECT_DATA(list)[SYX_OBJECT_SIZE(list) - 1] = process;

  // release
  _syx_sem_lock--;
}

/* Utilities to interact with Smalltalk */

//! Create a MethodContext for a unary message ready to enter a Process
inline SyxOop
syx_send_unary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector)
{
  SyxOop context;
  SyxOop class;
  SyxOop method;

  class = syx_object_get_class (receiver);
  method = syx_class_lookup_method (class, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OBJECT(class));

  context = syx_method_context_new (parent_context, method, receiver, syx_nil);
  return context;
}

//! Create a MethodContext for a binary message ready to enter a Process
inline SyxOop
syx_send_binary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, SyxOop argument)
{
  SyxOop context;
  SyxOop class;
  SyxOop method;
  SyxOop arguments;

  class = syx_object_get_class (receiver);
  method = syx_class_lookup_method (class, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OBJECT(class));

  syx_memory_gc_begin ();
  arguments = syx_array_new_size (1);
  SYX_OBJECT_DATA(arguments)[0] = argument;
  context = syx_method_context_new (parent_context, method, receiver, arguments);
  syx_memory_gc_end ();

  return context;
}

//! Create a MethodContext for an arbitrary message ready to enter a Process
/*!
  \param num_args number of variadic SyxOop arguments
*/
SyxOop
syx_send_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, syx_varsize num_args, ...)
{
  va_list ap;
  syx_varsize i;
  SyxOop context;
  SyxOop class;
  SyxOop method;
  SyxOop arguments;

  if (num_args == 0)
    return syx_send_unary_message (parent_context, receiver, selector);

  class = syx_object_get_class (receiver);
  method = syx_class_lookup_method (class, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OBJECT(class));

  syx_memory_gc_begin ();

  arguments = syx_array_new_size (num_args);
  va_start (ap, num_args);
  for (i=0; i < num_args; i++)
    SYX_OBJECT_DATA(arguments)[i] = va_arg (ap, SyxOop);

  context = syx_method_context_new (parent_context, method, receiver, arguments);

  syx_memory_gc_end ();

  return context;
}
