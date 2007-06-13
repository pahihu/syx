#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#define _GNU_SOURCE

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-parser.h"
#include "syx-lexer.h"
#include "syx-interp.h"
#include "syx-utils.h"
#include "syx-memory.h"

#define SYX_PRIM_RETURN(object)						\
  syx_interp_stack_push (es, object);					\
  return TRUE

#define SYX_PRIM_FAIL							\
  syx_interp_enter_context (es,						\
			    syx_method_context_new (es->context, method, es->message_receiver, \
						    syx_array_new (es->message_arguments_count, es->message_arguments))); \
  return FALSE

inline SyxOop 
_syx_block_context_new_from_closure (SyxExecState *es, SyxOop arguments)
{
  return syx_block_context_new (es->context,
				SYX_BLOCK_CLOSURE_BLOCK (es->message_receiver),
				arguments,
				SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Processor_yield)
{
  syx_interp_stack_push (es, es->receiver);
  return FALSE;
}

SYX_FUNC_PRIMITIVE (Behavior_new)
{
  SYX_PRIM_RETURN (syx_object_new (es->message_receiver, TRUE));
}

SYX_FUNC_PRIMITIVE (Behavior_newColon)
{
  syx_varsize size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->message_receiver, TRUE, size));
}

SYX_FUNC_PRIMITIVE (ByteArray_newColon)
{
  syx_varsize size = SYX_SMALL_INTEGER (es->message_arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_data (es->message_receiver, FALSE,
				       size,
				       syx_calloc (size, sizeof (syx_int8))));
}

SYX_FUNC_PRIMITIVE (Object_class)
{
  SYX_PRIM_RETURN(syx_object_get_class (es->message_receiver));
}

SYX_FUNC_PRIMITIVE (Object_at)
{
  syx_varsize index;
  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  SYX_PRIM_RETURN(SYX_OBJECT_DATA(es->message_receiver)[index]);
}

SYX_FUNC_PRIMITIVE (Object_at_put)
{
  syx_varsize index;
  SyxOop object;

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  object = es->message_arguments[1];
  SYX_OBJECT_DATA(es->message_receiver)[index] = object;

  SYX_PRIM_RETURN (object);
}

SYX_FUNC_PRIMITIVE (Object_grow_by)
{
  syx_varsize size;

  size = SYX_SMALL_INTEGER(es->message_arguments[0]);
  syx_object_grow_by (es->message_receiver, size);

  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Object_size)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_OBJECT_SIZE (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (Object_identityEqual)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OOP_EQ (es->message_receiver, es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (Object_hash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (syx_object_hash (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (ArrayedCollection_replaceFromWith)
{
  syx_varsize start = SYX_SMALL_INTEGER (es->message_arguments[0]) - 1;
  SyxOop coll = es->message_arguments[1];
  syx_varsize end = SYX_OBJECT_SIZE (coll);
  syx_varsize i;

  // distinguish between arrays and bytearrays
  if (SYX_OBJECT_HAS_REFS (es->message_receiver))
    {
      if (SYX_OBJECT_HAS_REFS (coll))
	memcpy (SYX_OBJECT_DATA (es->message_receiver) + start, SYX_OBJECT_DATA (coll), end * sizeof (SyxOop));
      else
	{
	  for (i=start; i < end; i++)
	    SYX_OBJECT_DATA(es->message_receiver)[i] = syx_character_new (SYX_OBJECT_BYTE_ARRAY(coll)[i]);
	}
    }
  else
    {
      if (!SYX_OBJECT_HAS_REFS (coll))
	memcpy (SYX_OBJECT_BYTE_ARRAY (es->message_receiver) + start,
		SYX_OBJECT_BYTE_ARRAY (coll), end * sizeof (syx_int8));
      else
	g_error ("can't copy from an array to a bytearray");
    }

  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (ByteArray_at)
{
  syx_varsize index;

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  SYX_PRIM_RETURN(syx_character_new (SYX_OBJECT_BYTE_ARRAY(es->message_receiver)[index]));
}

SYX_FUNC_PRIMITIVE (ByteArray_at_put)
{
  syx_varsize index;
  SyxOop oop = es->message_arguments[1];

  index = SYX_SMALL_INTEGER(es->message_arguments[0]) - 1;
  SYX_OBJECT_BYTE_ARRAY(es->message_receiver)[index] = SYX_CHARACTER (oop);
  SYX_PRIM_RETURN (oop);
}



SYX_FUNC_PRIMITIVE (BlockClosure_asContext)
{
  SyxOop args;
  args = syx_array_new_ref (SYX_OBJECT_SIZE(es->message_arguments[0]), SYX_OBJECT_DATA(es->message_arguments[0]));
  SYX_PRIM_RETURN (_syx_block_context_new_from_closure (es, args));
}

SYX_FUNC_PRIMITIVE (BlockClosure_value)
{
  syx_memory_gc_begin ();
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));
  syx_memory_gc_end ();
  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_valueWith)
{
  SyxOop args;
  SyxOop ctx;

  syx_memory_gc_begin ();
  args = syx_array_new_size (1);
  SYX_OBJECT_DATA(args)[0] = es->message_arguments[0];
  ctx = _syx_block_context_new_from_closure (es, args);
  syx_memory_gc_end ();
  return syx_interp_enter_context (es, ctx);
}
  
SYX_FUNC_PRIMITIVE (BlockClosure_valueWithArguments)
{
  SyxOop args, ctx;
  args = syx_array_new_ref (SYX_OBJECT_SIZE(es->message_arguments[0]), SYX_OBJECT_DATA(es->message_arguments[0]));
  ctx = _syx_block_context_new_from_closure (es, args);
  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_on_do)
{
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));

  SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx) = es->message_arguments[0];
  SYX_BLOCK_CONTEXT_HANDLER_BLOCK (ctx) = es->message_arguments[1];

  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_newProcess)
{
  SyxOop ctx;
  SyxOop proc;

  ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));
  SYX_METHOD_CONTEXT_PARENT (ctx) = syx_nil;
  SYX_METHOD_CONTEXT_RETURN_CONTEXT (ctx) = syx_nil;
  proc = syx_process_new (ctx);

  SYX_PRIM_RETURN (proc);
}

/* These printing function are used ONLY for tests */
SYX_FUNC_PRIMITIVE (Symbol_asString)
{
  SYX_PRIM_RETURN (syx_string_new (SYX_OBJECT_SYMBOL (es->message_receiver)));
}

SYX_FUNC_PRIMITIVE (String_print)
{
  printf ("%s\n", SYX_OBJECT_SYMBOL(es->message_receiver));
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (SmallInteger_print)
{
  printf ("%d\n", SYX_SMALL_INTEGER(es->message_receiver));
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Processor_enter)
{
  return syx_interp_enter_context (es, es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_swapWith)
{
  return syx_interp_swap_context (es, es->message_arguments[0]);
}

SYX_FUNC_PRIMITIVE (Processor_leaveTo_andAnswer)
{
  SYX_METHOD_CONTEXT_RETURN_CONTEXT(es->context) = es->message_arguments[0];
  return syx_interp_leave_context_and_answer (es, es->message_arguments[1], TRUE);
}

SYX_FUNC_PRIMITIVE (Signal_findHandlerContext)
{
  SyxOop eClass;
  SyxOop hClass;
  SyxOop ctx = SYX_METHOD_CONTEXT_PARENT (es->context);

  eClass = syx_object_get_class (es->message_receiver);
  while (!SYX_IS_NIL (ctx))
    {
      if (SYX_OOP_EQ (syx_object_get_class (ctx), syx_block_context_class))
	{
	  hClass = SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx);
	  if (!SYX_IS_NIL (hClass) && (SYX_OOP_EQ (eClass, hClass) || syx_class_is_superclass_of (hClass, eClass)))
	    SYX_PRIM_RETURN (ctx);
	}

      ctx = SYX_METHOD_CONTEXT_PARENT (ctx);
    }

  SYX_PRIM_RETURN (syx_nil);
}

SYX_FUNC_PRIMITIVE (Character_new)
{
  SyxOop c = syx_character_new (20);
  if (SYX_IS_SMALL_INTEGER (c)) g_error("asd");
  SYX_PRIM_RETURN (syx_character_new (SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (Character_value)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_CHARACTER (es->message_receiver)));
}


SYX_FUNC_PRIMITIVE (Semaphore_signal)
{
  syx_semaphore_signal (es->message_receiver);
  SYX_PRIM_RETURN (es->message_receiver);
}

SYX_FUNC_PRIMITIVE (Semaphore_wait)
{
  syx_semaphore_wait (es->message_receiver);
  SYX_PRIM_RETURN (es->message_receiver);
}

/* File streams */

SYX_FUNC_PRIMITIVE (FileStream_fileOp)
{
  syx_int32 fd = SYX_SMALL_INTEGER (es->message_arguments[1]);
  syx_int32 ret = 0;

  switch (SYX_SMALL_INTEGER (es->message_arguments[0]))
    {
    case 0: // open
      {
	syx_symbol mode = SYX_OBJECT_SYMBOL (es->message_arguments[1]);
	syx_int32 flags = 0;

	if (!strcmp (mode, "r"))
	  flags |= O_RDONLY;
	else if (!strcmp (mode, "w"))
	  flags |= O_WRONLY;
	else if (!strcmp (mode, "r+"))
	  flags |= O_RDWR;
	else
	  g_error ("mh? %s\n", mode);
	
	ret = open (SYX_OBJECT_SYMBOL(es->message_arguments[0]), flags);
      }
      break;

    case 1: // close
      ret = close (fd);
      break;
      
    case 2: // nextPut:
      {
	syx_char c = SYX_CHARACTER (es->message_arguments[2]);
	ret = write (fd, &c, 1);
      }
      break;

    case 3: // nextPutAll:
      ret = write (fd, SYX_OBJECT_SYMBOL (es->message_arguments[2]),
		   SYX_OBJECT_SIZE (es->message_arguments[2]));
      break;

    case 4: // flush
//      ret = fsync (fd);
      break;

    case 5: // next
      {
	syx_char c;
	read (fd, &c, 1);
	SYX_PRIM_RETURN (syx_character_new (c));
      }
      break;

    case 6: // nextAll:
      {
	syx_int32 count = SYX_SMALL_INTEGER (es->message_arguments[2]);
	syx_char s[count];
	SyxOop string;

	count = read (fd, s, count);
	s[count] = '\0';

	string = syx_string_new (s);
	SYX_PRIM_RETURN (string);
      }
      break;

    default: // unknown
      g_error ("Unknown file operation: %d\n", SYX_SMALL_INTEGER (es->message_arguments[0]));

    }

  SYX_PRIM_RETURN (syx_small_integer_new (ret));
}

SYX_FUNC_PRIMITIVE (String_compile)
{
  SyxLexer *lexer;
  SyxParser *parser;
  SyxOop meth;

  lexer = syx_lexer_new (SYX_OBJECT_SYMBOL (es->message_receiver));
  if (!lexer)
    {
      SYX_PRIM_RETURN (syx_nil);
    }

  meth = syx_method_new ();
  parser = syx_parser_new (lexer, meth, NULL);
  if (!syx_parser_parse (parser, NULL))
    {
      SYX_PRIM_FAIL;
    }

  syx_lexer_free (lexer, FALSE);
  syx_parser_free (parser, FALSE);

  SYX_PRIM_RETURN (meth);
}

/* Small integers */

SYX_FUNC_PRIMITIVE (SmallInteger_plus)
{
  syx_int32 first, second;
  first = SYX_SMALL_INTEGER(es->message_receiver);
  second = SYX_SMALL_INTEGER(es->message_arguments[0]);
  SYX_PRIM_RETURN (syx_small_integer_new (first + second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_minus)
{
  syx_int32 first, second;
  first = SYX_SMALL_INTEGER(es->message_receiver);
  second = SYX_SMALL_INTEGER(es->message_arguments[0]);
  SYX_PRIM_RETURN (syx_small_integer_new (first - second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_lt)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) < SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_gt)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) > SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_le)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) <= SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ge)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) >= SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_eq)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) == SYX_SMALL_INTEGER (es->message_arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ne)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->message_receiver) == SYX_SMALL_INTEGER (es->message_arguments[0])));
}

static SyxPrimitiveEntry primitive_entries[] = {
  { "Processor_yield", Processor_yield },

  /* Common for objects */
  { "Object_class", Object_class },
  { "Behavior_new", Behavior_new },
  { "Behavior_newColon", Behavior_newColon },
  { "Object_at", Object_at },
  { "Object_at_put", Object_at_put },
  { "Object_size", Object_size },
  { "Object_identityEqual", Object_identityEqual },
  { "Object_hash", Object_hash },

  /* Arrayed collections */
  { "ArrayedCollection_replaceFromWith", ArrayedCollection_replaceFromWith },

  /* Byte arrays */
  { "ByteArray_newColon", ByteArray_newColon },
  { "ByteArray_at", ByteArray_at },
  { "ByteArray_at_put", ByteArray_at_put },

  { "BlockClosure_asContext", BlockClosure_asContext },
  { "BlockClosure_value", BlockClosure_value },
  { "BlockClosure_valueWith", BlockClosure_valueWith },
  { "BlockClosure_valueWithArguments", BlockClosure_valueWithArguments },
  { "BlockClosure_on_do", BlockClosure_on_do },
  { "BlockClosure_newProcess", BlockClosure_newProcess },

  { "Symbol_asString", Symbol_asString },
  { "String_print", String_print },
  { "SmallInteger_print", SmallInteger_print },

  /* Interpreter */
  { "Processor_enter", Processor_enter },
  { "Processor_swapWith", Processor_swapWith },
  { "Processor_leaveTo_andAnswer", Processor_leaveTo_andAnswer },

  { "Signal_findHandlerContext", Signal_findHandlerContext },
  { "Character_new", Character_new },
  { "Character_value", Character_value },
  { "Semaphore_signal", Semaphore_signal },
  { "Semaphore_wait", Semaphore_wait },
  { "String_compile", String_compile },

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

  { NULL }
};

inline SyxPrimitiveEntry *
syx_primitive_get_entry (syx_int32 index)
{
  if (index < SYX_PRIMITIVES_MAX)
    return &primitive_entries[index];

  return NULL;
}

syx_int32
syx_primitive_get_index (syx_symbol name)
{
  syx_int32 i;

  for (i=0; i < SYX_PRIMITIVES_MAX; i++)
    {
      if (!strcmp (primitive_entries[i].name, name))
	return i;
    }

  return -1;
}
