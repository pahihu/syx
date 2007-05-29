#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-init.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-object.h"

G_BEGIN_DECLS

static syx_bool syx_initialized = FALSE;
static GHashTable *globals;
static syx_symbol syx_root_path;

static void file_in_basic (void);
syx_string find_file (syx_symbol package, syx_symbol filename);

syx_string 
syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename)
{
  syx_string full_path;
  g_return_val_if_fail (domain != NULL, NULL);
  g_return_val_if_fail (package != NULL, NULL);
  full_path = g_build_filename (syx_root_path, domain, package, filename, NULL);
  g_return_val_if_fail (g_file_test (full_path, G_FILE_TEST_EXISTS), NULL);

  return full_path;
}

static void
file_in_basic_decl (void)
{
  syx_string full_filename;
  GError *error = NULL;

  full_filename = syx_find_file ("st", "kernel", "initialDecl.st");
  if (!syx_cold_file_in (full_filename, &error))
    g_error (error->message);
  g_free (full_filename);
}

static void
file_in_basic (void)
{
  syx_symbol *filename;
  syx_string full_filename;
  static syx_symbol kernel_filenames[] = {
    "Behavior.st",
    "Symbol.st",
    "Number.st", "SmallInteger.st",
    "Object.st", "UndefinedObject.st",
    "Collection.st", "Array.st", "ArrayedCollection.st", "SequenceableCollection.st", "OrderedCollection.st",
    "Character.st", "String.st",
    "ContextPart.st", "BlockContext.st",
    "BlockClosure.st",
    "True.st", "False.st",
    "Signal.st", "Exceptions.st", "AnsiExceptions.st",
    "Process.st", "ProcessorScheduler.st", "Semaphore.st",
    "CompiledMethod.st",
    "LookupKey.st", "Association.st",
    "Stream.st", "FileStream.st",
    "Console.st",
    NULL
  };
  GError *error = NULL;

  for (filename = kernel_filenames; *filename; filename++)
    {
      full_filename = syx_find_file ("st", "kernel", *filename);
      if (!syx_cold_file_in (full_filename, &error))
	g_error (error->message);
      g_free (full_filename);
    }
}

inline SyxObject *_syx_create_class (syx_varsize instanceSize)
{
  SyxObject *object = syx_object_new_size (SYX_NIL, SYX_DATA_CLASS_ALL);
  SYX_CLASS_INSTANCE_SIZE(object) = syx_small_integer_new (instanceSize);
  return object;
}

void
syx_build_basic (void)
{
  SyxObject *Object, *Behavior, *Class;

#define CREATE_CLASS(instanceSize)		\
  SYX_CLASS_INSTANCE_SIZE(class) = syx_small_integer_new (instanceSize)

  /* create raw instances of basic classes */
  Object = _syx_create_class (SYX_DATA_OBJECT_ALL);
  Behavior = _syx_create_class (SYX_DATA_CLASS_ALL);
  Class = _syx_create_class (SYX_DATA_CLASS_ALL);
  syx_symbol_class = _syx_create_class (SYX_DATA_SYMBOL_ALL);
  syx_string_class = _syx_create_class (SYX_DATA_STRING_ALL);
  syx_small_integer_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_character_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_array_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_link_class = _syx_create_class (SYX_DATA_LINK_ALL);
  syx_dictionary_class = _syx_create_class (SYX_DATA_DICTIONARY_ALL);
  syx_metaclass_class = _syx_create_class (SYX_DATA_CLASS_ALL);
  syx_globals = syx_dictionary_new (100);
  syx_symbols = syx_dictionary_new (1000);

#define SETUP_CLASS(name, class, superclass)				\
  syx_object_set_class (class, syx_metaclass_new (syx_object_get_class (superclass))); \
  SYX_CLASS_SUPERCLASS(class) = superclass;				\
  SYX_CLASS_NAME(class) = syx_symbol_new (name);			\
  syx_globals_at_put (SYX_CLASS_NAME(class), class)

  syx_object_set_class (Object, syx_metaclass_new (Class));
  SYX_CLASS_SUPERCLASS(Object) = SYX_NIL;
  SYX_CLASS_NAME(Object) = syx_symbol_new ("Object");
  syx_globals_at_put (SYX_CLASS_NAME(Object), Object);

  SETUP_CLASS ("Behavior", Behavior, Object);
  SETUP_CLASS ("Class", Class, Behavior);
  SETUP_CLASS ("Metaclass", syx_metaclass_class, Behavior);
  SETUP_CLASS ("Symbol", syx_symbol_class, Object);
  SETUP_CLASS ("String", syx_string_class, Object);
  SETUP_CLASS ("SmallInteger", syx_small_integer_class, Object);
  SETUP_CLASS ("Character", syx_character_class, Object);
  SETUP_CLASS ("Array", syx_array_class, Object);
  SETUP_CLASS ("Link", syx_link_class, Object);
  SETUP_CLASS ("Dictionary", syx_dictionary_class, Object);
  file_in_basic_decl ();

  syx_array_class = syx_globals_at ("Array");
  syx_compiled_method_class = syx_globals_at ("CompiledMethod");
  syx_compiled_block_class = syx_globals_at ("CompiledBlock");
  syx_block_closure_class = syx_globals_at ("BlockClosure");
  syx_method_context_class = syx_globals_at ("MethodContext");
  syx_block_context_class = syx_globals_at ("BlockContext");
  syx_process_class = syx_globals_at ("Process");
  syx_process_scheduler_class = syx_globals_at ("ProcessScheduler");
  file_in_basic ();

  syx_undefined_object_class = syx_globals_at ("UndefinedObject");
  syx_true_class = syx_globals_at ("True");
  syx_false_class = syx_globals_at ("False");
  syx_link_class = syx_globals_at ("Link");

  syx_scheduler_init ();
  syx_globals_at_put (syx_symbol_new ("Processor"), syx_processor);
  
}
/*
void
syx_init_basic_streams (void)
{
  SyxClass *FileStream;
  SyxInstance *fs;
  GIOChannel *channel;

  FileStream = syx_globals_lookup ("FileStream");
  if (!FileStream)
    g_error ("Missing FileStream class\n");

  channel = g_io_channel_unix_new (0);
  fs = syx_class_create_instance (FileStream);
  SYX_OBJECT(fs)->data = channel;
  syx_globals_replace ("stdin", fs);

  channel = g_io_channel_unix_new (1);
  fs = syx_class_create_instance (FileStream);
  SYX_OBJECT(fs)->data = channel;
  syx_globals_replace ("stdout", fs);
}
*/

void
syx_init (syx_symbol root_path)
{
  g_return_if_fail (syx_initialized == FALSE);
  g_return_if_fail (root_path != NULL);
  g_return_if_fail (syx_set_root_path (root_path));

  g_type_init ();
  syx_memory_init ();
  
  globals = g_hash_table_new (g_str_hash, g_str_equal);

  syx_initialized = TRUE;
}

syx_symbol 
syx_get_root_path (void)
{
  return syx_root_path;
}

syx_bool
syx_set_root_path (syx_symbol root_path)
{
  g_return_val_if_fail (g_file_test (root_path,
				     (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR)),
			FALSE);
  syx_root_path = root_path;
  return TRUE;
}

G_END_DECLS
