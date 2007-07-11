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

#ifndef SYX_OBJECT_H
#define SYX_OBJECT_H

#include "syx-types.h"
#include "syx-enums.h"

#include <string.h>

#define SYX_OBJECT(oop) ((SyxObject *) (oop))
#define SYX_OBJECT_FLOAT(oop) (*((syx_double *)(SYX_OBJECT(oop)->data)))

#ifdef HAVE_LIBGMP
#include <gmp.h>
#define SYX_OBJECT_LARGE_INTEGER(oop) (*((mpz_t *)(SYX_OBJECT(oop)->data)))
#endif

#define SYX_OBJECT_SYMBOL(oop) ((syx_symbol)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_STRING(oop) ((syx_string)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_BYTE_ARRAY(oop) ((syx_int8 *)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_VARS(oop) (SYX_OBJECT(oop)->vars)
#define SYX_OBJECT_DATA_SIZE(oop) (SYX_OBJECT(oop)->data_size)
#define SYX_OBJECT_DATA(oop) (SYX_OBJECT(oop)->data)
#define SYX_OBJECT_HAS_REFS(oop) (SYX_OBJECT(oop)->has_refs)
#define SYX_OBJECT_IS_MARKED(oop) (SYX_OBJECT(oop)->is_marked)

#define SYX_IS_NIL(oop) ((oop) == 0 || (oop) == syx_nil)
#define SYX_IS_TRUE(oop) ((oop) == syx_true)
#define SYX_IS_FALSE(oop) ((oop) == syx_false)
#define SYX_IS_OBJECT(oop) (SYX_IS_POINTER(oop) &&		\
			    (oop) >= (SyxOop)syx_memory &&	\
			    (oop) <= (SyxOop)(syx_memory + _syx_memory_size - 1))
#define SYX_IS_CPOINTER(oop) (SYX_IS_POINTER(oop) &&			\
			      ((oop) < (SyxOop)syx_memory ||		\
			       (oop) >= (SyxOop)(syx_memory + _syx_memory_size)))

#define SYX_OBJECT_IS_FLOAT(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->class == syx_float_class)
#define SYX_OBJECT_IS_LARGE_INTEGER(oop) (SYX_IS_OBJECT(oop) && SYX_OBJECT(oop)->class == syx_large_integer_class)

/* Oop */

typedef struct SyxObject SyxObject;

struct SyxObject
{
  //! Holds the class of the instance. Please use syx_object_get_class to obtain a class from a SyxOop
  SyxOop class;
  
  //! Specify if this object contains references to other objects in its data
  syx_bool has_refs : 1;

  //! Used to mark the object by the garbage collector
  syx_bool is_marked : 1;

  //! A list of SyxOop containing instance variables.
  SyxOop *vars;

  //! The number of data elements held by the object
  syx_varsize data_size;

  //! This holds the data stored for the object. These can be oops, bytes, doubles and so on.
  SyxOop *data;
};

/* References to commonly used oops */

extern SyxOop syx_nil,
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
  syx_link_class,
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

SyxOop syx_object_new_vars (SyxOop class, syx_varsize vars_size);
inline SyxOop syx_object_new (SyxOop class);
SyxOop syx_object_new_size (SyxOop class, syx_bool has_refs, syx_varsize size);
SyxOop syx_object_new_data (SyxOop class, syx_bool has_refs, syx_varsize size, SyxOop *data);
SyxOop syx_object_copy (SyxOop object);
syx_varsize syx_object_vars_size (SyxOop object);
void syx_object_free (SyxOop oop);
void syx_object_resize (SyxOop oop, syx_varsize size);
#define syx_object_grow_by(oop,size) (syx_object_resize((oop),SYX_OBJECT_DATA_SIZE(oop)+size))
syx_int32 syx_object_get_variable_index (SyxOop self, syx_symbol name);
inline syx_int32 syx_object_hash (SyxOop oop);
inline SyxOop syx_object_get_class (SyxOop oop);
inline void syx_object_set_class (SyxOop oop, SyxOop class);

syx_symbol *syx_class_get_all_instance_variable_names (SyxOop class);
syx_bool syx_class_is_superclass_of (SyxOop class, SyxOop subclass);
SyxOop syx_class_lookup_method (SyxOop class, syx_symbol selector);
SyxOop syx_class_lookup_method_binding (SyxOop class, SyxOop binding);

SyxOop syx_dictionary_binding_at_symbol (SyxOop dict, syx_symbol key);
SyxOop syx_dictionary_binding_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object);
SyxOop syx_dictionary_bind (SyxOop binding);
void syx_dictionary_bind_set_value (SyxOop binding, SyxOop value);
SyxOop syx_dictionary_at_symbol (SyxOop dict, syx_symbol key);
SyxOop syx_dictionary_at_symbol_if_absent (SyxOop dict, syx_symbol key, SyxOop object);
void syx_dictionary_at_symbol_put (SyxOop dict, SyxOop key, SyxOop value);

/* Builders */

inline SyxOop syx_metaclass_new (SyxOop supermetaclass);
inline SyxOop syx_class_new (SyxOop superclass);
inline SyxOop syx_large_integer_new (syx_symbol string, syx_int32 base);
inline SyxOop syx_large_integer_new_integer (syx_int32 integer);
inline SyxOop syx_large_integer_new_mpz (syx_pointer mpz);
inline SyxOop syx_float_new (syx_double floating);
inline SyxOop syx_byte_array_new (syx_varsize size, syx_uint8 *data);
inline SyxOop syx_byte_array_new_size (syx_varsize size);
inline SyxOop syx_byte_array_new_ref (syx_varsize size, syx_uint8 *data);
inline SyxOop syx_array_new (syx_varsize size, SyxOop *data);
inline SyxOop syx_array_new_ref (syx_varsize size, SyxOop *data);
inline SyxOop syx_array_new_size (syx_varsize size);
syx_bool syx_array_remove (SyxOop array, SyxOop element);
void syx_array_add (SyxOop array, SyxOop element, syx_bool unique);
inline SyxOop syx_symbol_new (syx_symbol symbol);
inline SyxOop syx_string_new (syx_symbol string);
inline syx_int32 syx_string_hash (syx_symbol string);
inline SyxOop syx_variable_binding_new (SyxOop key, syx_int32 index, SyxOop dict);
inline SyxOop syx_link_new (SyxOop key, SyxOop value, SyxOop next);
inline SyxOop syx_dictionary_new (syx_varsize size);
inline SyxOop syx_block_closure_new (SyxOop block);

//! Create a new raw CompiledMethod
#define syx_method_new() (syx_object_new (syx_compiled_method_class))

//! Create a new raw CompiledBlock
#define syx_block_new() (syx_object_new (syx_compiled_block_class))

SyxOop syx_method_context_new (SyxOop parent, SyxOop method, SyxOop receiver, SyxOop arguments);
SyxOop syx_block_context_new (SyxOop parent, SyxOop block, SyxOop arguments, SyxOop outer_context);
inline SyxOop syx_process_new (SyxOop context);

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

#define SYX_ASSOCIATION_KEY(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_ASSOCIATION_KEY])
#define SYX_ASSOCIATION_VALUE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_ASSOCIATION_VALUE])

#define SYX_LINK_NEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_LINK_NEXT])

#define SYX_VARIABLE_BINDING_DICTIONARY(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_VARIABLE_BINDING_DICTIONARY])

#define SYX_METHOD_SELECTOR(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_SELECTOR])
#define SYX_METHOD_BYTECODES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_BYTECODES])
#define SYX_METHOD_LITERALS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_LITERALS])
#define SYX_METHOD_ARGUMENTS_COUNT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_ARGUMENTS_COUNT])
#define SYX_METHOD_TEMPORARIES_COUNT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_TEMPORARIES_COUNT])
#define SYX_METHOD_STACK_SIZE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_STACK_SIZE])
#define SYX_METHOD_PRIMITIVE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_PRIMITIVE])

#define SYX_BLOCK_ARGUMENTS_TOP(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_ARGUMENTS_TOP])

#define SYX_BLOCK_CLOSURE_BLOCK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CLOSURE_BLOCK])
#define SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CLOSURE_DEFINED_CONTEXT])

#define SYX_METHOD_CONTEXT_PARENT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_PARENT])
#define SYX_METHOD_CONTEXT_METHOD(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_METHOD])
#define SYX_METHOD_CONTEXT_STACK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_STACK])
#define SYX_METHOD_CONTEXT_SP(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_SP])
#define SYX_METHOD_CONTEXT_IP(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_IP])
#define SYX_METHOD_CONTEXT_RECEIVER(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_RECEIVER])
#define SYX_METHOD_CONTEXT_ARGUMENTS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_ARGUMENTS])
#define SYX_METHOD_CONTEXT_TEMPORARIES(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_TEMPORARIES])
#define SYX_METHOD_CONTEXT_RETURN_CONTEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_METHOD_CONTEXT_RETURN_CONTEXT])

#define SYX_BLOCK_CONTEXT_OUTER_CONTEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_OUTER_CONTEXT])
#define SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_HANDLED_EXCEPTION])
#define SYX_BLOCK_CONTEXT_HANDLER_BLOCK(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_BLOCK_CONTEXT_HANDLER_BLOCK])

#define SYX_PROCESS_CONTEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_CONTEXT])
#define SYX_PROCESS_SUSPENDED(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_SUSPENDED])
#define SYX_PROCESS_RETURNED_OBJECT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_RETURNED_OBJECT])
#define SYX_PROCESS_NEXT(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_NEXT])
#define SYX_PROCESS_SCHEDULED(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESS_SCHEDULED])

#define SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_ACTIVE_PROCESS])
#define SYX_PROCESSOR_SCHEDULER_FIRST_PROCESS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_FIRST_PROCESS])
#define SYX_PROCESSOR_SCHEDULER_BYTESLICE(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_PROCESSOR_SCHEDULER_BYTESLICE])

#define SYX_SEMAPHORE_LIST(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_SEMAPHORE_LIST])
#define SYX_SEMAPHORE_SIGNALS(oop) (SYX_OBJECT_VARS(oop)[SYX_VARS_SEMAPHORE_SIGNALS])

#endif /* SYX_OBJECT_H */
