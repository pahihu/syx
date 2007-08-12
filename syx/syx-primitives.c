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

/* TODO: because of the class => my_class renaming in syx-config.h,
   in msvc we need to include this before including syx-config.h */
#include <math.h>

#include "syx-memory.h"
#include "syx-error.h"
#include "syx-types.h"
#include "syx-plugins.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-parser.h"
#include "syx-lexer.h"
#include "syx-interp.h"
#include "syx-utils.h"

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif

INLINE SyxOop 
_syx_block_context_new_from_closure (SyxExecState *es, SyxOop arguments)
{
  return syx_block_context_new (es->context,
				SYX_BLOCK_CLOSURE_BLOCK (es->message_receiver),
				arguments,
				SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(es->message_receiver));
}

/* This method is inlined in syx_interp_call_primitive */
SYX_FUNC_PRIMITIVE (Processor_yield)
{
  SYX_PRIM_YIELD (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Behavior_new)
{
  SYX_PRIM_RETURN (syx_object_new (es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Behavior_newColon)
{
  SYX_PRIM_ARGS(1);
  syx_varsize size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->message_receiver, TRUE, size));
}

SYX_FUNC_PRIMITIVE (ByteArray_newColon)
{
  SYX_PRIM_ARGS(1);
  syx_varsize size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->message_receiver, FALSE, size));
}

SYX_FUNC_PRIMITIVE (Object_class)
{
  SYX_PRIM_RETURN(syx_object_get_class (es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Object_at)
{
  SYX_PRIM_ARGS(1);
  syx_varsize index;
  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(SYX_OBJECT_DATA(es->message_receiver)[index]);
}

SYX_FUNC_PRIMITIVE (Object_at_put)
{
  SYX_PRIM_ARGS(2);
  syx_varsize index;
  SyxOop object;

  if (SYX_OBJECT_IS_CONSTANT (es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }

  object = es->message_arguments[1];
  SYX_OBJECT_DATA(es->message_receiver)[index] = object;

  SYX_PRIM_RETURN (object);
}

SYX_FUNC_PRIMITIVE (Object_resize)
{
  SYX_PRIM_ARGS(1);
  syx_varsize size;

  size = SYX_SMALL_INTEGER(es->message_arguments[0]);
  syx_object_resize (es->message_receiver, size);

  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Object_size)
{
  if (!SYX_IS_OBJECT (es->message_receiver))
    {
      SYX_PRIM_RETURN (syx_small_integer_new (0));
    }

  SYX_PRIM_RETURN (syx_small_integer_new (SYX_OBJECT_DATA_SIZE (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (Object_identityEqual)
{
  SYX_PRIM_ARGS(1);
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OOP_EQ (es->message_receiver, es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (Object_identityHash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_MEMORY_INDEX_OF (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (Object_hash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (syx_object_hash (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (Object_equal)
{
  SYX_PRIM_ARGS(1);
  SYX_PRIM_RETURN (syx_boolean_new (syx_object_hash (es->message_receiver) ==
				    syx_object_hash (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (Object_copy)
{
  SYX_PRIM_RETURN (syx_object_copy (es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Object_perform)
{
  SYX_PRIM_ARGS(1);
  SyxOop klass;
  SyxOop message_method;
  SyxOop context;
  SyxOop selector = es->message_arguments[0];
  SyxOop *message_arguments;
  syx_varsize message_arguments_count;
  syx_int32 primitive;
  syx_bool ret;

  klass = syx_object_get_class (es->message_receiver); 
  message_method = syx_class_lookup_method (klass, SYX_OBJECT_SYMBOL (selector));

  if (SYX_IS_NIL (message_method))
    {
      SYX_PRIM_FAIL;
    }

  // save the real state
  message_arguments = es->message_arguments;
  message_arguments_count = es->message_arguments_count;
  es->message_arguments_count--;
  if (!es->message_arguments_count)
    es->message_arguments = NULL;
  else
    es->message_arguments++;

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (message_method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    ret = syx_interp_call_primitive (primitive, message_method);
  else if (primitive == -2)
    ret = syx_plugin_call_interp (es, message_method);
  else
    {
      if (es->message_arguments_count > 0)
	{
	  syx_memory_gc_begin ();
	  context = syx_method_context_new (es->context, message_method, es->message_receiver,
					    syx_array_new_ref (es->message_arguments_count,
							       es->message_arguments));
	  syx_memory_gc_end ();
	}
      else
	context = syx_method_context_new (es->context, message_method, es->message_receiver, syx_nil);
      
      ret = syx_interp_enter_context (context);
    }

  // restore the state
  es->message_arguments = message_arguments;
  es->message_arguments_count = message_arguments_count;

  return ret;
}

SYX_FUNC_PRIMITIVE (Object_performWithArguments)
{
  SYX_PRIM_ARGS(2);
  SyxOop klass;
  SyxOop message_method;
  SyxOop context;
  SyxOop selector = es->message_arguments[0];
  SyxOop arguments = es->message_arguments[1];
  SyxOop args;
  SyxOop *message_arguments;
  syx_varsize message_arguments_count;
  syx_int32 primitive;
  syx_bool ret;

  klass = syx_object_get_class (es->message_receiver); 
  message_method = syx_class_lookup_method (klass, SYX_OBJECT_SYMBOL (selector));

  if (SYX_IS_NIL (message_method))
    {
      SYX_PRIM_FAIL;
    }

  // save the real state
  message_arguments = es->message_arguments;
  message_arguments_count = es->message_arguments_count;
  es->message_arguments_count = SYX_OBJECT_DATA_SIZE(arguments);
  if (!es->message_arguments_count)
    es->message_arguments = NULL;
  else
    es->message_arguments = SYX_OBJECT_DATA(arguments);

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (message_method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    ret = syx_interp_call_primitive (primitive, message_method);
  else if (primitive == -2)
    ret = syx_plugin_call_interp (es, message_method);
  else
    {
      if (SYX_OBJECT_DATA_SIZE (arguments) > 0)
	{
	  syx_memory_gc_begin ();
	  args = syx_array_new_ref (es->message_arguments_count, es->message_arguments);
	  context = syx_method_context_new (es->context, message_method,
					    es->message_receiver, args);
	  syx_memory_gc_end ();
	}
      else
	context = syx_method_context_new (es->context, message_method, es->message_receiver, syx_nil);

      ret = syx_interp_enter_context (context);
    }

  // restore the state
  es->message_arguments = message_arguments;
  es->message_arguments_count = message_arguments_count;

  return ret;
}

SYX_FUNC_PRIMITIVE (ArrayedCollection_replaceFromToWith)
{
  SYX_PRIM_ARGS(3);
  syx_varsize start = SYX_SMALL_INTEGER (es->message_arguments[0]) - 1;
  SyxOop coll = es->message_arguments[2];
  syx_varsize end = SYX_SMALL_INTEGER(es->message_arguments[1]);
  syx_varsize length = end - start;

  if (!SYX_IS_OBJECT (coll) || !SYX_OBJECT_DATA (coll))
    {
      SYX_PRIM_FAIL;
    }

  if (start >= end || end > SYX_OBJECT_DATA_SIZE (es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }

  if (length > SYX_OBJECT_DATA_SIZE (coll))
    {
      SYX_PRIM_FAIL;
    }

  // distinguish between arrays and bytearrays
  if (SYX_OBJECT_HAS_REFS (es->message_receiver))
    {
      if (SYX_OBJECT_HAS_REFS (coll))
	memcpy (SYX_OBJECT_DATA (es->message_receiver) + start, SYX_OBJECT_DATA (coll), length * sizeof (SyxOop));
      else
	{
	  SYX_PRIM_FAIL;
	}
    }
  else
    {
      if (!SYX_OBJECT_HAS_REFS (coll))
	memcpy (SYX_OBJECT_BYTE_ARRAY (es->message_receiver) + start,
		SYX_OBJECT_BYTE_ARRAY (coll), length * sizeof (syx_int8));
      else
	{
	  SYX_PRIM_FAIL;
	}
    }

  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (ByteArray_at)
{
  SYX_PRIM_ARGS(1);
  syx_varsize index;

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(syx_small_integer_new (SYX_OBJECT_BYTE_ARRAY(es->message_receiver)[index]));
}

SYX_FUNC_PRIMITIVE (ByteArray_at_put)
{
  SYX_PRIM_ARGS(2);
  syx_varsize index;
  SyxOop oop;

  if (SYX_OBJECT_IS_CONSTANT (es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }
  
  oop = es->message_arguments[1];
  if (!SYX_IS_SMALL_INTEGER (oop) || SYX_SMALL_INTEGER (oop) < 0 || SYX_SMALL_INTEGER (oop) > 255)
    {
      SYX_PRIM_FAIL;
    }
  SYX_OBJECT_BYTE_ARRAY(es->message_receiver)[index] = SYX_SMALL_INTEGER (oop);
  SYX_PRIM_RETURN (oop);
}

SYX_FUNC_PRIMITIVE (BlockClosure_asContext)
{
  SYX_PRIM_ARGS(1);
  SyxOop args;
  SyxOop ctx;
  syx_memory_gc_begin ();
  args = syx_array_new_ref (SYX_OBJECT_DATA_SIZE(es->message_arguments[0]), SYX_OBJECT_DATA(es->message_arguments[0]));
  ctx = _syx_block_context_new_from_closure (es, args);
  syx_memory_gc_end ();
  SYX_PRIM_RETURN (ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_value)
{
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_nil);
  return syx_interp_enter_context (ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_valueWith)
{
  SYX_PRIM_ARGS(1);
  SyxOop args;
  SyxOop ctx;

  syx_memory_gc_begin ();
  args = syx_array_new_size (1);
  SYX_OBJECT_DATA(args)[0] = es->message_arguments[0];
  ctx = _syx_block_context_new_from_closure (es, args);
  syx_memory_gc_end ();
  return syx_interp_enter_context (ctx);
}
  
SYX_FUNC_PRIMITIVE (BlockClosure_valueWithArguments)
{
  SYX_PRIM_ARGS(1);
  SyxOop args, ctx;
  syx_memory_gc_begin ();
  args = syx_array_new_ref (SYX_OBJECT_DATA_SIZE(es->message_arguments[0]), SYX_OBJECT_DATA(es->message_arguments[0]));
  ctx = _syx_block_context_new_from_closure (es, args);
  syx_memory_gc_end ();
  return syx_interp_enter_context (ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_on_do)
{
  SYX_PRIM_ARGS(2);
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_nil);

  SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx) = es->message_arguments[0];
  SYX_BLOCK_CONTEXT_HANDLER_BLOCK (ctx) = es->message_arguments[1];

  return syx_interp_enter_context (ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_newProcess)
{
  SyxOop ctx;
  SyxOop proc;
  
  syx_memory_gc_begin ();
  ctx = _syx_block_context_new_from_closure (es, syx_nil);
  SYX_METHOD_CONTEXT_PARENT (ctx) = syx_nil;
  SYX_METHOD_CONTEXT_RETURN_CONTEXT (ctx) = syx_nil;
  proc = syx_process_new (ctx);
  syx_memory_gc_end ();

  SYX_PRIM_RETURN (proc);
}

SYX_FUNC_PRIMITIVE (String_asSymbol)
{
  SYX_PRIM_RETURN (syx_symbol_new (SYX_OBJECT_SYMBOL (es->message_receiver)));
}

/* These printing function are used ONLY for tests */
SYX_FUNC_PRIMITIVE (SmallInteger_print)
{
  printf ("%d\n", SYX_SMALL_INTEGER(es->message_receiver));
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Float_print)
{
  printf ("%f\n", SYX_OBJECT_FLOAT(es->message_receiver));
  SYX_PRIM_RETURN (es->message_receiver);
}



/* Processor */

SYX_FUNC_PRIMITIVE (Processor_enter)
{
  SYX_PRIM_ARGS(1);
  return syx_interp_enter_context (es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_swapWith)
{
  SYX_PRIM_ARGS(1);
  return syx_interp_swap_context (es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_leaveTo_andAnswer)
{
  SYX_PRIM_ARGS(2);
  SYX_METHOD_CONTEXT_RETURN_CONTEXT(es->context) = es->message_arguments[0];
  return syx_interp_leave_context_and_answer (es->message_arguments[1], TRUE);
}

SYX_FUNC_PRIMITIVE (Character_new)
{
  SYX_PRIM_ARGS(1);
  SYX_PRIM_RETURN (syx_character_new (SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (Character_value)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_CHARACTER (es->message_receiver)));
}


SYX_FUNC_PRIMITIVE (Semaphore_signal)
{
  syx_semaphore_signal (es->message_receiver);
  SYX_PRIM_YIELD (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Semaphore_wait)
{
  syx_semaphore_wait (es->message_receiver);
  SYX_PRIM_YIELD (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Semaphore_waitFor)
{
  SYX_PRIM_ARGS(2);
  syx_int32 fd = SYX_SMALL_INTEGER(es->message_arguments[0]);
  syx_bool t = es->message_arguments[1];
  syx_semaphore_wait (es->message_receiver);
  if (t == syx_true)
    syx_scheduler_poll_write_register (fd,
				       es->message_receiver);
  else
    syx_scheduler_poll_read_register (fd,
				      es->message_receiver);
  SYX_PRIM_YIELD (es->message_receiver);
}

/* File streams */

SYX_FUNC_PRIMITIVE (FileStream_fileOp)
{
  SYX_PRIM_ARGS(2);
  syx_int32 fd = SYX_SMALL_INTEGER (es->message_arguments[1]);
  syx_int32 ret = 0;

  switch (SYX_SMALL_INTEGER (es->message_arguments[0]))
    {
    case 0: // open
      {
	syx_symbol mode = SYX_OBJECT_SYMBOL (es->message_arguments[2]);
	syx_int32 flags = 0;

	if (*mode == 'r')
	  {
	    if (mode[1] == '+')
	      flags |= O_RDWR;
	    else
	      flags |= O_RDONLY;
	  }
	else if (*mode == 'w')
	  flags |= O_WRONLY;
	else
	  syx_error ("Unknown open mode %s\n", mode);
	
	ret = open (SYX_OBJECT_STRING (es->message_arguments[1]), flags);
      }
      break;

    case 1: // close
      ret = close (fd);
      break;
      
    case 2: // nextPut:
      SYX_PRIM_ARGS(3);
      {
	syx_char c = SYX_CHARACTER (es->message_arguments[2]);
	ret = write (fd, &c, 1);
      }
      break;

    case 3: // nextPutAll:
      SYX_PRIM_ARGS(3);

      if (!SYX_OBJECT_IS_STRING (es->message_arguments[2]))
	{
	  SYX_PRIM_FAIL;
	}
      
      if (!SYX_IS_NIL (es->message_arguments[2]))
	{
	  ret = write (fd, SYX_OBJECT_BYTE_ARRAY (es->message_arguments[2]),
		       SYX_OBJECT_DATA_SIZE (es->message_arguments[2]) - 1);
	}
      else
	ret = 0;
      break;

    case 4: // flush
//      ret = fsync (fd);
      break;

    case 5: // next
      {
	syx_char c;
	if (!read (fd, &c, 1))
	  {
	    // EOF
	    SYX_PRIM_RETURN (syx_nil);
	  }

	SYX_PRIM_RETURN (syx_character_new (c));
      }
      break;

    case 6: // next:
      SYX_PRIM_ARGS(3);
      {
	syx_int32 count = SYX_SMALL_INTEGER (es->message_arguments[2]);
	syx_string s = (syx_string) syx_malloc (count+1);
	SyxOop string;

	count = read (fd, s, count);

	if (!count)
	  {
	    // maybe EOF
	    SYX_PRIM_RETURN (syx_nil);
	  }

	s[count] = '\0';

	string = syx_string_new (s);
	syx_free (s);

	SYX_PRIM_RETURN (string);
      }
      break;

    case 7: // size
      {
	#ifdef HAVE_FSTAT
	struct stat statbuf;
	if ((fstat (fd, &statbuf)) < 0)
	  {
	    SYX_PRIM_FAIL;
	  }

	SYX_PRIM_RETURN (syx_small_integer_new (statbuf.st_size));
	#else
	SYX_PRIM_RETURN (syx_small_integer_new (0));
	#endif
      }
      break;

    default: // unknown
      syx_error ("Unknown file operation: %d\n", SYX_SMALL_INTEGER (es->message_arguments[0]));

    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (String_hash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (syx_string_hash (SYX_OBJECT_SYMBOL (es->message_receiver))));
}

/* Small integers */

SYX_FUNC_PRIMITIVE (SmallInteger_plus)
{
  SYX_PRIM_ARGS(1);
  
  SyxOop first, second;
  syx_int32 a, b, result;

  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }

  a = SYX_SMALL_INTEGER (first);
  b = SYX_SMALL_INTEGER (second);
  if (SYX_SMALL_INTEGER_SUM_OVERFLOW (a, b))
    {
      SYX_PRIM_FAIL;
    }

  result = SYX_SMALL_INTEGER (first) + SYX_SMALL_INTEGER (second);
  if (!SYX_SMALL_INTEGER_CAN_EMBED (result))
    {
      SYX_PRIM_FAIL;
    }

  SYX_PRIM_RETURN (syx_small_integer_new (result));
}

SYX_FUNC_PRIMITIVE (SmallInteger_minus)
{
  SYX_PRIM_ARGS(1);
  
  SyxOop first, second;
  syx_int32 a, b, result;

  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }

  a = SYX_SMALL_INTEGER (first);
  b = SYX_SMALL_INTEGER (second);
  if (SYX_SMALL_INTEGER_DIFF_OVERFLOW (a, b))
    {
      SYX_PRIM_FAIL;
    }

  result = SYX_SMALL_INTEGER (first) - SYX_SMALL_INTEGER (second);
  if (!SYX_SMALL_INTEGER_CAN_EMBED (result))
    {
      SYX_PRIM_FAIL;
    }

  SYX_PRIM_RETURN (syx_small_integer_new (result));
}

SYX_FUNC_PRIMITIVE (SmallInteger_lt)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (first) <
				    SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_gt)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (first) >
				    SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_le)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (first) <=
				    SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ge)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (first) >=
				    SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_eq)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (first == second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ne)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (first != second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_div)
{
  SYX_PRIM_ARGS(1);

  SyxOop second;
  syx_int32 a, b;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  a = SYX_SMALL_INTEGER (es->message_receiver);
  b = SYX_SMALL_INTEGER (second);
  if (!b)
    {
      SYX_PRIM_FAIL;
    }

  if (a % b)
    {
      SYX_PRIM_FAIL;
    }
  if (SYX_SMALL_INTEGER_DIV_OVERFLOW (a, b))
    {
      SYX_PRIM_FAIL;
    }
  
  SYX_PRIM_RETURN (syx_small_integer_new (a / b));
}

SYX_FUNC_PRIMITIVE (SmallInteger_mul)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  syx_int32 a, b, result;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }

  a = SYX_SMALL_INTEGER (first);
  b = SYX_SMALL_INTEGER (second);

  if (SYX_SMALL_INTEGER_MUL_OVERFLOW (a, b))
    {
      SYX_PRIM_FAIL;
    }

  result = a * b;
  if (!SYX_SMALL_INTEGER_CAN_EMBED (result))
    {
      SYX_PRIM_FAIL;
    }

  SYX_PRIM_RETURN (syx_small_integer_new (result));
}

SYX_FUNC_PRIMITIVE (SmallInteger_mod)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_SMALL_INTEGER (first) %
					  SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_bitAnd)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_SMALL_INTEGER (first) &
					  SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_bitOr)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_SMALL_INTEGER (first) |
					  SYX_SMALL_INTEGER (second)));
}

SYX_FUNC_PRIMITIVE (SmallInteger_bitXor)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_SMALL_INTEGER (first) ^
					  SYX_SMALL_INTEGER (second)));
}

/* Thanks to Sam Philiphs for this contribute */
SYX_FUNC_PRIMITIVE (SmallInteger_bitShift)
{
  SYX_PRIM_ARGS(1);

  SyxOop arg;
  syx_int32 val, shift;

  val = SYX_SMALL_INTEGER(es->message_receiver);
  arg = es->message_arguments[0];
  if (!SYX_IS_SMALL_INTEGER (arg))
    {
      SYX_PRIM_FAIL;
    }

  shift = SYX_SMALL_INTEGER (arg);

  if (SYX_SMALL_INTEGER_SHIFT_OVERFLOW (val, shift))
    {
      SYX_PRIM_FAIL;
    }
  
  if (shift >= 0)
    {
      val <<= shift;
      if (!SYX_SMALL_INTEGER_CAN_EMBED (val))
	{
	  SYX_PRIM_FAIL;
	}
      
      SYX_PRIM_RETURN (syx_small_integer_new (val));
    }
  else
    {
      SYX_PRIM_RETURN (syx_small_integer_new (val >> abs(shift)));
    }
}

SYX_FUNC_PRIMITIVE (SmallInteger_asFloat)
{
  syx_double n = (syx_double)SYX_SMALL_INTEGER (es->message_receiver);
  SYX_PRIM_RETURN (syx_float_new (n));
}

SYX_FUNC_PRIMITIVE (SmallInteger_asLargeInteger)
{
#ifdef HAVE_LIBGMP
  SYX_PRIM_RETURN (syx_large_integer_new_integer (SYX_SMALL_INTEGER (es->message_receiver)));
#else
  SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
}


/* Large integers */

#define _GET_Z mpz_t *z = (mpz_t *)SYX_OBJECT_DATA (es->message_receiver)
#define _GET_OP2 SYX_PRIM_ARGS(1); if (!SYX_OBJECT_IS_LARGE_INTEGER (es->message_arguments[0])) { SYX_PRIM_FAIL; } \
  mpz_t *op2 = (mpz_t *)SYX_OBJECT_DATA (es->message_arguments[0]);
#define _NEW_R mpz_t *r = syx_calloc (1, sizeof (mpz_t)); mpz_init (*r)
#define _RET_R if (mpz_fits_sint_p (*r) && SYX_SMALL_INTEGER_CAN_EMBED (mpz_get_si (*r))) \
    { syx_int32 ret = mpz_get_si (*r); mpz_clear (*r); syx_free (r);	\
      SYX_PRIM_RETURN (syx_small_integer_new (ret)); }			\
  else									\
    { SYX_PRIM_RETURN (syx_large_integer_new_mpz (r)); }

#ifdef HAVE_LIBGMP
#define _DO_OP(op)				\
  _GET_Z;					\
  _GET_OP2;					\
  _NEW_R;					\
  op (*r, *z, *op2);				\
  _RET_R
#else
#define _DO_OP(op) SYX_PRIM_FAIL
#endif /* HAVE_LIBGMP */

#ifdef HAVE_LIBGMP
#define _CMP_OP(op)						\
  _GET_Z;							\
  _GET_OP2;							\
  SYX_PRIM_RETURN (syx_boolean_new (mpz_cmp (*z, *op2) op 0));
#else
#define _CMP_OP(op) SYX_PRIM_FAIL
#endif /* HAVE_LIBGMP */


/* Arithmetic */

SYX_FUNC_PRIMITIVE(LargeInteger_plus)
{
  _DO_OP (mpz_add);
}

SYX_FUNC_PRIMITIVE(LargeInteger_minus)
{
  _DO_OP (mpz_sub);
}

SYX_FUNC_PRIMITIVE(LargeInteger_lt)
{
  _CMP_OP (<);
}

SYX_FUNC_PRIMITIVE(LargeInteger_gt)
{
  _CMP_OP (>);
}

SYX_FUNC_PRIMITIVE(LargeInteger_le)
{
  _CMP_OP (<=);
}

SYX_FUNC_PRIMITIVE(LargeInteger_ge)
{
  _CMP_OP (>=);
}

SYX_FUNC_PRIMITIVE(LargeInteger_eq)
{
  _CMP_OP (==);
}

SYX_FUNC_PRIMITIVE(LargeInteger_ne)
{
  _CMP_OP (!=);
}

SYX_FUNC_PRIMITIVE(LargeInteger_div)
{
#ifdef HAVE_LIBGMP
  SYX_PRIM_ARGS(1);
  _GET_Z;
  _GET_OP2;
  _NEW_R;
  if (!mpz_divisible_p (*z, *op2))
    {
      SYX_PRIM_FAIL;
    }

  mpz_divexact (*r, *z, *op2);
  _RET_R;
#else
  SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
}

SYX_FUNC_PRIMITIVE(LargeInteger_intDiv)
{
  _DO_OP (mpz_fdiv_q);
}

SYX_FUNC_PRIMITIVE(LargeInteger_quo)
{
  _DO_OP (mpz_tdiv_q);
}

SYX_FUNC_PRIMITIVE(LargeInteger_mul)
{
  _DO_OP (mpz_mul);
}

SYX_FUNC_PRIMITIVE(LargeInteger_mod)
{
  _DO_OP (mpz_fdiv_r);
}

SYX_FUNC_PRIMITIVE(LargeInteger_bitAnd)
{
  _DO_OP (mpz_and);
}

SYX_FUNC_PRIMITIVE(LargeInteger_bitOr)
{
  _DO_OP (mpz_ior);
}

SYX_FUNC_PRIMITIVE(LargeInteger_bitXor)
{
  _DO_OP (mpz_xor);
}

SYX_FUNC_PRIMITIVE(LargeInteger_bitShift)
{
#ifdef HAVE_LIBGMP
  SYX_PRIM_ARGS(1);
  syx_int32 shift;
  _GET_Z;
  _NEW_R;
  if (!SYX_IS_SMALL_INTEGER (es->message_arguments[0]))
    {
      SYX_PRIM_FAIL;
    }
  
  shift = SYX_SMALL_INTEGER (es->message_arguments[0]);
  if (shift > 0)
    mpz_mul_2exp (*r, *z, shift);
  else if (shift < 0)
    mpz_fdiv_q_2exp (*r, *z, -shift);
  else
    {
      SYX_PRIM_RETURN (es->message_receiver);
    }

  _RET_R;
#else
  SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
}

SYX_FUNC_PRIMITIVE(LargeInteger_asFloat)
{
#ifdef HAVE_LIBGMP
  _GET_Z;
  SYX_PRIM_RETURN (syx_float_new (mpz_get_d (*z)));
#else
  SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
}



SYX_FUNC_PRIMITIVE(LargeInteger_clear)
{
#ifdef HAVE_LIBGMP
  _GET_Z;
  mpz_clear (*z);
  SYX_PRIM_RETURN(syx_nil);
#else
  SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
}




/* Floats */

SYX_FUNC_PRIMITIVE (Float_plus)
{
  SYX_PRIM_ARGS(1);
  
  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_float_new (SYX_OBJECT_FLOAT (first) +
				  SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_minus)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_float_new (SYX_OBJECT_FLOAT (first) -
				  SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_div)
{
  SYX_PRIM_ARGS (1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_float_new (SYX_OBJECT_FLOAT (first) /
				  SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_mul)
{
  SYX_PRIM_ARGS (1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_float_new (SYX_OBJECT_FLOAT (first) *
				  SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_lt)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) <
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_gt)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) >
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_le)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) <=
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_ge)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) >=
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_eq)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) ==
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_ne)
{
  SYX_PRIM_ARGS(1);

  SyxOop first, second;
  first = es->message_receiver;
  second = es->message_arguments[0];
  if (!SYX_OBJECT_IS_FLOAT (second))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OBJECT_FLOAT (first) !=
				    SYX_OBJECT_FLOAT (second)));
}

SYX_FUNC_PRIMITIVE (Float_ceil)
{
  double ret = ceil (SYX_OBJECT_FLOAT (es->message_receiver));

  if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
    {
#ifdef HAVE_LIBGMP
      _NEW_R;
      mpz_init_set_d (*r, ret);
      SYX_PRIM_RETURN (syx_large_integer_new_mpz (r));
#else
      SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (Float_floor)
{
  double ret = floor (SYX_OBJECT_FLOAT (es->message_receiver));

  if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
    {
#ifdef HAVE_LIBGMP
      _NEW_R;
      mpz_init_set_d (*r, ret);
      SYX_PRIM_RETURN (syx_large_integer_new_mpz (r));
#else
      SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (Float_trunc)
{
  double ret = trunc (SYX_OBJECT_FLOAT (es->message_receiver));

  if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
    {
#ifdef HAVE_LIBGMP
      _NEW_R;
      mpz_init_set_d (*r, ret);
      SYX_PRIM_RETURN (syx_large_integer_new_mpz (r));
#else
      SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

/* Object memory and Smalltalk */


SYX_FUNC_PRIMITIVE (ObjectMemory_snapshot)
{
  SYX_PRIM_ARGS(1);

  SyxOop filename = es->message_arguments[0];
  syx_bool ret;

  // save the current execution state
  syx_interp_stack_push (es->message_receiver);
  syx_exec_state_save ();

  if (SYX_IS_NIL (filename))
    ret = syx_memory_save_image (NULL);
  else
    ret = syx_memory_save_image (SYX_OBJECT_STRING (filename));

  if (!ret)
    {
      SYX_PRIM_FAIL;
    }

  return FALSE;
}

SYX_FUNC_PRIMITIVE (ObjectMemory_garbageCollect)
{
  syx_memory_gc ();
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (ObjectMemory_atDataPut)
{
  SYX_PRIM_ARGS(2);
  SyxOop source = es->message_arguments[1];
  SyxOop dest = es->message_arguments[0];
  syx_bool has_refs = SYX_OBJECT_HAS_REFS(source);
  if (has_refs != SYX_OBJECT_HAS_REFS(dest))
    {
      SYX_PRIM_FAIL;
    }
  syx_free (SYX_OBJECT_DATA(dest));
  if (has_refs)
    SYX_OBJECT_DATA(dest) = (SyxOop *) syx_memdup (SYX_OBJECT_DATA(source),
						   SYX_OBJECT_DATA_SIZE(source), sizeof (SyxOop));
  else
    SYX_OBJECT_DATA(dest) = (SyxOop *) syx_memdup (SYX_OBJECT_DATA(source),
						   SYX_OBJECT_DATA_SIZE(source), sizeof (syx_int8));
  SYX_OBJECT_DATA_SIZE(dest) = SYX_OBJECT_DATA_SIZE(source);
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (ObjectMemory_setConstant)
{
  SYX_PRIM_ARGS(1);
  SyxOop oop = es->message_arguments[0];
  if (SYX_IS_OBJECT (oop))
    {
      SYX_OBJECT_IS_CONSTANT(oop) = TRUE;
    }
  SYX_PRIM_RETURN(es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Smalltalk_quit)
{
  SYX_PRIM_ARGS(1);
  syx_int32 status = SYX_SMALL_INTEGER (es->message_arguments[0]);
  syx_quit ();
  exit (status);
}

SYX_FUNC_PRIMITIVE (Smalltalk_pluginCall)
{
  SyxOop *message_arguments;
  syx_varsize message_arguments_count;
  SyxOop plugin = es->message_arguments[0];
  syx_symbol plugin_name = NULL;
  SyxOop func = es->message_arguments[1];
  SyxOop arguments = es->message_arguments[2];
  syx_bool ret;

  if (SYX_IS_NIL (func))
    {
      SYX_PRIM_FAIL;
    }

  if (!SYX_IS_NIL (plugin))
    plugin_name = SYX_OBJECT_SYMBOL (plugin);

  // save the real state
  message_arguments = es->message_arguments;
  message_arguments_count = es->message_arguments_count;
  es->message_arguments_count = SYX_OBJECT_DATA_SIZE(arguments);
  if (!es->message_arguments_count)
    es->message_arguments = NULL;
  else
    es->message_arguments = SYX_OBJECT_DATA(arguments);

  ret = syx_plugin_call (es, plugin_name, SYX_OBJECT_SYMBOL (func), syx_nil);

  // restore the state
  es->message_arguments = message_arguments;
  es->message_arguments_count = message_arguments_count;

  return ret;
}

SYX_FUNC_PRIMITIVE (Smalltalk_pluginSymbol)
{
  SYX_PRIM_ARGS(2);
  SyxOop plugin = es->message_arguments[0];
  SyxOop func = es->message_arguments[1];
  syx_symbol func_name;
  syx_symbol plugin_name = NULL;
  SyxOop oop;

  if (SYX_IS_NIL (func))
    {
      SYX_PRIM_FAIL;
    }

  if (!SYX_IS_NIL (plugin))
    plugin_name = SYX_OBJECT_SYMBOL (plugin);

  func_name = SYX_OBJECT_SYMBOL (func);

  oop = SYX_POINTER_CAST_OOP (syx_plugin_symbol (plugin_name, func_name));
  SYX_PRIM_RETURN (oop);
}

SYX_FUNC_PRIMITIVE (Smalltalk_loadPlugin)
{
  SYX_PRIM_ARGS(1);
  SyxOop oop = es->message_arguments[0];
  syx_symbol name = NULL;
  if (!SYX_IS_NIL (oop))
    name = SYX_OBJECT_SYMBOL (oop);
  SYX_PRIM_RETURN(syx_boolean_new (syx_plugin_load (name)));
}

SYX_FUNC_PRIMITIVE (Smalltalk_unloadPlugin)
{
  SYX_PRIM_ARGS(1);
  syx_symbol name = SYX_OBJECT_SYMBOL(es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_boolean_new (syx_plugin_unload (name)));
}

SYX_FUNC_PRIMITIVE (Smalltalk_haveBigEndianness)
{
#ifdef HAVE_BIG_ENDIANNESS
  SYX_PRIM_RETURN(syx_true);
#else
  SYX_PRIM_RETURN(syx_false);
#endif
}

SyxPrimitiveEntry _syx_primitive_entries[] = {
  { "Processor_yield", Processor_yield },

  /* Common for objects */
  { "Object_class", Object_class },
  { "Behavior_new", Behavior_new },
  { "Behavior_newColon", Behavior_newColon },
  { "Object_at", Object_at },
  { "Object_at_put", Object_at_put },
  { "Object_size", Object_size },
  { "Object_identityEqual", Object_identityEqual },
  { "Object_identityHash", Object_identityHash },
  { "Object_hash", Object_hash },
  { "Object_equal", Object_equal },
  { "Object_resize", Object_resize },
  { "Object_copy", Object_copy },
  { "Object_perform", Object_perform },
  { "Object_performWithArguments", Object_performWithArguments },

  /* Arrayed collections */
  { "ArrayedCollection_replaceFromToWith", ArrayedCollection_replaceFromToWith },

  /* Byte arrays */
  { "ByteArray_newColon", ByteArray_newColon },
  { "ByteArray_at", ByteArray_at },
  { "ByteArray_at_put", ByteArray_at_put },

  /* Blocks */
  { "BlockClosure_asContext", BlockClosure_asContext },
  { "BlockClosure_value", BlockClosure_value },
  { "BlockClosure_valueWith", BlockClosure_valueWith },
  { "BlockClosure_valueWithArguments", BlockClosure_valueWithArguments },
  { "BlockClosure_on_do", BlockClosure_on_do },
  { "BlockClosure_newProcess", BlockClosure_newProcess },

  { "String_asSymbol", String_asSymbol },
  { "Float_print", Float_print },

  /* Interpreter */
  { "Processor_enter", Processor_enter },
  { "Processor_swapWith", Processor_swapWith },
  { "Processor_leaveTo_andAnswer", Processor_leaveTo_andAnswer },

  { "Character_new", Character_new },
  { "Character_value", Character_value },
  { "Semaphore_signal", Semaphore_signal },
  { "Semaphore_wait", Semaphore_wait },
  { "Semaphore_waitFor", Semaphore_waitFor },

  /* Strings */
  { "String_hash", String_hash },

  /* File streams */
  { "FileStream_fileOp", FileStream_fileOp },

  /* Small integers */
  { "SmallInteger_plus", SmallInteger_plus },
  { "SmallInteger_minus", SmallInteger_minus },
  { "SmallInteger_lt", SmallInteger_lt },
  { "SmallInteger_gt", SmallInteger_gt },
  { "SmallInteger_le", SmallInteger_le },
  { "SmallInteger_ge", SmallInteger_ge },
  { "SmallInteger_eq", SmallInteger_eq },
  { "SmallInteger_ne", SmallInteger_ne },
  { "SmallInteger_div", SmallInteger_div },
  { "SmallInteger_mul", SmallInteger_mul },
  { "SmallInteger_mod", SmallInteger_mod },
  { "SmallInteger_bitAnd", SmallInteger_bitAnd },
  { "SmallInteger_bitOr", SmallInteger_bitOr },
  { "SmallInteger_bitXor", SmallInteger_bitXor },
  { "SmallInteger_bitShift", SmallInteger_bitShift },
  { "SmallInteger_asFloat", SmallInteger_asFloat },
  { "SmallInteger_asLargeInteger", SmallInteger_asLargeInteger },

  /* Large integers */
  { "LargeInteger_plus", LargeInteger_plus },
  { "LargeInteger_minus", LargeInteger_minus },
  { "LargeInteger_lt", LargeInteger_lt },
  { "LargeInteger_gt", LargeInteger_gt },
  { "LargeInteger_le", LargeInteger_le },
  { "LargeInteger_ge", LargeInteger_ge },
  { "LargeInteger_eq", LargeInteger_eq },
  { "LargeInteger_ne", LargeInteger_ne },
  { "LargeInteger_div", LargeInteger_div },
  { "LargeInteger_intDiv", LargeInteger_intDiv },
  { "LargeInteger_quo", LargeInteger_quo },
  { "LargeInteger_mul", LargeInteger_mul },
  { "LargeInteger_mod", LargeInteger_mod },
  { "LargeInteger_bitAnd", LargeInteger_bitAnd },
  { "LargeInteger_bitOr", LargeInteger_bitOr },
  { "LargeInteger_bitXor", LargeInteger_bitXor },
  { "LargeInteger_bitShift", LargeInteger_bitShift },
  { "LargeInteger_clear", LargeInteger_clear },
  { "LargeInteger_asFloat", LargeInteger_asFloat },

  /* Floats */
  { "Float_plus", Float_plus },
  { "Float_minus", Float_minus },
  { "Float_mul", Float_mul },
  { "Float_div", Float_div },
  { "Float_lt", Float_lt },
  { "Float_gt", Float_gt },
  { "Float_le", Float_le },
  { "Float_ge", Float_ge },
  { "Float_eq", Float_eq },
  { "Float_ne", Float_ne },
  { "Float_ceil", Float_ceil },
  { "Float_floor", Float_floor },
  { "Float_trunc", Float_trunc },

  /* Object memory */
  { "ObjectMemory_snapshot", ObjectMemory_snapshot },
  { "ObjectMemory_garbageCollect", ObjectMemory_garbageCollect },
  { "ObjectMemory_atDataPut", ObjectMemory_atDataPut },
  { "ObjectMemory_setConstant", ObjectMemory_setConstant },

  /* Smalltalk environment */
  { "Smalltalk_quit", Smalltalk_quit },
  { "Smalltalk_loadPlugin", Smalltalk_loadPlugin },
  { "Smalltalk_unloadPlugin", Smalltalk_unloadPlugin },
  { "Smalltalk_pluginCall", Smalltalk_pluginCall },
  { "Smalltalk_pluginSymbol", Smalltalk_pluginSymbol },

  { NULL }
};

syx_int32
syx_primitive_get_index (syx_symbol name)
{
  syx_int32 i;

  for (i=0; i < SYX_PRIMITIVES_MAX; i++)
    {
      if (!strcmp (_syx_primitive_entries[i].name, name))
	return i;
    }

  return -1;
}
