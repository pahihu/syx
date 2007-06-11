#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include <stdio.h>
#include "syx-types.h"
#include "syx-init.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-interp.h"

static syx_symbol _syx_root_path;

static void _syx_file_in_basic (void);
static void _syx_file_in_basic_decl (void);

syx_string 
syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename)
{
  syx_string full_path;

  if (!domain || !package || !filename)
    return NULL;

  full_path = syx_calloc (strlen (_syx_root_path) + strlen (domain) + strlen (package) + strlen (filename) + 4, sizeof (syx_char));

  sprintf (full_path, "%s%c%s%c%s%c%s",
	   _syx_root_path, SYX_PATH_SEPARATOR,
	   domain, SYX_PATH_SEPARATOR,
	   package, SYX_PATH_SEPARATOR,
	   filename);

  if (!g_file_test (full_path, G_FILE_TEST_EXISTS))
    {
      syx_free (full_path);
      return NULL;
    }

  return full_path;
}

static void
_syx_file_in_basic_decl (void)
{
  syx_string full_filename;

  full_filename = syx_find_file ("st", "kernel", "initialDecl.st");
  syx_cold_file_in (full_filename);
  syx_free (full_filename);
}

static void
_syx_file_in_basic (void)
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
    "SystemDictionary.st",
    "Console.st",
    NULL
  };

  for (filename = kernel_filenames; *filename; filename++)
    {
      full_filename = syx_find_file ("st", "kernel", *filename);
      syx_cold_file_in (full_filename);
      syx_free (full_filename);
    }
}

inline SyxOop _syx_create_class (syx_varsize instanceSize)
{
  SyxOop object = syx_object_new_size (syx_nil, TRUE, SYX_DATA_CLASS_ALL);
  SYX_CLASS_INSTANCE_SIZE(object) = syx_small_integer_new (instanceSize);
  return object;
}

void
syx_build_basic (void)
{
  SyxOop Object, Behavior, Class;

  syx_memory_clear ();
  syx_memory_init (SYX_INIT_MEMORY_SIZE);

  /* allocate constants */
  syx_nil = syx_memory_alloc ();
  syx_true = syx_memory_alloc ();
  syx_false = syx_memory_alloc ();

  /* create raw instances of basic classes */
  Object = _syx_create_class (SYX_DATA_OBJECT_ALL);
  Behavior = _syx_create_class (SYX_DATA_CLASS_ALL);
  Class = _syx_create_class (SYX_DATA_CLASS_ALL);
  syx_symbol_class = _syx_create_class (SYX_DATA_SYMBOL_ALL);
  syx_string_class = _syx_create_class (SYX_DATA_STRING_ALL);
  syx_small_integer_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_character_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_byte_array_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_array_class = _syx_create_class (SYX_DATA_OBJECT_ALL);
  syx_link_class = _syx_create_class (SYX_DATA_LINK_ALL);
  syx_dictionary_class = _syx_create_class (SYX_DATA_DICTIONARY_ALL);
  syx_metaclass_class = _syx_create_class (SYX_DATA_CLASS_ALL);

  syx_globals = syx_dictionary_new (100);
  syx_symbols = syx_dictionary_new (1000);
  syx_globals_at_put (syx_symbol_new ("Smalltalk"), syx_globals);

#define SETUP_CLASS(name, class, superclass)				\
  syx_object_set_class (class, syx_metaclass_new (syx_object_get_class (superclass))); \
  SYX_CLASS_SUPERCLASS(class) = superclass;				\
  SYX_CLASS_NAME(class) = syx_symbol_new (name);			\
  SYX_CLASS_METHODS(class) = syx_dictionary_new (50);			\
  syx_globals_at_put (SYX_CLASS_NAME(class), class)

  syx_object_set_class (Object, syx_metaclass_new (Class));
  SYX_CLASS_SUPERCLASS(Object) = syx_nil;
  SYX_CLASS_NAME(Object) = syx_symbol_new ("Object");
  SYX_CLASS_METHODS(Object) = syx_dictionary_new (50);
  syx_globals_at_put (SYX_CLASS_NAME(Object), Object);

  SETUP_CLASS ("Behavior", Behavior, Object);
  SETUP_CLASS ("Class", Class, Behavior);
  SETUP_CLASS ("Metaclass", syx_metaclass_class, Behavior);
  SETUP_CLASS ("Symbol", syx_symbol_class, Object);
  SETUP_CLASS ("String", syx_string_class, Object);
  SETUP_CLASS ("SmallInteger", syx_small_integer_class, Object);
  SETUP_CLASS ("Character", syx_character_class, Object);
  SETUP_CLASS ("ByteArray", syx_byte_array_class, Object);
  SETUP_CLASS ("Array", syx_array_class, Object);
  SETUP_CLASS ("Link", syx_link_class, Object);
  SETUP_CLASS ("Dictionary", syx_dictionary_class, Object);
  _syx_file_in_basic_decl ();

  syx_object_set_class (syx_globals, syx_globals_at ("SystemDictionary"));
  SYX_OBJECT(syx_nil)->class = syx_globals_at ("UndefinedObject");
  SYX_OBJECT(syx_true)->class = syx_globals_at ("True");
  SYX_OBJECT(syx_false)->class = syx_globals_at ("False");

  syx_fetch_basic ();
  _syx_file_in_basic ();
}

void
syx_fetch_basic (void)
{
  syx_nil.idx = 0;
  syx_true.idx = 1;
  syx_false.idx = 2;

  syx_metaclass_class = syx_globals_at ("Metaclass");
  syx_symbol_class = syx_globals_at ("Symbol");
  syx_string_class = syx_globals_at ("String");
  syx_small_integer_class = syx_globals_at ("SmallInteger");
  syx_character_class = syx_globals_at ("Character");
  syx_byte_array_class = syx_globals_at ("ByteArray");
  syx_array_class = syx_globals_at ("Array");
  syx_link_class = syx_globals_at ("Link");
  syx_dictionary_class = syx_globals_at ("Dictionary");

  syx_compiled_method_class = syx_globals_at ("CompiledMethod");
  syx_compiled_block_class = syx_globals_at ("CompiledBlock");
  syx_block_closure_class = syx_globals_at ("BlockClosure");
  syx_method_context_class = syx_globals_at ("MethodContext");
  syx_block_context_class = syx_globals_at ("BlockContext");
  syx_process_class = syx_globals_at ("Process");
  syx_processor_scheduler_class = syx_globals_at ("ProcessorScheduler");
  syx_link_class = syx_globals_at ("Link");
}

void
syx_init (syx_symbol root_path)
{
  static syx_bool initialized = FALSE;
  if (initialized || !root_path || !syx_set_root_path (root_path))
    return;

  initialized = TRUE;
}

void
syx_init_system (void)
{
  SyxOop context;

  syx_scheduler_init ();
  context = syx_send_unary_message (syx_nil, syx_globals, "initializeSystem");
  syx_process_execute_blocking (syx_process_new (context));
}

void
syx_quit (void)
{
  syx_memory_clear ();
}

syx_symbol 
syx_get_root_path (void)
{
  return _syx_root_path;
}

syx_bool
syx_set_root_path (syx_symbol root_path)
{
  if (!g_file_test (root_path, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR))
    return FALSE;

  _syx_root_path = root_path;
  return TRUE;
}
