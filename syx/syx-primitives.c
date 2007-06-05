#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include <stdio.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-scheduler.h"
#include "syx-parser.h"
#include "syx-lexer.h"
#include "syx-interp.h"
#include "syx-utils.h"
#include "syx-memory.h"

#define SYX_PRIM_RETURN(object)						\
  syx_interp_leave_context_and_answer (es, (object), FALSE);		\
  return TRUE

inline SyxOop 
_syx_block_context_new_from_closure (SyxExecState *es, SyxOop arguments)
{
  return syx_block_context_new (SYX_METHOD_CONTEXT_PARENT (es->context),
				SYX_BLOCK_CLOSURE_BLOCK (es->receiver),
				arguments,
				SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(es->receiver));
}

SYX_FUNC_PRIMITIVE (Behavior_new)
{
  SYX_PRIM_RETURN (syx_object_new (es->receiver, TRUE));
}

SYX_FUNC_PRIMITIVE (Behavior_basicNew)
{
  syx_varsize size = SYX_SMALL_INTEGER (es->arguments[0]);
  SYX_PRIM_RETURN(syx_object_new_size (es->receiver, TRUE, size));
}

SYX_FUNC_PRIMITIVE (Object_class)
{
  SYX_PRIM_RETURN(syx_object_get_class (es->receiver));
}

SYX_FUNC_PRIMITIVE (Object_at)
{
  syx_varsize index;
  index = SYX_SMALL_INTEGER(es->arguments[0]);
  SYX_PRIM_RETURN(SYX_OBJECT_DATA(es->receiver)[index]);
}

SYX_FUNC_PRIMITIVE (Object_at_put)
{
  syx_varsize index;
  SyxOop ptr;

  index = SYX_SMALL_INTEGER(es->arguments[0]);
  ptr = es->arguments[1];
  SYX_OBJECT_DATA(es->receiver)[index] = ptr;

  SYX_PRIM_RETURN (ptr);
}

SYX_FUNC_PRIMITIVE (Object_grow_by)
{
  syx_varsize size;

  size = SYX_SMALL_INTEGER(es->arguments[0]);
  syx_object_grow_by (es->receiver, size);

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (Object_size)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_OBJECT_SIZE (es->receiver)));
}

SYX_FUNC_PRIMITIVE (Object_identityEqual)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_OOP_EQ (es->receiver, es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (Object_hash)
{
  SYX_PRIM_RETURN (syx_small_integer_new (syx_object_hash (es->receiver)));
}

SYX_FUNC_PRIMITIVE (BlockClosure_asContext)
{
  SYX_PRIM_RETURN (_syx_block_context_new_from_closure (es, es->arguments[0]));
}

SYX_FUNC_PRIMITIVE (BlockClosure_value)
{
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));
  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_valueWith)
{
  SyxOop args;
  SyxOop ctx;

  args = syx_array_new_size (1);
  SYX_OBJECT_DATA(args)[0] = es->arguments[0];
  ctx = _syx_block_context_new_from_closure (es, args);
  return syx_interp_enter_context (es, ctx);
}
  
SYX_FUNC_PRIMITIVE (BlockClosure_valueWithArguments)
{
  SyxOop ctx = _syx_block_context_new_from_closure (es, es->arguments[0]);
  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_on_do)
{
  SyxOop ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));

  SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx) = es->arguments[0];
  SYX_BLOCK_CONTEXT_HANDLER_BLOCK (ctx) = es->arguments[1];

  return syx_interp_enter_context (es, ctx);
}

SYX_FUNC_PRIMITIVE (BlockClosure_newProcess)
{
  SyxOop ctx;
  SyxOop proc;

  ctx = _syx_block_context_new_from_closure (es, syx_array_new_size (0));
  SYX_METHOD_CONTEXT_RETURN_CONTEXT (ctx) = SYX_NIL;
  proc = syx_process_new (ctx);

  SYX_PRIM_RETURN (proc);
}

/* These printing function are used ONLY for tests */
SYX_FUNC_PRIMITIVE (Symbol_print)
{
  printf ("%s\n", SYX_OBJECT_STRING(es->receiver));
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (String_print)
{
  printf ("%s\n", SYX_OBJECT_SYMBOL(es->receiver));
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (SmallInteger_print)
{
  printf ("%d\n", SYX_SMALL_INTEGER(es->receiver));
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (Context_enter)
{
  return syx_interp_enter_context (es, es->arguments[0]);
}

SYX_FUNC_PRIMITIVE (Context_swapWith)
{
  return syx_interp_swap_context (es, es->arguments[0]);
}

SYX_FUNC_PRIMITIVE (Context_returnTo_andAnswer)
{
  SYX_METHOD_CONTEXT_RETURN_CONTEXT(es->context) = es->arguments[0];
  return syx_interp_leave_context_and_answer (es, es->arguments[1], TRUE);
}

SYX_FUNC_PRIMITIVE (Signal_findHandlerContext)
{
  SyxOop eClass;
  SyxOop hClass;
  SyxOop ctx = SYX_METHOD_CONTEXT_PARENT (es->context);

  eClass = syx_object_get_class (es->receiver);
  while (!SYX_IS_NIL (ctx))
    {
      if (SYX_OOP_EQ (syx_object_get_class (ctx), syx_block_context_class))
	{
	  hClass = SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION (ctx);
	  if (SYX_OOP_EQ (eClass, hClass) || syx_class_is_superclass_of (hClass, eClass))
	    SYX_PRIM_RETURN (ctx);
	}

      ctx = SYX_METHOD_CONTEXT_PARENT (ctx);
    }

  SYX_PRIM_RETURN (SYX_NIL);
}

SYX_FUNC_PRIMITIVE (Character_new)
{
  SYX_PRIM_RETURN (syx_character_new (SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (Character_value)
{
  SYX_PRIM_RETURN (syx_small_integer_new (SYX_CHARACTER (es->receiver)));
}


SYX_FUNC_PRIMITIVE (Semaphore_signal)
{
  syx_semaphore_signal (es->receiver);
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (Semaphore_wait)
{
  syx_semaphore_wait (es->receiver);
  SYX_PRIM_RETURN (es->receiver);
}

/* File streams */

static gboolean
_channel_watcher (GIOChannel *channel, GIOCondition condition, syx_pointer data)
{
  /*  SyxOop semaphore = SYX_POINTER(data);
      syx_semaphore_signal (semaphore);*/
  return FALSE;
}

SYX_FUNC_PRIMITIVE (FileStream_new)
{
  /*  SyxOop filestream;
  GIOChannel *channel;
  syx_int32 fd;

  fd = SYX_SMALL_INTEGER(SYX_PRIM_ARG(0));
  channel = g_io_channel_unix_new (fd);
  if (!channel)
    return SYX_FALSE;

    filestream = syx_class_create_instance (SYX_CLASS (receiver));
    filestream->data = channel;*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_newFile)
{
  /*  SyxOop filestream;
  GIOChannel *channel;
  gchar *filename;
  gchar *mode;
  g_return_val_if_fail (arguments->len == 2, NULL);

  filename = syx_string_fetch (arguments->pdata[0]);
  mode = syx_string_fetch (arguments->pdata[1]);

  channel = g_io_channel_new_file (filename, mode, NULL);
  if (!channel)
    return NULL;

  g_free (filename);
  g_free (mode);

  filestream = syx_class_create_instance (SYX_CLASS (receiver));
  filestream->data = channel;*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_addWatchForInput)
{
  /*  GIOChannel *channel;
  GSource *source;
  SyxOop semaphore;
  g_return_val_if_fail (arguments->len > 0, NULL);

  semaphore = arguments->pdata[0];
  if (!semaphore)
    return NULL;

  channel = SYX_OBJECT(receiver)->data;
  source = g_io_create_watch (channel, G_IO_IN);
  g_source_set_callback (source, (GSourceFunc)_channel_watcher, semaphore, NULL);
  syx_scheduler_add_source (source);*/
  
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_readChar)
{
  /*  GIOChannel *channel;
  gchar c;

  channel = SYX_OBJECT(receiver)->data;
  g_io_channel_read_chars (channel, &c, 1, NULL, NULL);*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_addWatchForOutput)
{
  /*  GIOChannel *channel;
  GSource *source;
  SyxOop semaphore;
  g_return_val_if_fail (arguments->len > 0, NULL);

  semaphore = arguments->pdata[0];
  if (!semaphore)
    return NULL;

  channel = SYX_OBJECT(receiver)->data;
  if (!channel)
    return NULL;

  source = g_io_create_watch (channel, G_IO_OUT);
  g_source_set_callback (source, (GSourceFunc)_channel_watcher, semaphore, NULL);
  syx_scheduler_add_source (source);*/
  
  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_writeChar)
{
  /*  GIOChannel *channel;
  gchar c;
  g_return_val_if_fail (arguments->len > 0, NULL);

  c = SYX_CHARACTER(arguments->pdata[0])->value;
  channel = SYX_OBJECT(receiver)->data;
  g_io_channel_write_chars (channel, &c, 1, NULL, NULL);*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_shutdown)
{
  /*  GIOChannel *channel;
  g_return_val_if_fail (arguments->len > 0, NULL);

  channel = SYX_OBJECT(receiver)->data;
  g_io_channel_shutdown (channel, arguments->pdata[0] == SYX_TRUE, NULL);*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (FileStream_flush)
{
  /*  GIOChannel *channel;

  channel = SYX_OBJECT(receiver)->data;
  g_io_channel_flush (channel, NULL);*/

  SYX_PRIM_RETURN (es->receiver);
}

SYX_FUNC_PRIMITIVE (String_compile)
{
  /*  SyxLexer *lexer;
  SyxParser *parser;
  SyxMethod *method;
  gchar *chunk;

  chunk = syx_string_fetch (receiver);
  if (!chunk)
    return NULL;

  lexer = syx_lexer_new (chunk);
  method = syx_method_new ();
  parser = syx_parser_new (lexer, method, NULL, FALSE, NULL);

  if (!syx_parser_parse (parser, NULL))
  return NULL;*/

  SYX_PRIM_RETURN (es->receiver);
}

/* Small integers */

SYX_FUNC_PRIMITIVE (SmallInteger_plus)
{
  syx_int32 first, second;
  first = SYX_SMALL_INTEGER(es->receiver);
  second = SYX_SMALL_INTEGER(es->arguments[0]);
  SYX_PRIM_RETURN (syx_small_integer_new (first + second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_minus)
{
  syx_int32 first, second;
  first = SYX_SMALL_INTEGER(es->receiver);
  second = SYX_SMALL_INTEGER(es->arguments[0]);
  SYX_PRIM_RETURN (syx_small_integer_new (first - second));
}

SYX_FUNC_PRIMITIVE (SmallInteger_lt)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) < SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_gt)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) > SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_le)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) <= SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ge)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) >= SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_eq)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) == SYX_SMALL_INTEGER (es->arguments[0])));
}

SYX_FUNC_PRIMITIVE (SmallInteger_ne)
{
  SYX_PRIM_RETURN (syx_boolean_new (SYX_SMALL_INTEGER (es->receiver) == SYX_SMALL_INTEGER (es->arguments[0])));
}

#define MAX_PRIMITIVES 42

static SyxPrimitiveEntry primitive_entries[] = {
  { "Object_class", Object_class },
  { "Behavior_new", Behavior_new },
  { "Behavior_basicNew", Behavior_basicNew },
  { "Object_at", Object_at },
  { "Object_at_put", Object_at_put },
  { "Object_size", Object_size },
  { "Object_identityEqual", Object_identityEqual },
  { "Object_hash", Object_hash },

  { "BlockClosure_asContext", BlockClosure_asContext },
  { "BlockClosure_value", BlockClosure_value },
  { "BlockClosure_valueWith", BlockClosure_valueWith },
  { "BlockClosure_valueWithArguments", BlockClosure_valueWithArguments },
  { "BlockClosure_on_do", BlockClosure_on_do },
  { "BlockClosure_newProcess", BlockClosure_newProcess },

  { "Symbol_print", Symbol_print },
  { "String_print", String_print },
  { "SmallInteger_print", SmallInteger_print },

  /* Contexts */
  { "Context_enter", Context_enter },
  { "Context_swapWith", Context_swapWith },
  { "Context_returnTo_andAnswer", Context_returnTo_andAnswer },

  { "Signal_findHandlerContext", Signal_findHandlerContext },
  { "Character_new", Character_new },
  { "Character_value", Character_value },
  { "Semaphore_signal", Semaphore_signal },
  { "Semaphore_wait", Semaphore_wait },
  { "String_compile", String_compile },

  /* File streams */
  { "FileStream_new", FileStream_new },
  { "FileStream_newFile", FileStream_newFile },
  { "FileStream_addWatchForInput", FileStream_addWatchForInput },
  { "FileStream_readChar", FileStream_readChar },
  { "FileStream_addWatchForOutput", FileStream_addWatchForOutput },
  { "FileStream_writeChar", FileStream_writeChar },
  { "FileStream_shutdown", FileStream_shutdown },
  { "FileStream_flush", FileStream_flush },

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

SyxPrimitiveEntry *
syx_primitive_get_entry (syx_int32 index)
{
  if (index < MAX_PRIMITIVES)
    return &primitive_entries[index];

  return NULL;
}

syx_int32
syx_primitive_get_index (syx_symbol name)
{
  syx_int32 i;

  for (i=0; i < MAX_PRIMITIVES; i++)
    {
      if (!g_strcasecmp (primitive_entries[i].name, name))
	return i;
    }

  return -1;
}
