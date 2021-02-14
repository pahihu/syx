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

#define _POSIX_C_SOURCE 1

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
#include "syx-profile.h"

#include <stdio.h>
#include <fcntl.h>
#include <math.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif

#ifdef HAVE_WINDOWS_H
#include <windows.h>
#endif

/* Prototype of the interpreter function for creating frames without using contexts */
void _syx_interp_save_process_state (void);
void _syx_interp_frame_prepare_new_closure (SyxInterpState *state, SyxOop closure);

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
  syx_varsize size;
  SYX_PRIM_ARGS(1);
  size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->message_receiver, TRUE, size));
}

SYX_FUNC_PRIMITIVE (ByteArray_newColon)
{
  syx_varsize size;
  SYX_PRIM_ARGS(1);
  size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->message_receiver, FALSE, size));
}

SYX_FUNC_PRIMITIVE (Object_class)
{
  SYX_PRIM_RETURN(syx_object_get_class (es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Object_at)
{
  syx_varsize index;
  SYX_PRIM_ARGS(1);
  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(SYX_OBJECT_DATA(es->message_receiver)[index]);
}

SYX_FUNC_PRIMITIVE (Object_at_put)
{
  syx_varsize index;
  SyxOop object;
  SYX_PRIM_ARGS(2);
  
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
  syx_varsize size;
  SYX_PRIM_ARGS(1);

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

/* This primitive handles both #perform: and #perform:with: */
SYX_FUNC_PRIMITIVE (Object_perform)
{
  SyxOop klass;
  SyxOop message_method;
  SyxOop selector;
  SyxOop message_arguments[0xFF];
  syx_varsize message_arguments_count;
  syx_int32 primitive;
  syx_bool ret = TRUE;

  SYX_START_PROFILE;

  SYX_PRIM_ARGS(1);

  selector = es->message_arguments[0];
  klass = syx_object_get_class (es->message_receiver); 
  message_method = syx_class_lookup_method (klass, SYX_OBJECT_SYMBOL (selector));

  if (SYX_IS_NIL (message_method))
    {
      SYX_PRIM_FAIL;
    }

  if (SYX_SMALL_INTEGER (SYX_CODE_ARGUMENTS_COUNT (message_method)) != es->message_arguments_count - 1)
    {
      SYX_PRIM_FAIL;
    }

  /* save the real state */
  memcpy (message_arguments, es->message_arguments, es->message_arguments_count * sizeof (SyxOop));
  message_arguments_count = es->message_arguments_count;

  es->message_arguments_count--;
  /* Check for #perform:with: then shift the only argument to the right by one */
  if (es->message_arguments_count)
    es->message_arguments[0] = es->message_arguments[1];

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (message_method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    ret = syx_interp_call_primitive (primitive, message_method);
  else if (primitive == -2)
    ret = syx_plugin_call_interp (es, message_method);
  else
    _syx_interp_frame_prepare_new (es, message_method);

  /* restore the state */
  memcpy (es->message_arguments, message_arguments, message_arguments_count * sizeof (SyxOop));
  es->message_arguments_count = message_arguments_count;

  SYX_END_PROFILE(perform_message);

  return ret;
}

SYX_FUNC_PRIMITIVE (Object_performWithArguments)
{
  SyxOop klass;
  SyxOop message_method;
  SyxOop selector;
  SyxOop arguments;
  SyxOop message_arguments[0xFF];
  syx_varsize message_arguments_count;
  syx_int32 primitive;
  syx_bool ret = TRUE;
  
  SYX_START_PROFILE;

  SYX_PRIM_ARGS(2);

  selector = es->message_arguments[0];
  arguments = es->message_arguments[1];

  klass = syx_object_get_class (es->message_receiver); 
  message_method = syx_class_lookup_method (klass, SYX_OBJECT_SYMBOL (selector));

  if (SYX_IS_NIL (message_method))
    {
      SYX_PRIM_FAIL;
    }

  if (SYX_SMALL_INTEGER (SYX_CODE_ARGUMENTS_COUNT (message_method)) != SYX_OBJECT_DATA_SIZE (arguments))
    {
      SYX_PRIM_FAIL;
    }

  /* save the real state */
  memcpy (message_arguments, es->message_arguments, es->message_arguments_count * sizeof (SyxOop));
  message_arguments_count = es->message_arguments_count;
  if (SYX_IS_NIL (arguments))
    es->message_arguments_count = 0;
  else
    {
      es->message_arguments_count = SYX_OBJECT_DATA_SIZE(arguments);
      memcpy (es->message_arguments, SYX_OBJECT_DATA (arguments), es->message_arguments_count * sizeof (SyxOop));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (message_method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    ret = syx_interp_call_primitive (primitive, message_method);
  else if (primitive == -2)
    ret = syx_plugin_call_interp (es, message_method);
  else
    _syx_interp_frame_prepare_new (es, message_method);

  /* restore the state */
  memcpy (es->message_arguments, message_arguments, message_arguments_count * sizeof (SyxOop));
  es->message_arguments_count = message_arguments_count;

  SYX_END_PROFILE(perform_message);

  return ret;
}

SYX_FUNC_PRIMITIVE (ArrayedCollection_replaceFromToWithStartingAt)
{
  syx_varsize start;
  SyxOop coll;
  syx_varsize end;
  syx_varsize length;
  syx_varsize collstart;
  SYX_PRIM_ARGS(3);

  start = SYX_SMALL_INTEGER (es->message_arguments[0]) - 1;
  coll = es->message_arguments[2];
  end = SYX_SMALL_INTEGER(es->message_arguments[1]);
  collstart = SYX_SMALL_INTEGER(es->message_arguments[3]) - 1;
  length = end - start;

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

  /* distinguish between arrays and bytearrays */
  if (SYX_OBJECT_HAS_REFS (es->message_receiver))
    {
      if (SYX_OBJECT_HAS_REFS (coll))
        memcpy (SYX_OBJECT_DATA (es->message_receiver) + start, SYX_OBJECT_DATA (coll) + collstart,
                length * sizeof (SyxOop));
      else
        {
          SYX_PRIM_FAIL;
        }
    }
  else
    {
      if (!SYX_OBJECT_HAS_REFS (coll))
        memcpy (SYX_OBJECT_BYTE_ARRAY (es->message_receiver) + start,
                SYX_OBJECT_BYTE_ARRAY (coll) + collstart, length * sizeof (syx_int8));
      else
        {
          SYX_PRIM_FAIL;
        }
    }

  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (ByteArray_at)
{
  syx_varsize index;
  SYX_PRIM_ARGS(1);

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  if (index < 0 || index >= SYX_OBJECT_DATA_SIZE(es->message_receiver))
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(syx_small_integer_new (SYX_OBJECT_BYTE_ARRAY(es->message_receiver)[index]));
}

SYX_FUNC_PRIMITIVE (ByteArray_at_put)
{
  syx_varsize index;
  SyxOop oop;
  SYX_PRIM_ARGS(2);

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
  SyxOop ctx;
  SYX_PRIM_ARGS(1);

  ctx = syx_block_context_new (es->message_receiver, es->message_arguments[0]);
  SYX_PRIM_RETURN (ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_value)
{
  /* Unset arguments for the execution of the block */
  es->message_arguments_count = 0;
  _syx_interp_frame_prepare_new_closure (es, es->message_receiver);
  return TRUE;
}

SYX_FUNC_PRIMITIVE (BlockClosure_valueWith)
{
  SYX_PRIM_ARGS(1);

  /* The only argument for this primitive is right the same argument for the block */
  _syx_interp_frame_prepare_new_closure (es, es->message_receiver);
  return TRUE;
}
  
SYX_FUNC_PRIMITIVE (BlockClosure_valueWithArguments)
{
  SYX_PRIM_ARGS(1);

  es->message_arguments_count = SYX_OBJECT_DATA_SIZE (es->message_arguments[0]);
  memcpy (es->message_arguments, SYX_OBJECT_DATA (es->message_arguments[0]), es->message_arguments_count * sizeof (SyxOop));
  _syx_interp_frame_prepare_new_closure (es, es->message_receiver);
  return TRUE;
}

SYX_FUNC_PRIMITIVE (BlockClosure_on_do)
{
  SyxOop ctx;
  SYX_PRIM_ARGS(2);

  ctx = syx_block_context_new (es->message_receiver, syx_nil);

  SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx) = es->message_arguments[0];
  SYX_BLOCK_CONTEXT_HANDLER_BLOCK (ctx) = es->message_arguments[1];

  return syx_interp_enter_context (syx_processor_active_process, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_newProcess)
{
  SyxOop ctx;
  SyxOop proc;

  syx_memory_gc_begin ();
  proc = syx_process_new ();
  ctx = syx_block_context_new (es->message_receiver, syx_nil);
  syx_interp_enter_context (proc, ctx);
  syx_memory_gc_end ();

  SYX_PRIM_RETURN (proc);
}



/* Contexts */

SYX_FUNC_PRIMITIVE (ContextPart_parent)
{
  SyxInterpFrame *frame = syx_interp_context_to_frame (es->message_receiver);
  SYX_PRIM_RETURN (syx_interp_frame_to_context (SYX_CONTEXT_PART_STACK (es->message_receiver),
                                                frame->parent_frame));
}

SYX_FUNC_PRIMITIVE (ContextPart_receiver)
{
  SyxInterpFrame *frame = syx_interp_context_to_frame (es->message_receiver);
  SYX_PRIM_RETURN (frame->receiver);
}

SYX_FUNC_PRIMITIVE (BlockContext_outerContext)
{
  SyxInterpFrame *frame = syx_interp_context_to_frame (es->message_receiver);
  SYX_PRIM_RETURN (syx_interp_frame_to_context (SYX_CONTEXT_PART_STACK (es->message_receiver),
                                                frame->outer_frame));
}


/* Processor */

SYX_FUNC_PRIMITIVE (Processor_enter)
{
  SYX_PRIM_ARGS(1);
  return syx_interp_enter_context (syx_processor_active_process, es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_swapWith)
{
  SYX_PRIM_ARGS(1);
  return syx_interp_swap_context (syx_processor_active_process, es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_leaveTo_andAnswer)
{
  SyxInterpFrame *frame;
  SYX_PRIM_ARGS(2);
  frame = syx_interp_context_to_frame (es->message_arguments[0]);
  es->frame->stack_return_frame = frame;
  return syx_interp_leave_and_answer (es->message_arguments[1], TRUE);
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
  syx_nint fd;
  syx_bool t;
  SYX_PRIM_ARGS(2);

#ifdef WINDOWS
  fd = es->message_arguments[0];
  if (fd == (syx_nint)stdin)
    fd = (syx_nint)GetStdHandle (STD_INPUT_HANDLE);
  else if (fd == (syx_nint)stdout)
    fd = (syx_nint)GetStdHandle (STD_OUTPUT_HANDLE);
  else if (fd == (syx_nint)stderr)
    fd = (syx_nint)GetStdHandle (STD_ERROR_HANDLE);
#else
  fd = fileno ((FILE *)es->message_arguments[0]);
#endif /* WINDOWS */

  t = SYX_IS_TRUE (es->message_arguments[1]);
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

SYX_FUNC_PRIMITIVE (StdIOStream_nextPut)
{
  SYX_PRIM_ARGS(1);
  if (fputc (SYX_CHARACTER(es->message_arguments[0]), stdout) == EOF)
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(es->message_receiver);
}


SYX_FUNC_PRIMITIVE (StdIOStream_nextPutAll)
{
  SYX_PRIM_ARGS(1);
  if (fputs (SYX_OBJECT_SYMBOL(es->message_arguments[0]), stdout) == EOF)
    {
      SYX_PRIM_FAIL;
    }
  SYX_PRIM_RETURN(es->message_receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_fileOp)
{
  syx_int32 op;
  FILE *file;
  syx_int32 ret;
  syx_symbol mode;
  syx_char c;
  syx_int32 count;
  syx_string s;
  SyxOop string;
#ifdef HAVE_FSTAT
  struct stat statbuf;
#endif

  SYX_START_PROFILE;

  SYX_PRIM_ARGS(2);

  op = SYX_SMALL_INTEGER (es->message_arguments[0]);
  file = SYX_OOP_CAST_POINTER (es->message_arguments[1]);
  ret = 0;

  /* except fopen and fdopen ops */
  if (op != 0 && op != 8 && !file) 
    {
      SYX_PRIM_FAIL;
    }

  switch (op)
    {
    case 0: /* open */
      if (!SYX_OBJECT_IS_STRING (es->message_arguments[1]) || !SYX_OBJECT_IS_STRING (es->message_arguments[2]))
        {
          SYX_PRIM_FAIL;
        }

      mode = SYX_OBJECT_SYMBOL (es->message_arguments[2]);
      if (!(file = fopen (SYX_OBJECT_SYMBOL(es->message_arguments[1]), mode)))
        {
          SYX_PRIM_FAIL;
        }

      SYX_PRIM_RETURN (SYX_POINTER_CAST_OOP (file));
      break;

    case 1: /* close */
      ret = fclose (file);
      break;
      
    case 2: /* nextPut: */
      SYX_PRIM_ARGS(3);
      if (!SYX_IS_CHARACTER (es->message_arguments[2]))
        {
          SYX_PRIM_FAIL;
        }

      ret = fputc (SYX_CHARACTER (es->message_arguments[2]), file);
      break;

    case 3: /* nextPutAll: */
      SYX_PRIM_ARGS(3);

      if (SYX_IS_NIL (es->message_arguments[2]))
        {
          ret = 0;
          break;
        }

      ret = fwrite (SYX_OBJECT_DATA (es->message_arguments[2]),
                    sizeof (syx_int8),
                    SYX_OBJECT_DATA_SIZE (es->message_arguments[2]),
                    file);
      break;

    case 4: /* flush */
      ret = fflush (file);
      break;

    case 5: /* next */
      count = read (fileno (file), &c, 1);

      if (!count)
        {
          /* EOF */
          SYX_PRIM_RETURN (syx_nil);
        }
      
      if (count < 0)
        {
          SYX_PRIM_FAIL;
        }

      SYX_PRIM_RETURN (syx_character_new (c));
      break;

    case 6: /* next: */
      SYX_PRIM_ARGS(3);

      if (feof (file))
        {
          SYX_PRIM_RETURN (syx_nil);
        }

      count = SYX_SMALL_INTEGER (es->message_arguments[2]);
      s = (syx_string) syx_malloc (count+1);
      count = read (fileno (file), s, count);

      if (!count)
        {
          syx_free (s);
          SYX_PRIM_RETURN (syx_nil);
        }

      if (count < 0)
        {
          syx_free (s);
          SYX_PRIM_FAIL;
        }

      s[count] = '\0';
      string = syx_string_new_ref (s);
      SYX_PRIM_RETURN (string);
      break;

    case 7: /* size */
#ifdef HAVE_FSTAT
      if ((fstat (fileno(file), &statbuf)) < 0)
        {
          SYX_PRIM_FAIL;
        }
      
      SYX_PRIM_RETURN (syx_small_integer_new (statbuf.st_size));
#else
      SYX_PRIM_RETURN (syx_small_integer_new (0));
#endif
      break;

    case 8: /* fdopen */
      if (SYX_OBJECT_IS_SYMBOL (es->message_arguments[1]))
        {
          if (!strcmp (SYX_OBJECT_SYMBOL (es->message_arguments[1]), "stdin"))
            {
              SYX_PRIM_RETURN (SYX_POINTER_CAST_OOP (stdin));
            }
          else if (!strcmp (SYX_OBJECT_SYMBOL (es->message_arguments[1]), "stdout"))
            {
              SYX_PRIM_RETURN (SYX_POINTER_CAST_OOP (stdout));
            }
          else if (!strcmp (SYX_OBJECT_SYMBOL (es->message_arguments[1]), "stderr"))
            {
              SYX_PRIM_RETURN (SYX_POINTER_CAST_OOP (stderr));
            }
          else
            {
              SYX_PRIM_FAIL;
            }
        }
      if (!SYX_OBJECT_IS_STRING (es->message_arguments[2]))
	{
	  SYX_PRIM_FAIL;
	}
      mode = SYX_OBJECT_SYMBOL (es->message_arguments[2]);
      if (!(file = fdopen (SYX_SMALL_INTEGER(es->message_arguments[1]), mode)))
	{
	  SYX_PRIM_FAIL;
	}
      SYX_PRIM_RETURN (SYX_POINTER_CAST_OOP (file));
      break;
    case 9: /* fileno */
      SYX_PRIM_RETURN (syx_small_integer_new (fileno (file)));
      break;

    default: /* unknown */
      SYX_PRIM_FAIL;
    }

  SYX_END_PROFILE(fileop);

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (String_hash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (syx_string_hash (SYX_OBJECT_SYMBOL (es->message_receiver))));
}

SYX_FUNC_PRIMITIVE (String_asSymbol)
{
  SYX_PRIM_RETURN (syx_symbol_new (SYX_OBJECT_SYMBOL (es->message_receiver)));
}

/* Small integers */

SYX_FUNC_PRIMITIVE (SmallInteger_plus)
{ 
  SyxOop first, second;
  syx_int32 a, b, result;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  syx_int32 a, b, result;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop second;
  syx_int32 a, b;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  syx_int32 a, b, result;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop arg;
  syx_int32 val, shift;
  SYX_PRIM_ARGS(1);

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

#define _GET_Z mpz_t *z = (mpz_t *)SYX_OBJECT_DATA (es->message_receiver);
#define _GET_Z2 mpz_t *op2; _GET_Z
#define _GET_Z2R mpz_t *r; syx_int32 ret; _GET_Z2
#define _GET_ZR mpz_t *r; syx_int32 ret; _GET_Z
#define _GET_OP2 SYX_PRIM_ARGS(1); if (!SYX_OBJECT_IS_LARGE_INTEGER (es->message_arguments[0])) { SYX_PRIM_FAIL; } \
  op2 = (mpz_t *)SYX_OBJECT_DATA (es->message_arguments[0]);
#define _NEW_R r = syx_calloc (1, sizeof (mpz_t)); mpz_init (*r)
#define _RET_R if (mpz_fits_sint_p (*r) && SYX_SMALL_INTEGER_CAN_EMBED (mpz_get_si (*r))) \
    { ret = mpz_get_si (*r); mpz_clear (*r); syx_free (r);        \
      SYX_PRIM_RETURN (syx_small_integer_new (ret)); }                        \
  else                                                                        \
    { SYX_PRIM_RETURN (syx_large_integer_new_mpz (r)); }

#ifdef HAVE_LIBGMP
#define _DO_OP(op)                                \
  _GET_Z2R;                                        \
  _GET_OP2;                                        \
  _NEW_R;                                        \
  op (*r, *z, *op2);                                \
  _RET_R
#else
#define _DO_OP(op) SYX_PRIM_FAIL
#endif /* HAVE_LIBGMP */

#ifdef HAVE_LIBGMP
#define _CMP_OP(op)                                                \
  _GET_Z2;                                                        \
  _GET_OP2;                                                        \
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
  _GET_Z2R;
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
  syx_int32 shift;
  _GET_ZR;
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

SYX_FUNC_PRIMITIVE (Float_asString)
{
  char buf[32];

  sprintf (buf, "%f", SYX_OBJECT_FLOAT(es->message_receiver));
  SYX_PRIM_RETURN(syx_string_new (buf));
}

/* This printing function is used ONLY for tests */
SYX_FUNC_PRIMITIVE (Float_print)
{
  printf ("%f\n", SYX_OBJECT_FLOAT(es->message_receiver));
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Float_plus)
{
  SyxOop first, second;
  SYX_PRIM_ARGS(1);
  
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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS (1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS (1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
  SyxOop first, second;
  SYX_PRIM_ARGS(1);

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
      mpz_t *r;
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
      mpz_t *r;
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
  int ret = (int) SYX_OBJECT_FLOAT (es->message_receiver);

  if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
    {
#ifdef HAVE_LIBGMP
      mpz_t *r;
      _NEW_R;
      mpz_init_set_d (*r, ret);
      SYX_PRIM_RETURN (syx_large_integer_new_mpz (r));
#else
      SYX_PRIM_FAIL;
#endif /* HAVE_LIBGMP */
    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (Float_exp)
{
  double ret = exp (SYX_OBJECT_FLOAT (es->message_receiver));
  SYX_PRIM_RETURN (syx_float_new (ret));
}

SYX_FUNC_PRIMITIVE (Float_ln)
{
  double ret = log (SYX_OBJECT_FLOAT (es->message_receiver));
  SYX_PRIM_RETURN (syx_float_new (ret));
}

SYX_FUNC_PRIMITIVE (Float_sqrt)
{
  double ret = sqrt (SYX_OBJECT_FLOAT (es->message_receiver));
  SYX_PRIM_RETURN (syx_float_new (ret));
}


/* Date and time */

SYX_FUNC_PRIMITIVE (DateTime_milliseconds)
{
  clock_t t;
  
  t = clock ();
  if (t < 0)
    {
      SYX_PRIM_FAIL;
    }

  SYX_PRIM_RETURN (syx_small_integer_new (1000.0 * t / CLOCKS_PER_SEC));
}

SYX_FUNC_PRIMITIVE (DateTime_gmTime)
{
  time_t t;
  struct tm *gm;
  SyxOop ret;
  
  t = time (NULL);
  gm = gmtime (&t);
  if (!gm)
    {
      SYX_PRIM_FAIL;
    }

  ret = syx_array_new_size (8);
  SYX_OBJECT_DATA(ret)[0] = syx_small_integer_new (gm->tm_sec);
  SYX_OBJECT_DATA(ret)[1] = syx_small_integer_new (gm->tm_min);
  SYX_OBJECT_DATA(ret)[2] = syx_small_integer_new (gm->tm_hour);
  SYX_OBJECT_DATA(ret)[3] = syx_small_integer_new (gm->tm_mday);
  SYX_OBJECT_DATA(ret)[4] = syx_small_integer_new (gm->tm_mon);
  SYX_OBJECT_DATA(ret)[5] = syx_small_integer_new (gm->tm_year);
  SYX_OBJECT_DATA(ret)[6] = syx_small_integer_new (gm->tm_wday);
  SYX_OBJECT_DATA(ret)[7] = syx_small_integer_new (gm->tm_yday);
  
  SYX_PRIM_RETURN (ret);
}


/* Object memory and Smalltalk */


SYX_FUNC_PRIMITIVE (ObjectMemory_snapshot)
{
  SyxOop filename;
  syx_bool ret;
  SYX_PRIM_ARGS(1);
  
  filename = es->message_arguments[0];

  /* store the returned object for this process before saving the image */
  syx_interp_stack_push (es->message_receiver);

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
  SyxOop source;
  SyxOop dest;
  syx_bool has_refs;
  SYX_PRIM_ARGS(2);

  source = es->message_arguments[1];
  dest = es->message_arguments[0];
  has_refs = SYX_OBJECT_HAS_REFS(source);

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
  SyxOop oop = es->message_arguments[0];
  SYX_PRIM_ARGS(1);
  if (SYX_IS_OBJECT (oop))
    {
      SYX_OBJECT_IS_CONSTANT(oop) = TRUE;
    }
  SYX_PRIM_RETURN(es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Smalltalk_quit)
{
  syx_int32 status = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_ARGS(1);
  syx_quit ();
  exit (status);
}

SYX_FUNC_PRIMITIVE (Smalltalk_pluginCall)
{
  SyxOop message_arguments[0xFF];
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

  /* save the real state */
  memcpy (message_arguments, es->message_arguments, es->message_arguments_count * sizeof (SyxOop));
  message_arguments_count = es->message_arguments_count;
  es->message_arguments_count = SYX_OBJECT_DATA_SIZE(arguments);
  memcpy (es->message_arguments, SYX_OBJECT_DATA (arguments), es->message_arguments_count * sizeof (SyxOop));

  ret = syx_plugin_call (es, plugin_name, SYX_OBJECT_SYMBOL (func), method);

  /* restore the state */
  memcpy (es->message_arguments, message_arguments, message_arguments_count * sizeof (SyxOop));
  es->message_arguments_count = message_arguments_count;

  return ret;
}

SYX_FUNC_PRIMITIVE (Smalltalk_pluginSymbol)
{
  SyxOop plugin;
  SyxOop func;
  syx_symbol func_name;
  syx_symbol plugin_name;
  SyxOop oop;
  SYX_PRIM_ARGS(2);

  plugin = es->message_arguments[0];
  func = es->message_arguments[1];
  plugin_name = NULL;

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
  SyxOop oop;
  syx_symbol name;
  SYX_PRIM_ARGS(1);

  oop = es->message_arguments[0];
  name = NULL;

  if (!SYX_IS_NIL (oop))
    name = SYX_OBJECT_SYMBOL (oop);
  SYX_PRIM_RETURN(syx_boolean_new (syx_plugin_load (name)));
}

SYX_FUNC_PRIMITIVE (Smalltalk_unloadPlugin)
{
  syx_symbol name;
  SYX_PRIM_ARGS(1);

  name = SYX_OBJECT_SYMBOL(es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_boolean_new (syx_plugin_unload (name)));
}

SYX_FUNC_PRIMITIVE (Smalltalk_environmentVariableAt)
{
  syx_symbol name;
  SYX_PRIM_ARGS(1);

#ifndef WINCE
  name = SYX_OBJECT_SYMBOL(es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_string_new (getenv(name)));
#else /* WINCE */
  SYX_PRIM_RETURN(syx_nil);
#endif
}

SYX_FUNC_PRIMITIVE (CompiledMethod_runOn)
{
  SyxOop context;
  SYX_PRIM_ARGS(2);

  context = syx_method_context_new (es->message_receiver, es->message_arguments[0], es->message_arguments[1]);

  return syx_interp_enter_context (syx_processor_active_process, context);
}

SYX_FUNC_PRIMITIVE (Compiler_parse)
{
  SyxLexer *lexer;
  SyxParser *parser;
  SyxOop string;
  SyxOop meth;
  SyxOop klass;
  SYX_PRIM_ARGS (3);
  
  string = es->message_arguments[0];
  meth = es->message_arguments[1];
  klass = es->message_arguments[2];
  lexer = syx_lexer_new (SYX_OBJECT_SYMBOL (string));
  parser = syx_parser_new (lexer, meth, klass);
  if (!syx_parser_parse (parser, FALSE))
    {
      syx_lexer_free (lexer, FALSE);
      syx_parser_free (parser, FALSE);
      SYX_PRIM_FAIL;
    }

  syx_lexer_free (lexer, FALSE);
  syx_free (parser->instance_names);
  syx_parser_free (parser, FALSE);

  SYX_PRIM_RETURN (meth);
}

SYX_FUNC_PRIMITIVE (Compiler_parseChunk)
{
  SyxLexer *lexer;
  SyxParser *parser;
  SyxOop meth;
  SyxOop pos;
  SyxToken token;
  SyxLexer saved_lexer;
  syx_symbol all_text;
  syx_int32 index;
  syx_string text;
  SYX_PRIM_ARGS (2);

  all_text = SYX_OBJECT_SYMBOL (es->message_arguments[0]);
  pos = es->message_arguments[1];
  index = SYX_SMALL_INTEGER (SYX_OBJECT_DATA(pos)[0]);

  lexer = syx_lexer_new (all_text);
  lexer->_current_text += index;

  /* check for methods definition */
  saved_lexer = *lexer;
  token = syx_lexer_next_token (lexer);
  while (token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "!"))
    {
      if (!syx_cold_parse_methods (lexer))
        {
          SYX_PRIM_FAIL;
        }
      saved_lexer = *lexer;
      token = syx_lexer_next_token (lexer);
    }
  *lexer = saved_lexer;

  /* get the next chunk */
  text = syx_lexer_next_chunk (lexer);
  SYX_OBJECT_DATA(pos)[0] = syx_small_integer_new (lexer->_current_text - lexer->text);
  syx_lexer_free (lexer, FALSE);

  if (!text)
    {
      SYX_PRIM_RETURN (es->message_receiver);
    }

  /* now parse */
  lexer = syx_lexer_new (text);
  meth = syx_method_new ();
  parser = syx_parser_new (lexer, meth, syx_nil);
  if (!syx_parser_parse (parser, TRUE))
    {
      SYX_PRIM_FAIL;
    }
  syx_parser_free (parser, TRUE);
  SYX_METHOD_SELECTOR(meth) = syx_symbol_new ("goDoIt");

  /* finally execute */
  _syx_interp_frame_prepare_new (es, meth);

  SYX_PRIM_RETURN (es->message_receiver);
}

/* CPointer */

SYX_FUNC_PRIMITIVE (CPointer_free)
{
  SyxOop ptr;
  ptr = es->message_receiver;
  if (!SYX_IS_NIL (ptr))
    syx_free (SYX_OOP_CAST_POINTER (ptr));
  
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (CPointer_asString)
{
  SyxOop ptr;
  SyxOop ret;
  ptr = es->message_receiver;
  if (!SYX_IS_NIL (ptr))
    ret = syx_string_new (SYX_OOP_CAST_POINTER (ptr));
  else
    ret = syx_nil;

  SYX_PRIM_RETURN (ret);
}

SYX_FUNC_PRIMITIVE (CPointer_asByteArray)
{
  SyxOop ptr;
  SyxOop ret;
  syx_int32 size;
  SYX_PRIM_ARGS(1);

  ptr = es->message_receiver;
  size = SYX_SMALL_INTEGER(es->message_arguments[0]);
  if (!SYX_IS_NIL (ptr))
    ret = syx_byte_array_new (size, SYX_OOP_CAST_POINTER (ptr));
  else
    ret = syx_nil;

  SYX_PRIM_RETURN (ret);
}

/* CStruct */

static SyxOop type_char;
static SyxOop type_short_int;
static SyxOop type_int;
static SyxOop type_long;
static SyxOop type_pointer;
static SyxOop type_float;
static SyxOop type_double;

INLINE void
_CStruct_initialize_types (void)
{
  static syx_bool _initialized = FALSE;

  if (!_initialized)
    {
      type_char = syx_symbol_new ("char");
      type_short_int = syx_symbol_new ("shortInt");
      type_int = syx_symbol_new ("int");
      type_long = syx_symbol_new ("long");
      type_pointer = syx_symbol_new ("pointer");
      type_float = syx_symbol_new ("float");
      type_double = syx_symbol_new ("double");

      _initialized = TRUE;
    }
}

SYX_FUNC_PRIMITIVE (CStruct_on_type_at)
{
  SyxOop type;
  SyxOop ret;
  char *handle;
  syx_int32 offset;
  SYX_PRIM_ARGS(2);

  _CStruct_initialize_types ();

  handle = SYX_OOP_CAST_POINTER (es->message_arguments[0]);
  type = es->message_arguments[1];
  offset = SYX_SMALL_INTEGER (es->message_arguments[2]);
  
  if (SYX_OOP_EQ (type, type_char))
    ret = syx_character_new (*(handle+offset));
  else if (SYX_OOP_EQ (type, type_short_int))
    ret = syx_small_integer_new (*(syx_int16 *)(handle+offset));
  else if (SYX_OOP_EQ (type, type_int))
    {
      ret = syx_small_integer_new (*(syx_int32 *)(handle+offset));
      if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
        {
          /* FIXME: turn into LargeInteger */
          SYX_PRIM_FAIL;
        }
    }
  else if (SYX_OOP_EQ (type, type_long))
    {
      SYX_PRIM_FAIL;
    }
  else if (SYX_OOP_EQ (type, type_pointer))
    ret = SYX_POINTER_CAST_OOP (*(syx_pointer *)(handle+offset));
  else if (SYX_OOP_EQ (type, type_pointer))
    ret = SYX_POINTER_CAST_OOP (*(syx_pointer *)(handle+offset));
  else if (SYX_OOP_EQ (type, type_float))
    ret = syx_float_new ((syx_double)(*(syx_float *)(handle+offset)));
  else if (SYX_OOP_EQ (type, type_double))
    ret = syx_float_new (*(syx_double *)(handle+offset));
  else
    {
      /* It's a nested struct */
      ret = SYX_POINTER_CAST_OOP (handle+offset);
    }

  SYX_PRIM_RETURN (ret);
}

SYX_FUNC_PRIMITIVE (CStruct_on_type_at_put)
{
  SyxOop type;
  SyxOop value;
  char *handle;
  syx_int32 offset;
  SYX_PRIM_ARGS(2);
  handle = SYX_OOP_CAST_POINTER (es->message_arguments[0]);
  type = es->message_arguments[1];
  offset = SYX_SMALL_INTEGER (es->message_arguments[2]);
  value = es->message_arguments[3];
  
  _CStruct_initialize_types ();

  if (SYX_OOP_EQ (type, type_char))
    *(handle+offset) = SYX_CHARACTER (value);
  else if (SYX_OOP_EQ (type, type_short_int))
    *(syx_int16 *)(handle+offset) = SYX_SMALL_INTEGER (value);
  else if (SYX_OOP_EQ (type, type_int))
    *(syx_int32 *)(handle+offset) = SYX_SMALL_INTEGER (value);
  else if (SYX_OOP_EQ (type, type_long))
    {
      /* TODO */
      SYX_PRIM_FAIL;
    }
  else if (SYX_OOP_EQ (type, type_pointer))
    *(syx_pointer *)(handle+offset) = SYX_OOP_CAST_POINTER (value);
  else if (SYX_OOP_EQ (type, type_float))
    *(syx_float *)(handle+offset) = (syx_float) SYX_OBJECT_FLOAT (value);
  else if (SYX_OOP_EQ (type, type_double))
    *(syx_double *)(handle+offset) = SYX_OBJECT_FLOAT (value);
  else
    {
      /* TODO: nested structures */
      SYX_PRIM_FAIL;
    }

  SYX_PRIM_RETURN (es->message_receiver);
}

/* CStructFieldType */

SYX_FUNC_PRIMITIVE (CStructFieldType_sizeOfLong)
{
  SYX_PRIM_RETURN (syx_small_integer_new (sizeof (syx_nint)));
}

SYX_FUNC_PRIMITIVE (CStructFieldType_sizeOfPointer)
{
  SYX_PRIM_RETURN (syx_small_integer_new (sizeof (syx_pointer)));
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
  { "ArrayedCollection_replaceFromToWithStartingAt", ArrayedCollection_replaceFromToWithStartingAt },

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

  /* Contexts */
  { "ContextPart_parent", ContextPart_parent },
  { "ContextPart_receiver", ContextPart_receiver },
  { "BlockContext_outerContext", BlockContext_outerContext },

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
  { "String_asSymbol", String_asSymbol },

  /* File streams */
  { "StdIOStream_nextPut", StdIOStream_nextPut },
  { "StdIOStream_nextPutAll", StdIOStream_nextPutAll },
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
  { "Float_print", Float_print },
  { "Float_asString", Float_asString },
  { "Float_exp", Float_exp },
  { "Float_ln", Float_ln },
  { "Float_sqrt", Float_sqrt },

  /* Date and time */
  { "DateTime_milliseconds", DateTime_milliseconds },
  { "DateTime_gmTime", DateTime_gmTime },

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
  { "Smalltalk_environmentVariableAt", Smalltalk_environmentVariableAt },

  /* Compiler */
  { "CompiledMethod_runOn", CompiledMethod_runOn },
  { "Compiler_parse", Compiler_parse },
  { "Compiler_parseChunk", Compiler_parseChunk },

  /* CPointer */
  { "CPointer_free", CPointer_free },
  { "CPointer_asString", CPointer_asString },
  { "CPointer_asByteArray", CPointer_asByteArray },

  /* CStruct */
  { "CStruct_on_type_at", CStruct_on_type_at },
  { "CStruct_on_type_at_put", CStruct_on_type_at_put },

  /* CStructFieldType */
  { "CStructFieldType_sizeOfLong", CStructFieldType_sizeOfLong },
  { "CStructFieldType_sizeOfPointer", CStructFieldType_sizeOfPointer }
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
