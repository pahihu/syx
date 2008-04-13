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

#ifndef SYX_OBJECT_H
#define SYX_OBJECT_H

#include "syx-utils.h"
#include "syx-platform.h"
#include "syx-enums.h"
#include "syx-error.h"

#include <stdlib.h>
#include <string.h>

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif


SYX_BEGIN_DECLS

#define SYX_OBJECT(oop) ((SyxObject *) (oop))
#define SYX_OBJECT_FLOAT(oop) (*((syx_double *)(SYX_OBJECT(oop)->data)))

#ifdef HAVE_LIBGMP
#define SYX_OBJECT_LARGE_INTEGER(oop) (*(mpz_t *)(SYX_OBJECT(oop)->data))
#endif

#define SYX_OBJECT_SYMBOL(oop) ((syx_symbol)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_STRING(oop) ((syx_string)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_BYTE_ARRAY(oop) ((syx_uint8 *)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_VARS(oop) (SYX_OBJECT(oop)->vars)
#define SYX_OBJECT_DATA_SIZE(oop) (SYX_OBJECT(oop)->data_size)
#define SYX_OBJECT_DATA(oop) (SYX_OBJECT(oop)->data)
#define SYX_OBJECT_HAS_REFS(oop) (SYX_OBJECT(oop)->has_refs)
#define SYX_OBJECT_IS_MARKED(oop) (SYX_OBJECT(oop)->is_marked)
#define SYX_OBJECT_IS_CONSTANT(oop) (SYX_OBJECT(oop)->is_constant)

#define SYX_IS_NIL(oop) ((oop) == 0 || (oop) == syx_nil)
#define SYX_IS_TRUE(oop) ((oop) == syx_true)
#define SYX_IS_FALSE(oop) ((oop) == syx_false)
#define SYX_IS_BOOLEAN(oop) (SYX_IS_TRUE(oop) || SYX_IS_FALSE(oop))
#define SYX_IS_OBJECT(oop) (SYX_IS_POINTER(oop) &&                      \
                            (oop) >= (SyxOop)syx_memory &&              \
                            (oop) <= (SyxOop)(syx_memory + _syx_memory_size - 1))
#define SYX_IS_CPOINTER(oop) (SYX_IS_POINTER(oop) &&                    \
                              ((oop) < (SyxOop)syx_memory ||            \
                               (oop) >= (SyxOop)(syx_memory + _syx_memory_size)))

#define SYX_OBJECT_IS_STRING(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->klass == syx_string_class)
#define SYX_OBJECT_IS_SYMBOL(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->klass == syx_symbol_class)
#define SYX_OBJECT_IS_FLOAT(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->klass == syx_float_class)
#define SYX_OBJECT_IS_LARGE_INTEGER(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->klass == syx_large_integer_class)

/* Oop */

typedef struct SyxObject SyxObject;

/*! The core class of Syx holding necessary informations for each concrete object. */
struct SyxObject
{
  /*! Holds the class of the instance. Please use syx_object_get_class to obtain a class from a SyxOop */
  SyxOop klass;
  
  /*! Specify if this object contains references to other objects in its data */
  syx_bool has_refs;

  /*! Used to mark the object by the garbage collector */
  syx_bool is_marked;

  /*! Set to TRUE if data shouldn't be modified */
  syx_bool is_constant;

  /*! A list of SyxOop containing instance variables. */
  SyxOop *vars;

  /*! The number of data elements held by the object */
  syx_varsize data_size;

  /*! This holds the data stored for the object. These can be oops, bytes, doubles and so on. */
  SyxOop *data;
};

extern EXPORT SyxObject *syx_memory;
extern EXPORT syx_int32 _syx_memory_size;

/*! Returns the index of the oop in the object table */
#define SYX_MEMORY_INDEX_OF(oop) (((oop) - (SyxOop)syx_memory) / sizeof (SyxObject))


/* References to commonly used oops */

extern EXPORT SyxOop syx_nil,
  syx_true,
  syx_false,

  syx_metaclass_class,
  syx_undefined_object_class,
  syx_true_class,
  syx_false_class,
  syx_small_integer_class,
  syx_character_class,
  syx_cpointer_class,

  syx_large_integer_class,
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

EXPORT SyxOop syx_object_new_vars (SyxOop klass, syx_varsize vars_size);
#define syx_object_new(klass) (syx_object_new_vars ((klass), SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE ((klass)))))
EXPORT SyxOop syx_object_new_size (SyxOop klass, syx_bool has_refs, syx_varsize size);
EXPORT SyxOop syx_object_new_data (SyxOop klass, syx_bool has_refs, syx_varsize size, SyxOop *data);
EXPORT SyxOop syx_object_copy (SyxOop object);
EXPORT void syx_object_free (SyxOop oop);
EXPORT void syx_object_resize (SyxOop oop, syx_varsize size);
#define syx_object_grow_by(oop,size) (syx_object_resize((oop),SYX_OBJECT_DATA_SIZE(oop)+size))
EXPORT syx_int32 syx_object_get_variable_index (SyxOop self, syx_symbol name);
EXPORT void syx_object_initialize (SyxOop oop);


/*! Answer the hash of an Object */
INLINE syx_int32
syx_object_hash (SyxOop object)
{
  /* distinguish between objects and embedded values */
  if (SYX_IS_OBJECT (object))
    return SYX_MEMORY_INDEX_OF (object);

  /* i don't know how to hash C pointers sorry */
  return SYX_SMALL_INTEGER_EMBED (object);
}

/*!
  Get the class of an object.

  \param object can be an SyxOop
  \return For small integers return SmallInteger and for characters the Character class
*/
INLINE SyxOop 
syx_object_get_class (SyxOop object)
{
  /* ordered by usage */ 

  if (SYX_IS_OBJECT(object))
    return SYX_OBJECT(object)->klass;

  if (SYX_IS_SMALL_INTEGER(object))
    return syx_small_integer_class;

  if (SYX_IS_NIL(object))
    return syx_undefined_object_class;
  
  if (SYX_IS_CHARACTER(object))
    return syx_character_class;

  if (SYX_IS_CPOINTER(object))
    return syx_cpointer_class;

  syx_error ("unknown object\n");
  return syx_nil;
}



/*!
  Set the class of an object.

  If the object is a constant, a small integer or a character, no operation is done
*/
INLINE void
syx_object_set_class (SyxOop object, SyxOop klass)
{
  if (!SYX_IS_OBJECT(object))
    return;

  SYX_OBJECT(object)->klass = klass;
}

EXPORT syx_symbol *syx_class_get_all_instance_variable_names (SyxOop klass);
EXPORT syx_bool syx_class_is_superclass_of (SyxOop klass, SyxOop subclass);
EXPORT SyxOop syx_class_lookup_method (SyxOop klass, syx_symbol selector);
EXPORT SyxOop syx_class_lookup_method_binding (SyxOop klass, SyxOop binding);

EXPORT syx_int32 syx_dictionary_index_of (SyxOop dict, syx_symbol key, syx_bool return_nil_index);
EXPORT void syx_dictionary_rehash (SyxOop dict);
EXPORT SyxOop syx_dictionary_binding_at_symbol (SyxOop dict, syx_symbol key);
EXPORT SyxOop syx_dictionary_binding_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object);
EXPORT SyxOop syx_dictionary_bind (SyxOop binding);
EXPORT void syx_dictionary_bind_set_value (SyxOop binding, SyxOop value);
EXPORT SyxOop syx_dictionary_at_symbol (SyxOop dict, syx_symbol key);
EXPORT SyxOop syx_dictionary_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object);
EXPORT void syx_dictionary_at_symbol_put (SyxOop dict, SyxOop key, SyxOop value);

EXPORT syx_int32 syx_string_hash (syx_symbol string);

/* Constructors */

EXPORT SyxOop syx_metaclass_new (SyxOop supermetaclass);
EXPORT SyxOop syx_class_new (SyxOop superclass);
EXPORT SyxOop syx_large_integer_new (syx_symbol string, syx_int32 base);
EXPORT SyxOop syx_large_integer_new_integer (syx_int32 integer);
EXPORT SyxOop syx_large_integer_new_mpz (syx_pointer mpz);
EXPORT SyxOop syx_symbol_new (syx_symbol symbol);
EXPORT SyxOop syx_method_context_new (SyxOop method, SyxOop receiver, SyxOop arguments);
EXPORT SyxOop syx_block_context_new (SyxOop block, SyxOop arguments);
EXPORT SyxOop syx_process_new (void);

EXPORT syx_bool syx_array_remove (SyxOop array, SyxOop element);
EXPORT void syx_array_add (SyxOop array, SyxOop element, syx_bool unique);

/* Accessors */

#define SYX_CLASS_NAME(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_NAME])
#define SYX_CLASS_SUPERCLASS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_SUPERCLASS])
#define SYX_CLASS_INSTANCE_VARIABLES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_INSTANCE_VARIABLES])
#define SYX_CLASS_INSTANCE_SIZE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_INSTANCE_SIZE])
#define SYX_CLASS_METHODS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_METHODS])
#define SYX_CLASS_SUBCLASSES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_SUBCLASSES])
#define SYX_CLASS_FINALIZATION(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_FINALIZATION])

#define SYX_METACLASS_INSTANCE_CLASS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METACLASS_INSTANCE_CLASS])

#define SYX_CLASS_CLASS_VARIABLES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CLASS_CLASS_VARIABLES])

#define SYX_DICTIONARY_TALLY(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_DICTIONARY_TALLY])

#define SYX_ASSOCIATION_KEY(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_ASSOCIATION_KEY])
#define SYX_ASSOCIATION_VALUE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_ASSOCIATION_VALUE])

#define SYX_VARIABLE_BINDING_DICTIONARY(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_VARIABLE_BINDING_DICTIONARY])

#define SYX_CODE_BYTECODES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_BYTECODES])
#define SYX_CODE_ARGUMENTS_COUNT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_ARGUMENTS_COUNT])
#define SYX_CODE_TEMPORARIES_COUNT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_TEMPORARIES_COUNT])
#define SYX_CODE_LITERALS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_LITERALS])
#define SYX_CODE_STACK_SIZE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_STACK_SIZE])
#define SYX_CODE_PRIMITIVE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_PRIMITIVE])
#define SYX_CODE_CLASS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_CLASS])
#define SYX_CODE_TEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_CODE_TEXT])

#define SYX_METHOD_ARGUMENT_STACK_SIZE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_ARGUMENT_STACK_SIZE])
#define SYX_METHOD_TEMPORARY_STACK_SIZE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_TEMPORARY_STACK_SIZE])
#define SYX_METHOD_SELECTOR(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_SELECTOR])
#define SYX_METHOD_PRIMITIVE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_PRIMITIVE])

#define SYX_BLOCK_CLOSURE_BLOCK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CLOSURE_BLOCK])
#define SYX_BLOCK_CLOSURE_OUTER_FRAME(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CLOSURE_OUTER_FRAME])

#define SYX_METHOD_CONTEXT_PARENT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_PARENT])
#define SYX_METHOD_CONTEXT_METHOD(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_METHOD])
#define SYX_METHOD_CONTEXT_ARGUMENTS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_ARGUMENTS])
#define SYX_METHOD_CONTEXT_RECEIVER(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_RECEIVER])

#define SYX_BLOCK_CONTEXT_OUTER_CONTEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_OUTER_CONTEXT])
#define SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_HANDLED_EXCEPTION])
#define SYX_BLOCK_CONTEXT_HANDLER_BLOCK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_HANDLER_BLOCK])
#define SYX_BLOCK_CONTEXT_ENSURE_BLOCK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_ENSURE_BLOCK])

#define SYX_PROCESS_STACK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_STACK])
#define SYX_PROCESS_FRAME_POINTER(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_FRAME_POINTER])
#define SYX_PROCESS_SUSPENDED(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_SUSPENDED])
#define SYX_PROCESS_RETURNED_OBJECT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_RETURNED_OBJECT])
#define SYX_PROCESS_NEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_NEXT])
#define SYX_PROCESS_SCHEDULED(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_SCHEDULED])

#define SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_ACTIVE_PROCESS])
#define SYX_PROCESSOR_SCHEDULER_FIRST_PROCESS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_FIRST_PROCESS])
#define SYX_PROCESSOR_SCHEDULER_BYTESLICE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_BYTESLICE])

#define SYX_SEMAPHORE_LIST(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_SEMAPHORE_LIST])
#define SYX_SEMAPHORE_SIGNALS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_SEMAPHORE_SIGNALS])



/*!
  Returns the number of instance variables held by the object.

  This method obtain the size of the instance from the instanceSize of its class
*/
INLINE syx_varsize
syx_object_vars_size (SyxOop object)
{
  SyxOop klass = syx_object_get_class (object);
  return SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE (klass));
}


/* Inlined constructors */


/*! Create a Float object */
INLINE SyxOop
syx_float_new (syx_double floating)
{
  SyxOop oop = syx_object_new_size (syx_float_class, FALSE, sizeof (syx_double));
  SYX_OBJECT_FLOAT(oop) = floating;
  return oop;
}


/*!
  Creates a new ByteArray instance.

  \param size the number of elements
  \param data already initialized data for the byte array
*/
INLINE SyxOop 
syx_byte_array_new (syx_varsize size, syx_uint8 *data)
{
  return syx_object_new_data (syx_byte_array_class, FALSE, size, (SyxOop *)data);
}

/*! Creates a new ByteArray instance with the given size */
INLINE SyxOop 
syx_byte_array_new_size (syx_varsize size)
{
  return syx_object_new_size (syx_byte_array_class, FALSE, size);
}

/*! Like syx_byte_array_new but duplicates the data */
INLINE SyxOop
syx_byte_array_new_ref (syx_varsize size, syx_uint8 *data)
{
  SyxOop oop = syx_byte_array_new_size (size);
  memcpy (SYX_OBJECT_DATA (oop), data, size * sizeof (syx_uint8));
  return oop;
}

/*!
  Creates a new Array instance.

  \param size the number of elements
  \param data already initialized data for the array
*/
INLINE SyxOop 
syx_array_new (syx_varsize size, SyxOop *data)
{
  return syx_object_new_data (syx_array_class, TRUE, size, data);
}

/*! Creates a sized Array */
INLINE SyxOop 
syx_array_new_size (syx_varsize size)
{
  return syx_object_new_size (syx_array_class, TRUE, size);
}

/*! Like syx_byte_array_new but duplicates the data */
INLINE SyxOop
syx_array_new_ref (syx_varsize size, SyxOop *data)
{
  SyxOop oop = syx_array_new_size (size);
  memcpy (SYX_OBJECT_DATA(oop), data, size * sizeof (SyxOop));
  return oop;
}


/*! Returns a new String instance. Duplicates the string in input.
  
  Use of variadic arguments is allowed to create a new string like using sprintf.
 */
INLINE SyxOop 
syx_string_new (syx_symbol string, ...)
{
  syx_string new_string;
  SYX_VSPRINTF (string, new_string);
  if (!new_string)
    return syx_nil;

  return syx_object_new_data (syx_string_class, FALSE, strlen (string) + 1, (SyxOop *)new_string);
}

/*! Returns a new String instance. */
INLINE SyxOop
syx_string_new_ref (syx_string string)
{
  if (!string)
    return syx_nil;

  return syx_object_new_data (syx_string_class, FALSE, strlen (string) + 1, (SyxOop *)string);
}

/*! Creates a new VariableBinding key -> index on a dictionary */
INLINE SyxOop
syx_variable_binding_new (SyxOop key, syx_int32 index, SyxOop dictionary)
{
  SyxOop object = syx_object_new (syx_variable_binding_class);
  SYX_ASSOCIATION_KEY(object) = key;
  SYX_ASSOCIATION_VALUE(object) = syx_small_integer_new (index);
  SYX_VARIABLE_BINDING_DICTIONARY(object) = dictionary;
  return object;
}

/*!
  Creates a new dictionary and its hash table.

  The effective size of the hash table is size * 2
*/
INLINE SyxOop 
syx_dictionary_new (syx_varsize size)
{
  SyxOop dict = syx_object_new_size (syx_dictionary_class, TRUE, size * 2);
  SYX_DICTIONARY_TALLY (dict) = syx_small_integer_new (0);
  return dict;
}

/*!
  Create a new BlockClosure.

  \param block a CompiledBlock
*/
INLINE SyxOop 
syx_block_closure_new (SyxOop block)
{
  SyxOop object = syx_object_new (syx_block_closure_class);
  SYX_BLOCK_CLOSURE_BLOCK(object) = block;
  return object;
}


/*! Create a new raw CompiledMethod */
#define syx_method_new() (syx_object_new (syx_compiled_method_class))

/*! Create a new raw CompiledBlock */
#define syx_block_new() (syx_object_new (syx_compiled_block_class))

SYX_END_DECLS

#endif /* SYX_OBJECT_H */
