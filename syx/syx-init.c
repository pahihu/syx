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

/*! \mainpage Smalltalk YX
    
    \b Smalltalk \b YX is an open source Smalltalk-80 implementation. 
    It's written in C and has these purposes:

        - Readable code 
        - Flexibility trough easy creations of plugins 
        - Highly portable
        - Optimized 
        - Modern 
        - Embedding in C applications 
        - Easy to use, powerful and well-structured environment 
        - Small
*/

#include "syx-memory.h"
#include "syx-types.h"
#include "syx-error.h"
#include "syx-plugins.h"
#include "syx-init.h"
#include "syx-signal.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-object.h"
#include "syx-interp.h"
#include "syx-profile.h"

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#include <stdio.h>

syx_bool syx_system_initialized = FALSE;

static syx_string _syx_root_path;
static syx_string _syx_image_path;
static syx_varsize _syx_argc;
static syx_string *_syx_argv;

static void _syx_file_in_basic (void);
static void _syx_file_in_basic_decl (void);
static SyxOop _syx_create_class (syx_varsize instanceSize);

/*!
  Creates a file path inside the Syx environment

  For example if you want a Smalltalk file of a package, specify the domain "st", the package name
  and the file name.
*/
syx_string 
syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename)
{
  syx_string full_path;

  if (!domain || !package || !filename)
    return NULL;

  full_path = (syx_string) syx_calloc (strlen (_syx_root_path)
				       + strlen (domain)
				       + strlen (package)
				       + strlen (filename) + 4, sizeof (syx_char));

  sprintf (full_path, "%s%c%s%c%s%c%s",
	   _syx_root_path, SYX_PATH_SEPARATOR,
	   domain, SYX_PATH_SEPARATOR,
	   package, SYX_PATH_SEPARATOR,
	   filename);

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
    "Behavior.st", "Metaclass.st",
    "Symbol.st",
    "Magnitude.st", "Number.st", "Integer.st", "SmallInteger.st", "LargeInteger.st", "Fraction.st", "Float.st",
    "Object.st", "UndefinedObject.st", "ObjectMemory.st",
    "Collection.st", "ArrayedCollection.st", "SequenceableCollection.st", "OrderedCollection.st",
    "Stack.st",
    "Character.st", "ByteArray.st", "String.st",
    "ContextPart.st", "BlockContext.st",
    "BlockClosure.st",
    "True.st", "False.st",
    "Signal.st", "SystemSignal.st",
    "Process.st", "ProcessorScheduler.st", "Semaphore.st",
    "CompiledMethod.st",
    "Association.st",
    "Stream.st", "PositionableStream.st", "WriteStream.st", "FileStream.st",
    "TextCollector.st",
    "Interval.st",
    "Set.st", "Bag.st",
    "Dictionary.st", "IdentityDictionary.st", "SystemDictionary.st",
    "DateTime.st",
    "Compiler.st",
    "MVC.st",
    "Console.st",
    "WinWorkspace.st",
    NULL
  };

  static syx_symbol foreign_filenames[] = {
    "CPointer.st", "CObject.st",
    "CStructFieldType.st", "CStructFieldSpec.st", "CStructGenerator.st", "CStruct.st",
    NULL
  };

  for (filename = kernel_filenames; *filename; filename++)
    {
      full_filename = syx_find_file ("st", "kernel", *filename);
      syx_cold_file_in (full_filename);
      syx_free (full_filename);
    }

  for (filename = foreign_filenames; *filename; filename++)
    {
      full_filename = syx_find_file ("st", "foreign", *filename);
      syx_cold_file_in (full_filename);
      syx_free (full_filename);
    }
}

static SyxOop
_syx_create_class (syx_varsize instanceSize)
{
  SyxOop object = syx_object_new_vars (syx_nil, SYX_VARS_CLASS_CLASS_ALL);
  SYX_CLASS_INSTANCE_SIZE(object) = syx_small_integer_new (instanceSize);
  return object;
}

/*!
  Builds a basic running image from scratch.

  This functions first reinitialize the memory with the size defined in SYX_INIT_MEMORY_SIZE.
  After, creates the 3 common constants syx_nil, syx_true and syx_false.
  Then creates all the classes needed by the VM, the Smalltalk dictionary and a dictionary containing all the symbols.
  Sets up the basic object hierarchy and insert each class into Smalltalk.
  Ends up this process by fileing in the basic declarations from initialDecl.st and the other *.st files, and calls syx_fetch_basic to fetch all classes in the VM.
  Finally, prepares the environment by running a blocking Process that calls Smalltalk>>initializeFirstSystem and initialize everything else from within Smalltalk itself.
*/  
void
syx_build_basic (void)
{
  SyxOop Object, Behavior, Class;
  SyxOop context;
  SyxOop process;
  static char *symbols[] = {"Transcript", "stdin", "stdout", NULL};
  char **sym;

  syx_memory_clear ();
  syx_memory_init (SYX_INIT_MEMORY_SIZE);

  /* allocate constants */
  syx_nil = syx_memory_alloc ();
  syx_true = syx_memory_alloc ();
  syx_false = syx_memory_alloc ();

  /* create raw instances of basic classes */
  Object = _syx_create_class (SYX_VARS_OBJECT_ALL);
  Behavior = _syx_create_class (SYX_VARS_CLASS_ALL);
  Class = _syx_create_class (SYX_VARS_CLASS_CLASS_ALL);
  syx_symbol_class = _syx_create_class (SYX_VARS_SYMBOL_ALL);
  syx_string_class = _syx_create_class (SYX_VARS_STRING_ALL);
  syx_small_integer_class = _syx_create_class (SYX_VARS_OBJECT_ALL);
  syx_character_class = _syx_create_class (SYX_VARS_OBJECT_ALL);
  syx_byte_array_class = _syx_create_class (SYX_VARS_OBJECT_ALL);
  syx_array_class = _syx_create_class (SYX_VARS_OBJECT_ALL);
  syx_variable_binding_class = _syx_create_class (SYX_VARS_VARIABLE_BINDING_ALL);
  syx_dictionary_class = _syx_create_class (SYX_VARS_DICTIONARY_ALL);
  syx_metaclass_class = _syx_create_class (SYX_VARS_METACLASS_ALL);

  syx_globals = syx_dictionary_new (200);
  /* hold SystemDictionary instance variables */
  syx_free (SYX_OBJECT_VARS(syx_globals));
  SYX_OBJECT_VARS(syx_globals) = (SyxOop *) syx_calloc (SYX_VARS_DICTIONARY_ALL + 5, sizeof (SyxOop));

  syx_symbols = syx_dictionary_new (1000);
  syx_globals_at_put (syx_symbol_new ("Smalltalk"), syx_globals);

#define _SETUP_CLASS(name, klass, superclass)				\
  syx_object_set_class (klass, syx_metaclass_new (syx_object_get_class (superclass))); \
  SYX_METACLASS_INSTANCE_CLASS(syx_object_get_class (klass)) = klass;	\
  SYX_CLASS_SUPERCLASS(klass) = superclass;				\
  SYX_CLASS_NAME(klass) = syx_symbol_new (name);			\
  SYX_CLASS_SUBCLASSES(klass) = syx_array_new (0, NULL);		\
  syx_globals_at_put (SYX_CLASS_NAME(klass), klass)

  SYX_CLASS_SUBCLASSES(Class) = syx_array_new (0, NULL);
  syx_object_set_class (Object, syx_metaclass_new (Class));
  SYX_METACLASS_INSTANCE_CLASS(syx_object_get_class (Object)) = Object;
  SYX_CLASS_SUPERCLASS(Object) = syx_nil;
  SYX_CLASS_NAME(Object) = syx_symbol_new ("Object");
  SYX_CLASS_SUBCLASSES(Object) = syx_array_new (0, NULL);
  syx_globals_at_put (SYX_CLASS_NAME(Object), Object);

  _SETUP_CLASS ("Behavior", Behavior, Object);
  _SETUP_CLASS ("Class", Class, Behavior);
  _SETUP_CLASS ("Metaclass", syx_metaclass_class, Behavior);
  _SETUP_CLASS ("Symbol", syx_symbol_class, Object);
  _SETUP_CLASS ("ByteArray", syx_byte_array_class, Object);
  _SETUP_CLASS ("String", syx_string_class, syx_byte_array_class);
  _SETUP_CLASS ("SmallInteger", syx_small_integer_class, Object);
  _SETUP_CLASS ("Character", syx_character_class, Object);
  _SETUP_CLASS ("Array", syx_array_class, Object);
  _SETUP_CLASS ("VariableBinding", syx_variable_binding_class, Object);
  _SETUP_CLASS ("Dictionary", syx_dictionary_class, Object);
  _syx_file_in_basic_decl ();

  syx_object_set_class (syx_globals, syx_globals_at ("SystemDictionary"));
  SYX_OBJECT(syx_nil)->klass = syx_globals_at ("UndefinedObject");
  SYX_OBJECT(syx_true)->klass = syx_globals_at ("True");
  SYX_OBJECT(syx_false)->klass = syx_globals_at ("False");

  syx_fetch_basic ();
  
  /* these will be filled later, now we'll create a binding for method declarations */
  for (sym=symbols; *sym; sym++)
    syx_globals_at_put (syx_symbol_new (*sym), syx_nil);
   
  _syx_file_in_basic ();

  process = syx_process_new ();
  context = syx_send_unary_message (process, syx_nil, syx_globals, "initializeFirstSystem");
  syx_process_execute_blocking (process);
}

/*
  Fetch all the things needed by the VM to run accordly to the image

  Sets up syx_nil, syx_true and syx_false constants.
  Lookup all classes from the Smalltalk dictionary and insert them into the VM.
  Then initialize the interpreter, the errors system and the scheduler.
  Finally send SystemDictionary>>#initializeSystem to initialize everything else from within Smalltalk
*/
void
syx_fetch_basic (void)
{
  syx_nil = (SyxOop)(syx_memory);
  syx_true = (SyxOop)(syx_memory + 1);
  syx_false = (SyxOop)(syx_memory + 2);

  syx_metaclass_class = syx_globals_at ("Metaclass");
  syx_undefined_object_class = syx_globals_at ("UndefinedObject");
  syx_symbol_class = syx_globals_at ("Symbol");
  syx_string_class = syx_globals_at ("String");
  syx_small_integer_class = syx_globals_at ("SmallInteger");
  syx_large_integer_class = syx_globals_at ("LargeInteger");
  syx_float_class = syx_globals_at ("Float");
  syx_character_class = syx_globals_at ("Character");
  syx_byte_array_class = syx_globals_at ("ByteArray");
  syx_array_class = syx_globals_at ("Array");
  syx_variable_binding_class = syx_globals_at ("VariableBinding");
  syx_dictionary_class = syx_globals_at ("Dictionary");
  syx_cpointer_class = syx_globals_at ("CPointer");

  syx_compiled_method_class = syx_globals_at ("CompiledMethod");
  syx_compiled_block_class = syx_globals_at ("CompiledBlock");
  syx_block_closure_class = syx_globals_at ("BlockClosure");
  syx_method_context_class = syx_globals_at ("MethodContext");
  syx_block_context_class = syx_globals_at ("BlockContext");
  syx_process_class = syx_globals_at ("Process");
  syx_processor_scheduler_class = syx_globals_at ("ProcessorScheduler");

  syx_globals_at_put (syx_symbol_new ("ImageFileName"), syx_string_new (_syx_image_path));
  syx_interp_init ();
  syx_error_init ();
  syx_scheduler_init ();
  syx_plugins_init ();
  syx_signal_init ();
}

/*! Remove Smalltalk startupProcess from being scheduled and
  send #startupSystem: to Smalltalk in a scheduled process */
void
syx_initialize_system (void)
{
  SyxOop context;
  SyxOop process;
  SyxOop arguments = syx_array_new_size (_syx_argc);
  syx_varsize i;

  for (i=0; i < _syx_argc; i++)
    SYX_OBJECT_DATA(arguments)[i] = syx_string_new (_syx_argv[i]);

  process = SYX_OBJECT_VARS(syx_globals)[3];
  if (!SYX_IS_NIL (process))
    syx_scheduler_remove_process (process);

  process = syx_process_new ();
  context = syx_send_binary_message (process, syx_nil, syx_globals, "startupSystem:", arguments);
  SYX_PROCESS_SUSPENDED (process) = syx_false;
  
  syx_system_initialized = TRUE;
}

/*!
  Setup the basic external environment of Syx, such as the root and the image path.

  \param root_path an arbitrary root directory for Syx or NULL
*/
syx_bool
syx_init (syx_varsize argc, syx_string *argv, syx_symbol root_path)
{
  static syx_bool initialized = FALSE;   
  if (initialized || !syx_set_root_path (root_path))
    return FALSE;

  _syx_argc = argc;
  _syx_argv = argv;

#ifdef WINCE
  _syx_image_path = "\\default.sim";
  goto end;
#endif

  /* first look in the root directory */
  if (root_path && !strcmp (root_path, _syx_root_path))
    {
      _syx_image_path = (syx_string) syx_malloc (strlen (_syx_root_path) + 13);
      sprintf ((syx_string) _syx_image_path, "%s%c%s", _syx_root_path, SYX_PATH_SEPARATOR, "default.sim");
      initialized = TRUE;
      return TRUE;
    }

  /* first look in the working directory */
#ifdef HAVE_ACCESS
  if (access ("default.sim", R_OK) == 0)
#else
  if (fopen ("default.sim", "r"))
#endif
    {
      _syx_image_path = "default.sim";
      goto end;
    }

  /* then look in the environment */
#ifdef HAVE_GETENV
  _syx_image_path = getenv ("SYX_IMAGE_PATH");
  if (_syx_image_path)
    goto end;
#endif
  
  /* return the default path defined by the installation */
  _syx_image_path = SYX_IMAGE_PATH;

 end:
   
  _syx_image_path = syx_strdup (_syx_image_path);
  initialized = TRUE;
  return TRUE;
}

/*!
  Finalize Syx.

  Run special tasks to finalize the Syx process, such as clearing all the allocated memory
*/
void
syx_quit (void)
{
  syx_memory_clear ();
  syx_interp_quit ();
  syx_plugin_finalize_all ();
  syx_scheduler_quit ();
  syx_error_clear ();

  syx_free (_syx_image_path);
  syx_free (_syx_root_path);

  syx_profile_print ();
}

/*!
  Returns the root directory of Syx.

  \return a constant string containing the path of the root directory
*/
syx_symbol 
syx_get_root_path (void)
{
  return _syx_root_path;
}

/*!
  Sets the root directory of Syx.

  \param root_path the new path
  \return TRUE if the path exists and is readable
*/
syx_bool
syx_set_root_path (syx_symbol root_path)
{
  if (!root_path)
     root_path = SYX_ROOT_PATH;

  if (_syx_root_path)
     syx_free (_syx_root_path);

  _syx_root_path = syx_strdup (root_path);

#ifdef HAVE_ACCESS
  if (access (_syx_root_path, R_OK) < 0)
     return FALSE;
#endif

  return TRUE;
}

/*! Sets the initial image path */
syx_bool
syx_set_image_path (syx_symbol image_path)
{
  if (!image_path)
     return FALSE;
   
  if (_syx_image_path)
    syx_free (_syx_image_path);

  _syx_image_path = syx_strdup (image_path);
  return TRUE;
}

/*!
  Returns the initial image path.

 This path won't be used once Syx is initialized. The image path will be obtained from the ImageFileName global
*/
syx_symbol
syx_get_image_path (void)
{
  return _syx_image_path;
}
