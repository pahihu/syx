#ifndef SYX_OBJECT_H
#define SYX_OBJECT_H

#include <string.h>
#include "syx-types.h"
#include "syx-enums.h"

#define SYX_OBJECT(oop) (SYX_OOP_TO_POINTER(oop))
#define SYX_SMALL_INTEGER(oop) (oop.i.value)
#define SYX_CHARACTER(oop) (oop.c.value)

#define SYX_OBJECT_SYMBOL(oop) ((syx_symbol)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_STRING(oop) ((syx_string)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_BYTE_ARRAY(ptr) ((syx_int8 *)(SYX_OBJECT(oop)->data))
#define SYX_OBJECT_SIZE(oop) (SYX_OBJECT(oop)->size)
#define SYX_OBJECT_DATA(oop) (SYX_OBJECT(oop)->data)
#define SYX_OBJECT_HAS_REFS(oop) (SYX_OBJECT(oop)->has_refs)
#define SYX_OBJECT_IS_MARKED(oop) (SYX_OBJECT(oop)->is_marked)

#define SYX_NIL syx_nil
#define SYX_TRUE syx_true
#define SYX_FALSE syx_false

#define SYX_IS_NIL(oop) ((oop).idx == 0)
#define SYX_IS_TRUE(oop) ((oop).idx == 1)
#define SYX_IS_FALSE(oop) ((oop).idx == 2)
#define SYX_IS_OBJECT(oop) ((oop).c.type == SYX_TYPE_OBJECT && (oop).idx > 2)
#define SYX_IS_SMALL_INTEGER(oop) ((oop).i.type == SYX_TYPE_SMALL_INTEGER)
#define SYX_IS_CHARACTER(oop) ((oop).c.type == SYX_TYPE_CHARACTER)

/* Oop */

typedef struct SyxObject SyxObject;

struct SyxObject
{
  SyxOop class; // please use syx_object_get_class ()
  syx_bool has_refs : 1;
  syx_bool is_marked : 1;
  syx_varsize size;
  SyxOop *data;
};

/* References to commonly used oops */

extern SyxOop syx_nil,
  syx_true,
  syx_false,

  syx_metaclass_class,
  syx_undefined_oop_class,
  syx_true_class,
  syx_false_class,
  syx_small_integer_class,
  syx_character_class,

  syx_symbol_class,
  syx_string_class,
  syx_byte_array_class,
  syx_array_class,

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

SyxOop syx_object_new (SyxOop class, syx_bool has_refs);
SyxOop syx_object_new_size (SyxOop class, syx_bool has_refs, syx_varsize size);
SyxOop syx_object_new_data (SyxOop class, syx_bool has_refs, syx_varsize size, SyxOop *data);
void syx_object_free (SyxOop oop);
void syx_object_grow_by (SyxOop oop, syx_varsize size);
syx_int32 syx_object_get_variable_index (SyxOop self, syx_symbol name);
inline syx_int32 syx_object_hash (SyxOop ptr);
inline SyxOop syx_object_get_class (SyxOop oop);
inline void syx_object_set_class (SyxOop oop, SyxOop class);

#define syx_boolean_new(cond) ((cond) ? SYX_TRUE : SYX_FALSE)
inline SyxOop syx_small_integer_new (syx_int32 num);
inline SyxOop syx_character_new (syx_uint8 ch);

syx_symbol *syx_class_get_all_instance_variables (SyxOop class);
syx_bool syx_class_is_superclass_of (SyxOop class, SyxOop subclass);
SyxOop syx_class_lookup_method (SyxOop class, syx_symbol selector);

SyxOop syx_dictionary_at_const (SyxOop dict, SyxOop key);
SyxOop syx_dictionary_at_symbol (SyxOop dict, syx_symbol key);
void syx_dictionary_at_const_put (SyxOop dict, SyxOop key, SyxOop value);

/* Builders */

inline SyxOop syx_metaclass_new (SyxOop supermetaclass);
inline SyxOop syx_class_new (SyxOop superclass);
inline SyxOop syx_byte_array_new (syx_varsize size, syx_uint8 *data);
inline SyxOop syx_byte_array_new_size (syx_varsize size);
inline SyxOop syx_byte_array_new_ref (syx_varsize size, syx_uint8 *data);
inline SyxOop syx_array_new (syx_varsize size, SyxOop *data);
inline SyxOop syx_array_new_ref (syx_varsize size, SyxOop *data);
inline SyxOop syx_array_new_size (syx_varsize size);
inline SyxOop syx_symbol_new (syx_symbol symbol);
inline SyxOop syx_string_new (syx_symbol string);
inline SyxOop syx_link_new (SyxOop key, SyxOop value);
inline SyxOop syx_dictionary_new (syx_varsize size);
inline SyxOop syx_block_closure_new (SyxOop block);
#define syx_method_new() (syx_object_new (syx_compiled_method_class, TRUE))
#define syx_block_new() (syx_object_new (syx_compiled_block_class, TRUE))
inline SyxOop syx_method_context_new (SyxOop parent, SyxOop method, SyxOop receiver, SyxOop arguments);
inline SyxOop syx_block_context_new (SyxOop parent, SyxOop block, SyxOop arguments, SyxOop outer_context);
inline SyxOop syx_process_new (SyxOop context);

/* Accessors */

#define SYX_CLASS_NAME(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_CLASS_NAME])
#define SYX_CLASS_SUPERCLASS(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_CLASS_SUPERCLASS])
#define SYX_CLASS_INSTANCE_VARIABLES(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_CLASS_INSTANCE_VARIABLES])
#define SYX_CLASS_INSTANCE_SIZE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_CLASS_INSTANCE_SIZE])
#define SYX_CLASS_METHODS(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_CLASS_METHODS])

#define SYX_LINK_KEY(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_LINK_KEY])
#define SYX_LINK_VALUE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_LINK_VALUE])
#define SYX_LINK_NEXT_LINK(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_LINK_NEXT_LINK])

#define SYX_DICTIONARY_HASH_TABLE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_DICTIONARY_HASH_TABLE])

#define SYX_METHOD_SELECTOR(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_SELECTOR])
#define SYX_METHOD_BYTECODES(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_BYTECODES])
#define SYX_METHOD_LITERALS(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_LITERALS])
#define SYX_METHOD_ARGUMENTS_COUNT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_ARGUMENTS_COUNT])
#define SYX_METHOD_TEMPORARIES_COUNT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_TEMPORARIES_COUNT])
#define SYX_METHOD_STACK_SIZE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_STACK_SIZE])
#define SYX_METHOD_PRIMITIVE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_PRIMITIVE])

#define SYX_BLOCK_ARGUMENTS_TOP(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_ARGUMENTS_TOP])

#define SYX_BLOCK_CLOSURE_BLOCK(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_CLOSURE_BLOCK])
#define SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_CLOSURE_DEFINED_CONTEXT])

#define SYX_METHOD_CONTEXT_PARENT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_PARENT])
#define SYX_METHOD_CONTEXT_METHOD(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_METHOD])
#define SYX_METHOD_CONTEXT_STACK(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_STACK])
#define SYX_METHOD_CONTEXT_SP(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_SP])
#define SYX_METHOD_CONTEXT_IP(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_IP])
#define SYX_METHOD_CONTEXT_RECEIVER(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_RECEIVER])
#define SYX_METHOD_CONTEXT_ARGUMENTS(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_ARGUMENTS])
#define SYX_METHOD_CONTEXT_TEMPORARIES(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_TEMPORARIES])
#define SYX_METHOD_CONTEXT_RETURN_CONTEXT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_METHOD_CONTEXT_RETURN_CONTEXT])

#define SYX_BLOCK_CONTEXT_OUTER_CONTEXT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_CONTEXT_OUTER_CONTEXT])
#define SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_CONTEXT_HANDLED_EXCEPTION])
#define SYX_BLOCK_CONTEXT_HANDLER_BLOCK(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_BLOCK_CONTEXT_HANDLER_BLOCK])

#define SYX_PROCESS_CONTEXT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESS_CONTEXT])
#define SYX_PROCESS_SUSPENDED(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESS_SUSPENDED])
#define SYX_PROCESS_RETURNED_OBJECT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESS_RETURNED_OBJECT])
#define SYX_PROCESS_NEXT(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESS_NEXT])
#define SYX_PROCESS_SCHEDULED(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESS_SCHEDULED])

#define SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESSOR_SCHEDULER_ACTIVE_PROCESS])
#define SYX_PROCESSOR_SCHEDULER_BYTESLICE(oop) (SYX_OBJECT_DATA(oop)[SYX_DATA_PROCESSOR_SCHEDULER_BYTESLICE])

#endif /* SYX_OBJECT_H */
