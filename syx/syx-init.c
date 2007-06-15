#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include <unistd.h>
#include <stdio.h>
#include "syx-types.h"
#include "syx-error.h"
#include "syx-init.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-interp.h"

static syx_symbol _syx_root_path;

static void _syx_file_in_basic (void);
static void _syx_file_in_basic_decl (void);
static SyxOop _syx_create_class (syx_varsize instanceSize);

//! Creates a file path inside the Syx environment
/*!
  For example if you want a Smalltalk file of a package, specify the domain "st", the package name
  and the file name.
*/
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

  if (access (full_path, R_OK) < 0)
    {
      syx_error ("Can't open file %s\n", full_path);
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
    "Number.st", "SmallInteger.st", "Float.st",
    "Object.st", "UndefinedObject.st", "ObjectMemory.st",
    "Collection.st", "Array.st", "ArrayedCollection.st", "SequenceableCollection.st", "OrderedCollection.st",
    "Character.st", "ByteArray.st", "String.st",
    "ContextPart.st", "BlockContext.st",
    "BlockClosure.st",
    "True.st", "False.st",
    "Signal.st", "Exceptions.st", "AnsiExceptions.st",
    "Process.st", "ProcessorScheduler.st", "Semaphore.st",
    "CompiledMethod.st",
    "LookupKey.st", "Association.st",
    "Stream.st", "FileStream.st",
    "TextCollector.st",
    "Dictionary.st", "SystemDictionary.st",
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

static SyxOop
_syx_create_class (syx_varsize instanceSize)
{
  SyxOop object = syx_object_new_size (syx_nil, TRUE, SYX_DATA_CLASS_ALL);
  SYX_CLASS_INSTANCE_SIZE(object) = syx_small_integer_new (instanceSize);
  return object;
}

//! Builds a basic running image from scratch
/*!
  This functions first reinitialize the memory with the size defined in SYX_INIT_MEMORY_SIZE.
  After, creates the 3 common constants syx_nil, syx_true and syx_false.
  Then creates all the classes needed by the VM, the Smalltalk dictionary and a dictionary containing all the symbols.
  Sets up the basic object hierarchy and insert each class into Smalltalk.
  Ends up this process by fileing in the basic declarations from initialDecl.st and the other *.st files, and calls syx_fetch_basic to fetch all classes in the VM.
  Finally, prepares the environment by running a blocking Process that calls Smalltalk>>initializeSystem and initialize everything else from within Smalltalk itself.
*/  
void
syx_build_basic (void)
{
  SyxOop Object, Behavior, Class;
  SyxOop context;

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

#define _SETUP_CLASS(name, class, superclass)				\
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

  _SETUP_CLASS ("Behavior", Behavior, Object);
  _SETUP_CLASS ("Class", Class, Behavior);
  _SETUP_CLASS ("Metaclass", syx_metaclass_class, Behavior);
  _SETUP_CLASS ("Symbol", syx_symbol_class, Object);
  _SETUP_CLASS ("String", syx_string_class, Object);
  _SETUP_CLASS ("SmallInteger", syx_small_integer_class, Object);
  _SETUP_CLASS ("Character", syx_character_class, Object);
  _SETUP_CLASS ("ByteArray", syx_byte_array_class, Object);
  _SETUP_CLASS ("Array", syx_array_class, Object);
  _SETUP_CLASS ("Link", syx_link_class, Object);
  _SETUP_CLASS ("Dictionary", syx_dictionary_class, Object);
  _syx_file_in_basic_decl ();

  syx_object_set_class (syx_globals, syx_globals_at ("SystemDictionary"));
  SYX_OBJECT(syx_nil)->class = syx_globals_at ("UndefinedObject");
  SYX_OBJECT(syx_true)->class = syx_globals_at ("True");
  SYX_OBJECT(syx_false)->class = syx_globals_at ("False");

  syx_fetch_basic ();
  _syx_file_in_basic ();

  context = syx_send_unary_message (syx_nil, syx_globals, "initializeSystem");
  syx_process_execute_blocking (syx_process_new (context));
}

//! Fetch all the things needed by the VM to run accordly to the image
/*!
  Sets up syx_nil, syx_true and syx_false constants.
  Lookup all classes from the Smalltalk dictionary and insert them into the VM.
  Finally initialize the scheduler
*/
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
  syx_float_class = syx_globals_at ("Float");
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

  syx_scheduler_init ();
}

//! Setup the basic external environment of Syx
/*!
  \param root_path the root directory of Syx
*/
void
syx_init (syx_symbol root_path)
{
  static syx_bool initialized = FALSE;
  if (initialized || !root_path || !syx_set_root_path (root_path))
    return;

  initialized = TRUE;
}

//! Finalize Syx
/*!
  Run special tasks to finalize the Syx process, such as clearing all the allocated memory
*/
void
syx_quit (void)
{
  syx_exec_state_free ();
  syx_memory_clear ();
}

//! Returns the root directory of Syx
/*!
  \return a constant string containing the path of the root directory
*/
syx_symbol 
syx_get_root_path (void)
{
  return _syx_root_path;
}

//! Sets the root directory of Syx
/*!
  \param root_path the new path
  \return TRUE if the path was existing and a valid directory
*/
syx_bool
syx_set_root_path (syx_symbol root_path)
{
  if (access (root_path, R_OK | W_OK) < 0)
     return FALSE;

  _syx_root_path = root_path;
  return TRUE;
}
