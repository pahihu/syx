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

#include "syx-memory.h"
#include "syx-object.h"
#include "syx-interp.h"
#include "syx-error.h"
#include "syx-enums.h"
#include "syx-utils.h"
#include "syx-types.h"
#include "syx-scheduler.h"
#include "syx-profile.h"

#include <stdio.h>

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif

/*! \page syx_object Syx Object
  
  \section Description
  syx-object.c: this file contains all the functions needed to work with Smalltalk objects.
  
  Objects are the core of Syx. They can represent both instances or classes.
  \note all objects are allocated in the Syx Memory
*/

SyxOop syx_nil,
  syx_true,
  syx_false,

  syx_metaclass_class,
  syx_undefined_object_class,
  syx_true_class,
  syx_false_class,
  syx_small_integer_class,
  syx_character_class,
  syx_cpointer_class,

  syx_large_integer_class = 0,
  syx_float_class,
  syx_symbol_class,
  syx_string_class,
  syx_byte_array_class,
  syx_array_class,

  syx_variable_binding_class,
  syx_dictionary_class,

  syx_compiled_method_class,
  syx_compiled_block_class,
  syx_block_closure_class,

  syx_method_context_class,
  syx_block_context_class,
  syx_process_class,
  syx_processor_scheduler_class,

  syx_symbols,
  syx_globals;

static syx_uint8 _syx_sem_lock = 0;

/*!
  Initialize a class from the Smalltalk-side

  Create a new process, a new context and send the #initialize message to the class.
  The process is executed in blocking mode.

  \param class the class to be initialized
*/
void
syx_object_initialize (SyxOop oop)
{
  SyxOop process;
  SyxOop context;

  /* initialize only if the interpreter is running */
  if (syx_system_initialized)
    {
      process = syx_process_new ();
      context = syx_send_unary_message (oop, "initialize");
      syx_interp_enter_context (process, context);
      syx_process_execute_blocking (process);
    }
}

/*!
  Resize SyxObject::data to the given size, being careful of object indexables and byte indexables.

  Warning, if the new size is lesser than the current, the data at the end of the array will be lost
*/
void
syx_object_resize (SyxOop object, syx_varsize size)
{
  if (SYX_OBJECT_HAS_REFS (object))
    SYX_OBJECT_DATA(object) = (SyxOop *) syx_realloc (SYX_OBJECT_DATA(object),
                                                      size * sizeof (SyxOop));
  else
    SYX_OBJECT_DATA(object) = (SyxOop *) syx_realloc (SYX_OBJECT_DATA(object),
                                                      size * sizeof (syx_int8));

  SYX_OBJECT_DATA_SIZE(object) = size;
}


/* Contructors */

/*!
  Creates a new metaclass.

  The metaclass will be an instance of the Metaclass class. Instance size is inherited by superclass

  \param supermetaclass the superclass of the new metaclass
*/
SyxOop 
syx_metaclass_new (SyxOop supermetaclass)
{
  SyxOop metaclass = syx_object_new (syx_metaclass_class);
  SYX_CLASS_SUPERCLASS(metaclass) = supermetaclass;
  SYX_CLASS_INSTANCE_SIZE(metaclass) = SYX_CLASS_INSTANCE_SIZE(supermetaclass);
  SYX_CLASS_INSTANCE_VARIABLES(metaclass) = syx_array_new (0, NULL);
  SYX_CLASS_METHODS(metaclass) = syx_dictionary_new (50);

  SYX_CLASS_SUBCLASSES(metaclass) = syx_array_new (0, NULL);
  syx_array_add (SYX_CLASS_SUBCLASSES(supermetaclass), metaclass, TRUE);
  return metaclass;
}

/*!
  Creates a new class.

  This function automatically creates the metaclass for the new class with syx_metaclass_new.
  The new class is an instance of the metaclass.

  \param superclass the superclass of the new class
*/
SyxOop 
syx_class_new (SyxOop superclass)
{
  SyxOop metaclass = syx_metaclass_new (syx_object_get_class (superclass));
  SyxOop klass = syx_object_new (metaclass);
  SYX_CLASS_SUPERCLASS(klass) = superclass;
  SYX_CLASS_INSTANCE_SIZE(klass) = SYX_CLASS_INSTANCE_SIZE(superclass);
  SYX_CLASS_INSTANCE_VARIABLES(klass) = syx_array_new (0, NULL);
  SYX_METACLASS_INSTANCE_CLASS(metaclass) = klass;
  SYX_CLASS_METHODS(klass) = syx_dictionary_new (50);

  SYX_CLASS_SUBCLASSES(klass) = syx_array_new (0, NULL);
  syx_array_add (SYX_CLASS_SUBCLASSES(superclass), klass, TRUE);
  return klass;
}

/*!
  Create a new LargeInteger.

  \b This function is available only if Syx has been linked with the GMP library

  \param string a textual representation of the number
  \param base the radix of the representation
*/
SyxOop
syx_large_integer_new (syx_symbol string, syx_int32 base)
{
#ifdef HAVE_LIBGMP
  mpz_t *z = syx_calloc (1, sizeof (mpz_t));
  SyxOop oop;
  mpz_init_set_str (*z, string, 10);
  oop = syx_object_new_data (syx_large_integer_class, FALSE, sizeof (mpz_t), (SyxOop *)z);
  return oop;
#endif
  return syx_nil;
}

/*! Create a new LargeInteger with the given mpz */
SyxOop
syx_large_integer_new_mpz (syx_pointer mpz)
{
#ifdef HAVE_LIBGMP
  SyxOop oop;
  oop = syx_object_new_data (syx_large_integer_class, FALSE, sizeof (mpz_t), (SyxOop *)mpz);
  return oop;
#endif
  return syx_nil;
}

/*!
  Transform a 32-bit integer to a multiple precision integer.

  \b This function is available only if Syx has been linked with the GMP library
*/
SyxOop
syx_large_integer_new_integer (syx_int32 i)
{
#ifdef HAVE_LIBGMP
  mpz_t *z = syx_calloc (1, sizeof (mpz_t));
  SyxOop oop;
  mpz_init_set_si (*z, i);
  oop = syx_object_new_data (syx_large_integer_class, FALSE, sizeof (mpz_t), (SyxOop *)z);
  return oop;
#endif
  return syx_nil;
}


/*!
  Create a new suspended Process and schedule it.

  \param context a MethodContext or BlockContext
*/
SyxOop 
syx_process_new (void)
{
  SyxInterpFrame *frame;
  SyxOop object = syx_object_new (syx_process_class);
  SYX_PROCESS_STACK(object) = syx_array_new_size (5000);
  SYX_PROCESS_SUSPENDED(object) = syx_true;
  SYX_PROCESS_SCHEDULED(object) = syx_false;

  /* initialize the first frame to avoid null checks in the interpreter */
  frame = (SyxInterpFrame *) SYX_POINTER_CAST_OOP (SYX_OBJECT_DATA (SYX_PROCESS_STACK (object)));
  /* the stack pointer is used to get the next available frame, which in our case is the bottom
     of the process stack */
  frame->stack = (SyxOop *) frame;
  SYX_PROCESS_FRAME_POINTER(object) = SYX_POINTER_CAST_OOP (frame);

  syx_scheduler_add_process (object);
  return object;
}


/*!
  Remove an element from an Array.

  \return TRUE if element was found and removed, else FALSE
*/
syx_bool
syx_array_remove (SyxOop array, SyxOop element)
{
  syx_varsize i, size;
  syx_bool found = FALSE;

  size = SYX_OBJECT_DATA_SIZE (array);
  for (i=0; i < size; i++)
    {
      if (found)
        SYX_OBJECT_DATA(array)[i-1] = SYX_OBJECT_DATA(array)[i];

      if (SYX_OOP_EQ (SYX_OBJECT_DATA (array)[i], element))
        found = TRUE;
    }

  if (found)
    syx_object_resize (array, size - 1);

  return found;
}



/*!
  Add an element to an Array.

  \param unique TRUE if the element shouldn't be added if already present in the array
*/
void
syx_array_add (SyxOop array, SyxOop element, syx_bool unique)
{
  syx_varsize i, size;

  size = SYX_OBJECT_DATA_SIZE (array);

  if (unique)
    {
      for (i=0; i < size; i++)
        {
          if (SYX_OOP_EQ (SYX_OBJECT_DATA(array)[i], element))
            return;
        }
    }

  syx_object_grow_by (array, 1);
  SYX_OBJECT_DATA(array)[size] = element;
}

/*!
  Returns a Symbol instance.

  Lookups into syx_symbols dictionary to check the existance of the symbol, otherwise create a new one and insert it into the dictionary.
  \param symbol a plain constant string
*/
SyxOop 
syx_symbol_new (syx_symbol symbol)
{
  SyxOop obj;
  syx_int32 index;
  SyxOop *table;
  syx_int32 tally;
  syx_varsize size;
  syx_int32 hash;

  if (!symbol)
    return syx_nil;

  /* We don't use common dictionary functions to avoid searching the index twice.
     See issue #21 */

  tally = SYX_SMALL_INTEGER (SYX_DICTIONARY_TALLY (syx_symbols));
  size = SYX_OBJECT_DATA_SIZE (syx_symbols);

  if (tally >= size / 2)
    syx_dictionary_rehash (syx_symbols);

  hash = syx_string_hash (symbol);
  index = syx_dictionary_index_of (syx_symbols, symbol, hash, TRUE);

  if (index < 0)
    syx_error ("Not enough space for dictionary %p\n", SYX_OOP_CAST_POINTER (syx_symbols));

  table = SYX_OBJECT_DATA (syx_symbols);
  if (!SYX_IS_NIL (table[index]))
    return table[index+1];

  obj = syx_object_new_data (syx_symbol_class, FALSE, strlen (symbol) + 1, (SyxOop *)syx_strdup (symbol));
  SYX_SYMBOL_HASH(obj) = syx_small_integer_new (hash);
  table[index] = obj;
  table[index+1] = obj;
  SYX_DICTIONARY_TALLY (syx_symbols) = syx_small_integer_new (tally + 1);

  return obj;
}


/*! Returns the hash of a String */
syx_int32
syx_string_hash (syx_symbol string)
{
  syx_int32 ret;
  for (ret=0, string = string + 1; *string != '\0'; string++)
    ret += *string + *(string - 1);

  if (!SYX_SMALL_INTEGER_CAN_EMBED (ret))
    ret >>= 2;

  return SYX_SMALL_INTEGER_EMBED (ret);
}

/*!
  Returns the index of the given symbol, the index of an empty entry or -1 if the key was not found.

  Take care the dictionary MUST contain only key symbols

  \param hash the hash code of the key symbol
  \param return_nil_index if TRUE returns the index of the first nil entry
*/
syx_int32
syx_dictionary_index_of (SyxOop dict, syx_symbol key, syx_int32 hash, syx_bool return_nil_index)
{
  SyxOop entry;
  syx_varsize size = SYX_OBJECT_DATA_SIZE (dict);
  SyxOop *table = SYX_OBJECT_DATA (dict);
  syx_varsize i = 2 * (hash % (size / 2));
  syx_int32 tally = SYX_SMALL_INTEGER (SYX_DICTIONARY_TALLY (dict)) + return_nil_index;
  SYX_START_PROFILE;


  for (; tally; i+=2)
    {
      if (i >= size)
        i = 0;
      entry = table[i];
      if (SYX_IS_NIL (entry))
        {
          if (return_nil_index)
            {
              SYX_END_PROFILE(dict_access);
              return i;
            }
          else
            {
              SYX_END_PROFILE(dict_access);
              return -1;
            }
        }
      tally--;
      if (!strcmp (SYX_OBJECT_SYMBOL (entry), key))
        {
          SYX_END_PROFILE(dict_access);
          return i;
        }
    }
  SYX_END_PROFILE(dict_access);
  return -1;
}

/*!
  Create an association key -> index to be used as binding. Raise an error if not found.

  Take care the dictionary MUST contain only key symbols

  \return An Association
*/
SyxOop
syx_dictionary_binding_at_symbol (SyxOop dict, syx_symbol key)
{
  syx_int32 index = syx_dictionary_index_of (dict, key, syx_string_hash (key), FALSE);
  SyxOop *table;
  if (index < 0)
    {
      syx_signal (SYX_ERROR_NOT_FOUND, syx_symbol_new (key));
      return syx_nil;
    }

  table = SYX_OBJECT_DATA (dict);
  return syx_variable_binding_new (table[index], index, dict);
}

/*!
  Create an association key -> index to be used as binding. Return the given object if not found.

  Take care the dictionary MUST contain only symbol keys

  \return An Association
*/
SyxOop
syx_dictionary_binding_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object)
{
  syx_int32 index = syx_dictionary_index_of (dict, key, syx_string_hash (key), FALSE);
  SyxOop *table;
  if (index < 0)
    return object;

  table = SYX_OBJECT_DATA (dict);
  return syx_variable_binding_new (table[index], index, dict);
}

/*!
  Binds a VariableBinding returned by syx_dictionary_binding_at_symbol. Raise an exception if not bound.

  The function get the dictionary entry at the index (the value of the given association) then compare the two keys. If they're equal, then return the value of the dictionary entry; if not, lookup the key and change the the index of the binding.

  \return The bound Object
*/
SyxOop
syx_dictionary_bind (SyxOop binding)
{
  SyxOop dict = SYX_VARIABLE_BINDING_DICTIONARY (binding);
  SyxOop *table;
  SyxOop key;
  syx_int32 index;
  SyxOop entry;

  if (SYX_IS_NIL (dict))
    return syx_nil;

  table = SYX_OBJECT_DATA (dict);
  key = SYX_ASSOCIATION_KEY (binding);
  index = SYX_SMALL_INTEGER (SYX_ASSOCIATION_VALUE (binding));
  entry = table[index];

  if (SYX_OOP_EQ (entry, key))
    return table[index+1];

  index = syx_dictionary_index_of (dict, SYX_OBJECT_SYMBOL (key), syx_symbol_hash (key), FALSE);
  if (index < 0)
    {
      syx_signal (SYX_ERROR_NOT_FOUND, key);
      return syx_nil;
    }

  SYX_ASSOCIATION_VALUE (binding) = syx_small_integer_new (index);
  return table[index+1];
}

/*!
  Binds a VariableBinding returned by syx_dictionary_binding_at_symbol. Return the given object if not found.

  The function get the dictionary entry at the index (the value of the given association) then compare the two keys. If they're equal, then return the value of the dictionary entry; if not, lookup the key and change the the index of the binding.

  \return The bound Object
*/
SyxOop
syx_dictionary_bind_if_absent (SyxOop binding, SyxOop object)
{
  SyxOop dict = SYX_VARIABLE_BINDING_DICTIONARY (binding);
  SyxOop *table;
  SyxOop key;
  syx_int32 index;
  SyxOop entry;
  if (SYX_IS_NIL (dict))
    return object;

  table = SYX_OBJECT_DATA (dict);
  key = SYX_ASSOCIATION_KEY (binding);
  index = SYX_SMALL_INTEGER (SYX_ASSOCIATION_VALUE (binding));
  if (index < SYX_OBJECT_DATA_SIZE(dict))
    {
      entry = table[index];
      if (SYX_OOP_EQ (entry, key))
        return table[index+1];
    }

  index = syx_dictionary_index_of (dict, SYX_OBJECT_SYMBOL (key), syx_symbol_hash (key), FALSE);
  if (index < 0)
    return object;

  SYX_ASSOCIATION_VALUE (binding) = syx_small_integer_new (index);
  return table[index+1];
}

/*!
  Set the object value of the binding returned by syx_dictionary_binding_at_symbol.
  Raise an exception if not found.

  The function does the same thing ot syx_dictionary_bind, except that it sets the value in the Dictionary entry
*/
void
syx_dictionary_bind_set_value (SyxOop binding, SyxOop value)
{
  SyxOop dict = SYX_VARIABLE_BINDING_DICTIONARY (binding);
  SyxOop *table;
  SyxOop key;
  syx_int32 index;
  SyxOop entry;

  if (SYX_IS_NIL (dict))
    return;
  
  table = SYX_OBJECT_DATA (dict);
  key = SYX_ASSOCIATION_KEY (binding);
  index = SYX_SMALL_INTEGER (SYX_ASSOCIATION_VALUE (binding));
  entry = table[index];

  if (SYX_OOP_NE (entry, key))
    {
      index = syx_dictionary_index_of (dict, SYX_OBJECT_SYMBOL (key), syx_symbol_hash (key), FALSE);
      if (index < 0)
        {
          syx_signal (SYX_ERROR_NOT_FOUND, key);
          return;
        }
    }

  SYX_ASSOCIATION_VALUE (binding) = syx_small_integer_new (index);
  table[index+1] = value;
}

/*!
  Lookup a key by symbol in the dictionary. Raise an error if not found.

  Take care the dictionary MUST contain only symbol keys
*/
SyxOop 
syx_dictionary_at_symbol (SyxOop dict, syx_symbol key)
{
  syx_int32 index = syx_dictionary_index_of (dict, key, syx_string_hash (key), FALSE);
  if (index < 0)
    {
      syx_signal (SYX_ERROR_NOT_FOUND, syx_symbol_new (key));
      return 0;
    }

  return SYX_OBJECT_DATA(dict)[index+1];
}

/*!
  Lookup a key by symbol in the dictionary. Return the given object if not found.

  Take care the dictionary MUST contain only key symbols
*/
SyxOop 
syx_dictionary_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object)
{
  syx_int32 index = syx_dictionary_index_of (dict, key, syx_string_hash (key), FALSE);
  if (index < 0)
    return object;

  return SYX_OBJECT_DATA(dict)[index+1];
}

/*! Grow the dictionary and rehash all data */
void
syx_dictionary_rehash (SyxOop dict)
{
  syx_varsize size = SYX_OBJECT_DATA_SIZE (dict);
  syx_int32 tally = SYX_SMALL_INTEGER (SYX_DICTIONARY_TALLY (dict));
  syx_varsize newsize = size * 2;
  SyxOop *table = SYX_OBJECT_DATA (dict);
  SyxOop newdict = syx_dictionary_new (newsize);
  SyxOop entry;
  syx_int32 i;

  for (i=0; tally && i < size; i+=2)
    {
      entry = table[i];
      if (!SYX_IS_NIL (entry))
        {
          syx_dictionary_at_symbol_put (newdict, entry, table[i+1]);
          tally--;
        }
    }

  syx_free (SYX_OBJECT_DATA (dict));
  SYX_OBJECT_DATA (dict) = SYX_OBJECT_DATA (newdict);
  SYX_OBJECT_DATA_SIZE (dict) = SYX_OBJECT_DATA_SIZE (newdict);
  syx_free (SYX_OBJECT_VARS (newdict));
  syx_memory_free (newdict);
}


/*! Insert key -> value in the dictionary */
void
syx_dictionary_at_symbol_put (SyxOop dict, SyxOop key, SyxOop value)
{
  syx_varsize size = SYX_OBJECT_DATA_SIZE (dict);
  syx_int32 tally = SYX_SMALL_INTEGER (SYX_DICTIONARY_TALLY (dict));
  SyxOop *table;
  syx_int32 index;

  if (tally >= size / 2)
    syx_dictionary_rehash (dict);

  index = syx_dictionary_index_of (dict, SYX_OBJECT_SYMBOL (key), syx_symbol_hash (key), TRUE);

  if (index < 0)
    syx_error ("Not enough space for dictionary %p\n", SYX_OOP_CAST_POINTER (dict));

  table = SYX_OBJECT_DATA (dict);
  table[index] = key;
  table[index+1] = value;
  SYX_DICTIONARY_TALLY (dict) = syx_small_integer_new (tally + 1);
}


/*!
  Create a new MethodContext.

  \param method a CompiledMethod
  \param receiver an Object receiving the message
  \param arguments the arguments passed to the message
*/
SyxOop 
syx_method_context_new (SyxOop method, SyxOop receiver, SyxOop arguments)
{
  SyxOop object;

  SYX_START_PROFILE;

  syx_memory_gc_begin ();

  object = syx_object_new (syx_method_context_class);

  SYX_CONTEXT_PART_FRAME_POINTER(object) = SYX_POINTER_CAST_OOP (NULL);
  SYX_CONTEXT_PART_METHOD(object) = method;
  SYX_CONTEXT_PART_ARGUMENTS(object) = arguments;
  SYX_METHOD_CONTEXT_RECEIVER(object) = receiver;

  syx_memory_gc_end ();

  SYX_END_PROFILE(method_context);

  return object;
}

/*!
  Same as syx_method_context_new but for BlockContexts.
  The receiver is guessed by looking at the outer context.

  \param closure a BlockClosure
*/
SyxOop 
syx_block_context_new (SyxOop closure, SyxOop arguments)
{
  SyxOop object;

  SYX_START_PROFILE;

  object = syx_object_new (syx_block_context_class);

  SYX_CONTEXT_PART_FRAME_POINTER(object) = SYX_POINTER_CAST_OOP (NULL);
  SYX_CONTEXT_PART_METHOD(object) = SYX_BLOCK_CLOSURE_BLOCK (closure);
  SYX_CONTEXT_PART_ARGUMENTS(object) = arguments;
  SYX_BLOCK_CONTEXT_CLOSURE(object) = closure;

  SYX_END_PROFILE(block_context);

  return object;
}

/* Object */

/*!
  Create a new object specifying an arbitrary number of instance variables.

  \param class the class of the new instance
  \param vars_size number of instance variables the instance must hold
*/
SyxOop
syx_object_new_vars (SyxOop klass, syx_varsize vars_size)
{
  SyxOop oop = syx_memory_alloc ();
  SyxObject *object = SYX_OBJECT (oop);

  object->klass = klass;
  object->has_refs = FALSE;
  object->is_constant = FALSE;
  object->vars = (SyxOop *) syx_calloc (vars_size, sizeof (SyxOop));
  object->data_size = 0;
  object->data = NULL;

  return oop;
}

/*!
  Create a new object of the given size.

  \param has_refs specify if the created object must be Object indexable or Byte indexable
  \param size number of objects/bytes to hold
*/
SyxOop 
syx_object_new_size (SyxOop klass, syx_bool has_refs, syx_varsize size)
{
  SyxObject *object = SYX_OBJECT (syx_object_new (klass));

  object->has_refs = has_refs;
  object->data_size = size;
  object->data = (SyxOop *) (has_refs
                             ? syx_calloc (size, sizeof (SyxOop))
                             : syx_calloc (size, sizeof (syx_int8)));
  return (SyxOop)object;
}

/*!
  Create a new object of the given size with the given data.

  \param has_refs specify if the created object must be Object indexable or Byte indexable
  \param size number of objects/bytes to hold
  \param data the data of the object (must be an array of SyxOop or syx_int8)
*/
SyxOop 
syx_object_new_data (SyxOop klass, syx_bool has_refs, syx_varsize size, SyxOop *data)
{
  SyxObject *object = SYX_OBJECT (syx_object_new (klass));

  object->has_refs = has_refs;
  object->data_size = size;
  object->data = data;

  return (SyxOop)object;
}

/*! Make a shallow copy of an object */
SyxOop
syx_object_copy (SyxOop object)
{
  SyxOop oop;
  SyxObject *obj1;
  SyxObject *obj2;

  if (!SYX_IS_OBJECT (object))
    return object;

  oop = syx_memory_alloc ();
  obj1 = SYX_OBJECT (oop);
  obj2 = SYX_OBJECT (object);

  obj1->klass = obj2->klass;
  obj1->has_refs = obj2->has_refs;
  obj1->is_constant = FALSE;

  obj1->vars = (SyxOop *) syx_memdup (obj2->vars, SYX_SMALL_INTEGER(SYX_CLASS_INSTANCE_SIZE (obj1->klass)),
                                      sizeof (SyxOop));

  obj1->data_size = obj2->data_size;
  if (obj2->data)
    {
      if (obj1->has_refs)
        obj1->data = (SyxOop *) syx_memdup (obj2->data, obj1->data_size, sizeof (SyxOop));
      else
        obj1->data = (SyxOop *) syx_memdup (obj2->data, obj1->data_size, sizeof (syx_int8));
    }

  return oop;
}

/*!
  Frees all the memory used by the object.

  If the class has finalizationRequest set to true, perform #finalize on the object
*/
void
syx_object_free (SyxOop object)
{
  SyxOop process, context, klass;
  if (!SYX_IS_OBJECT (object))
    return;

  klass = syx_object_get_class (object);
  if (SYX_IS_NIL (klass))
    return;

  if (SYX_IS_TRUE (SYX_CLASS_FINALIZATION (klass)))
    {
      process = syx_process_new ();
      context = syx_send_unary_message (object, "finalize");
      syx_interp_enter_context (process, context);
      syx_process_execute_blocking (process);
    }

  if (SYX_OBJECT_VARS (object))
    syx_free (SYX_OBJECT_VARS (object));
  if (SYX_OBJECT_DATA (object))
    syx_free (SYX_OBJECT_DATA (object));
  syx_memory_free (object);
}

/*!
  Check if a class is a superclass of another one.

  \param class a class
  \param subclass a class that should be a subclass of the former
  \return TRUE if the first is a superclass of the second
*/
syx_bool
syx_class_is_superclass_of (SyxOop klass, SyxOop subclass)
{
  SyxOop cur;
  if (SYX_OOP_EQ (klass, subclass))
    return FALSE;

  cur = SYX_CLASS_SUPERCLASS (subclass);

  for (; !SYX_IS_NIL (cur) && SYX_OOP_NE(cur, klass); cur=SYX_CLASS_SUPERCLASS(cur));

  return !SYX_IS_NIL (cur);
}

/*!
  Get a list of all instance variable names defined in a class.

  The returned list is ordered to be used by the interpreter to access the variables directly using the list index.

  \return A syx_symbol list or NULL. The list must be freed once unused
*/
syx_symbol *
syx_class_get_all_instance_variable_names (SyxOop klass)
{
  syx_symbol names[256];
  syx_symbol *ret_names = NULL;
  SyxOop inst_vars;
  SyxOop inst_var;
  syx_varsize i, size, tot_size;

  for (tot_size=0; !SYX_IS_NIL(klass); klass=SYX_CLASS_SUPERCLASS (klass))
    {
      inst_vars = SYX_CLASS_INSTANCE_VARIABLES (klass);
      size = SYX_OBJECT_DATA_SIZE (inst_vars);

      for (i=size; i > 0; i--)
        {
          inst_var = SYX_OBJECT_DATA(inst_vars)[i-1];
          if (!SYX_IS_NIL (inst_var))
            {
              tot_size++;
              names[255-tot_size+1] = SYX_OBJECT_SYMBOL (inst_var);
            }
        }
    }
  if (tot_size > 0)
    {
      ret_names = (syx_symbol *) syx_calloc (tot_size + 1, sizeof (syx_symbol));
      memcpy (ret_names, &names[255-tot_size+1], tot_size * sizeof (syx_symbol));
    }
  return ret_names;
}

/*!
  Returns a method in a class having the given selector.

  \return syx_nil if no method has been found
*/
SyxOop 
syx_class_lookup_method (SyxOop klass, syx_symbol selector)
{
  SyxOop cur;
  SyxOop method;

  for (cur=klass; !SYX_IS_NIL (cur); cur = SYX_CLASS_SUPERCLASS (cur))
    {
      if (SYX_IS_NIL (SYX_CLASS_METHODS (cur)))
        continue;

      method = syx_dictionary_at_symbol_if_absent (SYX_CLASS_METHODS (cur), selector, syx_nil);
      if (!SYX_IS_NIL (method))
        return method;
    }

  return syx_nil;
}

/*!
  A mix between syx_class_lookup_method and syx_dictionary_bind_if_absent.

  \return syx_nil if no method has been found
*/
SyxOop 
syx_class_lookup_method_binding (SyxOop klass, SyxOop binding)
{
  SyxOop cur;
  SyxOop method;
  
  for (cur=klass; !SYX_IS_NIL (cur); cur = SYX_CLASS_SUPERCLASS (cur))
    {
      if (SYX_IS_NIL (SYX_CLASS_METHODS (cur)))
        continue;
      
      SYX_VARIABLE_BINDING_DICTIONARY (binding) = SYX_CLASS_METHODS (cur);
      method = syx_dictionary_bind_if_absent (binding, syx_nil);
      if (!SYX_IS_NIL (method))
        return method;
    }
  
  return syx_nil;
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
  syx_int32 i;

  /* FIXME: See http://www-128.ibm.com/developerworks/eserver/library/es-win32linux-sem.html */

  /* wait */
  while (_syx_sem_lock != 0);
  /* acquire */
  _syx_sem_lock++;

  list = SYX_SEMAPHORE_LIST(semaphore);
  /* add 1 because we signaled it right now */
  signals = SYX_SMALL_INTEGER (SYX_SEMAPHORE_SIGNALS(semaphore)) + 1;

  /* the i variable is used to keep track of how many processed we woke up */
  for (i=0; signals > 0 && SYX_OBJECT_DATA_SIZE (list) > 0; signals--, i++)
    SYX_PROCESS_SUSPENDED (SYX_OBJECT_DATA(list)[i]) = syx_false;

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


/* Small integer overflow checks */

/*! TRUE if an overflow occurs when doing b times a */
syx_bool
SYX_SMALL_INTEGER_MUL_OVERFLOW (syx_int32 a, syx_int32 b)
{
#ifdef HAVE_INT64_T
  syx_int64 res = (syx_int64)a * (syx_int64)b;
  if ((res > INT_MAX) || (res < INT_MIN))
    return TRUE;
#else
  if (a > 0) 
    {
      if (b > 0)
        {
          if (a > (INT_MAX / b))
            return TRUE;
        } 
      else
        {
          if (b < (INT_MIN / a))
            return TRUE;
        } 
    } 
  else
    { 
      if (b > 0)
        { 
          if (a < (INT_MIN / b))
            return TRUE;
        } 
      else
        { 
          if ( (a != 0) && (b < (INT_MAX / a)))
            return TRUE;
        } 
    }
#endif

  return FALSE;
}

/*! TRUE if an overflow occurs when shifting a by b */
syx_bool
SYX_SMALL_INTEGER_SHIFT_OVERFLOW (syx_int32 a, syx_int32 b)
{
  /* Thanks to Sam Philips */
  syx_int32 i;
  syx_int32 sval;

  if (b <= 0)
    return FALSE;

  i = 0;
  sval = abs(a);

  while (sval >= 16)
    {
      sval = sval >> 4;
      i += 4;
    }
  
  while (sval != 0)
    {
      sval = sval >> 1;
      i++;
    }
  
  if ((i + b) > 30)
    return TRUE;

  return FALSE;
}
