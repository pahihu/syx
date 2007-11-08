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
#include "syx-interp.h"
#include "syx-lexer.h"
#include "syx-scheduler.h"
#include "syx-memory.h"

#include <stdio.h>
#include <string.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <ctype.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifdef HAVE_SYS_TIME_H
  #include <sys/time.h>
#endif

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
	  syx_error ("First letter must be uppercase\n");
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
      syx_error ("Expected a name constant\n");
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
      syx_error ("Expected #subclass:\n");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_SYM_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a symbol constant\n");
      return FALSE;
    }

  subclass_name = syx_strdup (token.value.string);
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
	      syx_array_remove (SYX_CLASS_SUBCLASSES (SYX_CLASS_SUPERCLASS (subclass)),
				subclass);
	      SYX_CLASS_SUPERCLASS(subclass) = superclass;
	      syx_array_add (SYX_CLASS_SUBCLASSES (superclass), subclass, TRUE);

	      syx_array_remove (SYX_CLASS_SUBCLASSES (SYX_CLASS_SUPERCLASS(syx_object_get_class (subclass))),
				syx_object_get_class (subclass));
	      SYX_CLASS_SUPERCLASS(syx_object_get_class (subclass)) = syx_object_get_class (superclass);
	      syx_array_add (SYX_CLASS_SUBCLASSES (syx_object_get_class (superclass)),
			     syx_object_get_class (subclass), TRUE);
	    }
	}
    }

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_COLON)
    {
      syx_token_free (token);
      syx_error ("Expected #instanceVariableNames:\n");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a string as argument for #instanceVariableNames:\n");
      return FALSE;
    }
  inst_vars_lexer = syx_lexer_new (token.value.string);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_COLON)
    {
      syx_token_free (token);
      syx_error ("Expected #classVariableNames:\n");
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      syx_token_free (token);
      syx_error ("Expected a string as argument for #classVariableNames:\n");
      return FALSE;
    }
  class_vars_lexer = syx_lexer_new (token.value.string);

  token = syx_lexer_next_token (lexer);
  if (!_IS_EXL_MARK (token))
    {
      syx_token_free (token);
      syx_error ("Class definition must terminate with an exlamation mark\n");
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

  /* Parse instance variables */
  inst_vars = _syx_cold_parse_vars (inst_vars_lexer, FALSE);
  syx_lexer_free (inst_vars_lexer, TRUE);

  /* Fetch superclass instanceSize */
  if (SYX_IS_NIL (superclass))
    super_inst_vars_size = 0;
  else
    super_inst_vars_size = SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE (superclass));

  SYX_CLASS_INSTANCE_VARIABLES(subclass) = inst_vars;
  SYX_CLASS_INSTANCE_SIZE(subclass) = syx_small_integer_new (super_inst_vars_size
							     + SYX_OBJECT_DATA_SIZE (inst_vars));

  /* Now parse class variables */
  class_vars = _syx_cold_parse_vars (class_vars_lexer, TRUE);
  syx_lexer_free (class_vars_lexer, TRUE);

  SYX_CLASS_CLASS_VARIABLES(subclass) = syx_dictionary_new (SYX_OBJECT_DATA_SIZE (class_vars) + 10); 

  /* translate from array to dictionary */
  for (i=0; i < SYX_OBJECT_DATA_SIZE(class_vars); i++)
    syx_dictionary_at_symbol_put (SYX_CLASS_CLASS_VARIABLES(subclass),
				  SYX_OBJECT_DATA(class_vars)[i], syx_nil);
  /* get rid of this */
  syx_object_free (class_vars);

  return TRUE;
}

syx_bool
syx_cold_parse_methods (SyxLexer *lexer)
{
  SyxToken token;
  SyxOop klass;
  SyxParser *parser;
  SyxLexer *method_lexer;
  /*syx_symbol category; */
  syx_string chunk;
  SyxLexer saved_lexer = *lexer;

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_NAME_CONST)
    {
      *lexer = saved_lexer;
      return FALSE;
    }

  klass = syx_globals_at (token.value.string);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type == SYX_TOKEN_NAME_CONST && !strcmp (token.value.string, "class"))
    {
      klass = syx_object_get_class (klass);
      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }

  if (! (token.type == SYX_TOKEN_NAME_COLON && !strcmp (token.value.string, "methodsFor:")))
    {
      *lexer = saved_lexer;
      return FALSE;
    }
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      *lexer = saved_lexer;
      return FALSE;
    }

  /*  category = syx_strdup (token.value.string); */
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  if (!_IS_EXL_MARK (token))
    {
      *lexer = saved_lexer;
      return FALSE;
    }
  syx_token_free (token);

  if (SYX_IS_NIL (SYX_CLASS_METHODS (klass)))
    {
      SYX_CLASS_METHODS(klass) = syx_dictionary_new (50);
    }

  while (TRUE)
    {
      chunk = syx_lexer_next_chunk (lexer);
      method_lexer = syx_lexer_new (chunk);
      if (!method_lexer)
	break;

      parser = syx_parser_new (method_lexer, syx_method_new (), klass);
      syx_parser_parse (parser, FALSE);

      syx_dictionary_at_symbol_put (SYX_CLASS_METHODS(klass),
				    SYX_METHOD_SELECTOR(parser->method),
				    parser->method);

      syx_parser_free (parser, TRUE);
    }
  
  return TRUE;
}

/*!
  Parse simple declarations like classes and methods.

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
	parseOk = syx_cold_parse_methods (lexer);
      else
	parseOk = _syx_cold_parse_class (lexer);

      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }
  
  syx_token_free (token);
  return parseOk;
}

/*!
  Parse a declaration file.

  \return TRUE if no error has occurred
*/
syx_bool
syx_cold_file_in (syx_symbol filename)
{
  SyxLexer *lexer;
  syx_string buffer;
  syx_int32 fd, count;
  syx_size size;
#ifdef HAVE_FSTAT
  struct stat statbuf;
#endif
  
  if ((fd = open (filename, O_RDONLY)) < 0)
     {
	syx_error ("can't open %s\n", filename);
	return FALSE;
     }
#ifdef HAVE_FSTAT
  if ((fstat (fd, &statbuf)) < 0)
     {
	syx_error ("can't obtain size of %s\n", filename);
	return FALSE;
     }
  size = statbuf.st_size;
#else
  size = 1000000;
#endif

  buffer = (syx_string) syx_malloc (size + 1);
  count = read (fd, buffer, size);
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

/*!
  Send a signal to a Semaphore to wake up waiting processes.

  The function is thread-safe
*/
void
syx_semaphore_signal (SyxOop semaphore)
{
  SyxOop signals;
  SyxOop list;
  syx_int32 i=0;
    
  /* wait */
  while (_syx_sem_lock != 0);
  /* acquire */
  _syx_sem_lock++;

  list = SYX_SEMAPHORE_LIST(semaphore);
  signals = SYX_SMALL_INTEGER (SYX_SEMAPHORE_SIGNALS(semaphore));
  signals++;

  while (signals > 0 && SYX_OBJECT_DATA_SIZE (list) > 0)
    {
      SYX_PROCESS_SUSPENDED (SYX_OBJECT_DATA(list)[i]) = syx_false;
      signals--;
      i++;
    }

  /* create a new array without signaled processes */
  SYX_SEMAPHORE_LIST(semaphore) = syx_array_new_ref (SYX_OBJECT_DATA_SIZE(list) - i,
						     SYX_OBJECT_DATA(list) + i);
  SYX_SEMAPHORE_SIGNALS(semaphore) = syx_small_integer_new (signals);

  /* release */
  _syx_sem_lock--;
}

/*!
  Put the active process in waiting state until semaphore is signaled.

  The function is thread-safe
*/
void
syx_semaphore_wait (SyxOop semaphore)
{
  SyxOop process;
  SyxOop list;

  /* wait */
  while (_syx_sem_lock != 0);
  /* acquire */
  _syx_sem_lock++;

  list = SYX_SEMAPHORE_LIST (semaphore);
  
  process = syx_processor_active_process;
  SYX_PROCESS_SUSPENDED (process) = syx_true;
  syx_object_grow_by (list, 1);
  SYX_OBJECT_DATA(list)[SYX_OBJECT_DATA_SIZE(list) - 1] = process;

  /* release */
  _syx_sem_lock--;
}

/* Utilities to interact with Smalltalk */

/*! Create a MethodContext for a unary message ready to enter a Process */
SyxOop
syx_send_unary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector)
{
  SyxOop context;
  SyxOop klass;
  SyxOop method;

  klass = syx_object_get_class (receiver);
  method = syx_class_lookup_method (klass, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OOP_CAST_POINTER (klass));

  context = syx_method_context_new (parent_context, method, receiver, syx_nil);
  return context;
}

/*! Create a MethodContext for a binary message ready to enter a Process */
SyxOop
syx_send_binary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, SyxOop argument)
{
  SyxOop context;
  SyxOop klass;
  SyxOop method;
  SyxOop arguments;

  klass = syx_object_get_class (receiver);
  method = syx_class_lookup_method (klass, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OOP_CAST_POINTER (klass));

  syx_memory_gc_begin ();
  arguments = syx_array_new_size (1);
  SYX_OBJECT_DATA(arguments)[0] = argument;
  context = syx_method_context_new (parent_context, method, receiver, arguments);
  syx_memory_gc_end ();

  return context;
}

/*!
  Create a MethodContext for an arbitrary message ready to enter a Process.

  \param num_args number of variadic SyxOop arguments
*/
SyxOop
syx_send_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, syx_varsize num_args, ...)
{
  SyxOop context;
  va_list ap;

  va_start (ap, num_args);
  context = syx_vsend_message (parent_context, receiver, selector, num_args, ap);
  va_end (ap);

  return context;
}


/*!
  Create a MethodContext for an arbitrary message ready to enter a Process.

  \param arguments an Array of arguments
*/
SyxOop
syx_vsend_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, syx_int32 num_args, va_list ap)
{
  syx_varsize i;
  SyxOop context;
  SyxOop klass;
  SyxOop method;
  SyxOop arguments;

  if (num_args == 0)
    return syx_send_unary_message (parent_context, receiver, selector);

  klass = syx_object_get_class (receiver);
  method = syx_class_lookup_method (klass, selector);
  if (SYX_IS_NIL (method))
    syx_error ("Unable to lookup method #%s in class %p\n", selector, SYX_OOP_CAST_POINTER (klass));

  syx_memory_gc_begin ();

  arguments = syx_array_new_size (num_args);
  for (i=0; i < num_args; i++)
    SYX_OBJECT_DATA(arguments)[i] = va_arg (ap, SyxOop);

  context = syx_method_context_new (parent_context, method, receiver, arguments);

  syx_memory_gc_end ();

  return context;
}



/*!
  Files in a file in blocking mode. This function send a message to FileStream>>#fileIn:.

  \return Return the last returned object from the process
*/
SyxOop
syx_file_in_blocking (syx_symbol file)
{
  SyxOop context;
  SyxOop process;

  context = syx_send_binary_message (syx_nil,
				     syx_globals_at ("FileStream"),
				     "fileIn:",
				     syx_string_new (file));
  process = syx_process_new (context);
  syx_process_execute_blocking (process);
  return SYX_PROCESS_RETURNED_OBJECT (process);
}


/*!
  Do it in blocking mode. This function send a message to String>>#doIt.

  \return Return the last returned object from the process
*/
SyxOop
syx_do_it_blocking (syx_symbol code)
{
  SyxOop context;
  SyxOop process;

  context = syx_send_unary_message (syx_nil, syx_string_new (code), "doIt");
  process = syx_process_new (context);
  syx_process_execute_blocking (process);
  return SYX_PROCESS_RETURNED_OBJECT (process);
}


/*! Returns a syx_wstring from a syx_string */
syx_wstring
syx_to_wstring (syx_symbol s)
{
  syx_size size = strlen (s);
  syx_wstring ws = (syx_wstring) syx_calloc (size+1, sizeof (wchar_t));
  mbstowcs (ws, s, size);
  return ws;
}

/*! Returns a syx_string from a syx_wstring */
syx_string
syx_to_string (syx_wsymbol ws)
{
  syx_size size = wcslen (ws);
  syx_string s = (syx_string) syx_calloc (size+1, sizeof (syx_char));
  wcstombs (s, ws, size);
  return s;
}

/*! Returns the first index in the string that is not a whitespace */
syx_uint32
syx_find_first_non_whitespace (syx_symbol string)
{
  syx_uint32 i;
  for (i=0; *(string+i); i++)
    {
      if (!isspace (*(string+i)))
	return i;
    }

  return 0;
}

/*! Print to stdout the current execution state of the interpreter and the Process traceback */
void
syx_show_traceback (void)
{
  SyxExecState *es;
  SyxOop context, homecontext;
  syx_symbol traceformat;
  SyxOop classname;
  syx_symbol extraclass;
  SyxOop receiver;

  if (!syx_memory)
    {
      puts ("Can't print the memory state");
      return;
    }

  es = _syx_exec_state;

  puts ("Memory state:");
  printf("Memory size: %d\n", _syx_memory_size);
  printf("Freed memory top: %d\n", _syx_freed_memory_top);
  if (!_syx_memory_gc_trans_running)
    puts ("No GC transaction");
  else
    printf("GC transaction top: %d\n", _syx_memory_gc_trans_top);

  if (!es)
    {
      puts ("Can't print the execution state");
      return;
    }

  puts ("\nExecution state:");
  printf("Process: %p (memory index: %ld)\n",
	 SYX_OOP_CAST_POINTER (es->process),
	 SYX_MEMORY_INDEX_OF (es->process));
  printf("Context: %p (memory index: %ld)\n",
	 SYX_OOP_CAST_POINTER (es->context),
	 SYX_MEMORY_INDEX_OF (es->context));
  printf("Receiver: %p (memory index: %ld)\n",
	 SYX_OOP_CAST_POINTER (es->receiver),
	 SYX_MEMORY_INDEX_OF (es->receiver));
  printf("Arguments: %p\n", (syx_pointer) es->arguments);
  printf("Temporaries: %p\n", (syx_pointer) es->temporaries);
  printf("Stack: %p\n", (syx_pointer) es->stack);
  printf("Literals: %p\n", (syx_pointer) es->literals);
  printf("Bytecodes: %p (size: %d)\n", (syx_pointer) es->bytecodes, es->bytecodes_count);
  printf("Byteslice: %d\n", es->byteslice);
  printf("Instruction pointer: %d\n", es->ip);
  printf("Stack pointer: %d\n", es->sp);
  printf("Message receiver: %p (memory index: %ld)\n",
	 SYX_OOP_CAST_POINTER (es->message_receiver),
	 SYX_MEMORY_INDEX_OF (es->message_receiver));
  printf("Message arguments: %p (size: %d)\n",
	 (syx_pointer) es->message_arguments,
	 es->message_arguments_count);

  puts ("\nTraceback:");
  context = syx_interp_get_current_context ();
  while (!SYX_IS_NIL (context))
    {
      if (syx_object_get_class (context) == syx_block_context_class)
	{
	  homecontext = SYX_BLOCK_CONTEXT_OUTER_CONTEXT(context);
	  while (syx_object_get_class (homecontext) != syx_method_context_class)
	    homecontext = SYX_BLOCK_CONTEXT_OUTER_CONTEXT(homecontext);
	  traceformat = "%s%s>>%s[]\n";
	}
      else
	{
	  homecontext = context;
	  traceformat = "%s%s>>%s\n";
	}

      receiver = SYX_METHOD_CONTEXT_RECEIVER(context);
      classname = SYX_CLASS_NAME(syx_object_get_class(receiver));
      if (SYX_IS_NIL (classname))
	{
	  classname = SYX_CLASS_NAME(SYX_METACLASS_INSTANCE_CLASS(syx_object_get_class(receiver)));
	  extraclass = " class";
	}
      else
	extraclass = "";

      printf (traceformat,
	      SYX_OBJECT_SYMBOL(classname),
	      extraclass,
	      SYX_OBJECT_SYMBOL(SYX_METHOD_SELECTOR(SYX_METHOD_CONTEXT_METHOD(homecontext))));

      context = SYX_METHOD_CONTEXT_PARENT (context);
    }
}

