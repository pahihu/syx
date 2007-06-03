#ifndef SYX_OBJECT_H
#define SYX_OBJECT_H

#include <string.h>
#include "syx-types.h"
#include "syx-memory.h"
#include "syx-enums.h"

#define SYX_OBJECT(ptr) ((SyxObject *)(ptr))
#define SYX_OBJECT_SYMBOL(object) ((syx_symbol)(object)->data)
#define SYX_OBJECT_STRING(object) ((syx_string)(object)->data)
#define SYX_OBJECT_BYTE_ARRAY(ptr) ((syx_int8 *)(object)->data)
#define SYX_OBJECT_SIZE(object) ((object)->size)
#define SYX_OBJECT_DATA(object) ((object)->data)

/* Object */

typedef struct SyxObject SyxObject;

struct SyxObject
{
  SyxObject *class; // please use syx_object_get_class ()
  syx_varsize size;
  SyxObject **data;
};

/* References to commonly used objects */

extern SyxObject *syx_metaclass_class,

  *syx_undefined_object_class,
  *syx_true_class,
  *syx_false_class,
  *syx_small_integer_class,
  *syx_character_class,

  *syx_symbol_class,
  *syx_string_class,
  *syx_array_class,

  *syx_link_class,
  *syx_dictionary_class,

  *syx_compiled_method_class,
  *syx_compiled_block_class,
  *syx_block_closure_class,

  *syx_method_context_class,
  *syx_block_context_class,
  *syx_process_class,
  *syx_processor_scheduler_class,

  *syx_symbols,
  *syx_globals;

SyxObject *syx_object_new (SyxObject *class);
SyxObject *syx_object_new_size (SyxObject *class, syx_varsize size);
SyxObject *syx_object_new_data (SyxObject *class, syx_varsize size, syx_pointer data);
void syx_object_grow_by (SyxObject *object, syx_varsize size);
syx_int32 syx_object_get_variable_index (SyxObject *self, syx_symbol name);
inline syx_nint syx_object_hash (SyxObject *ptr);
inline SyxObject *syx_object_get_class (SyxObject *object);
inline void syx_object_set_class (SyxObject *object, SyxObject *class);

syx_symbol *syx_class_get_all_instance_variables (SyxObject *class);
syx_bool syx_class_is_superclass_of (SyxObject *class, SyxObject *subclass);
SyxObject *syx_class_lookup_method (SyxObject *class, syx_symbol selector);

SyxObject *syx_dictionary_at_const (SyxObject *dict, SyxObject *key);
SyxObject *syx_dictionary_at_symbol (SyxObject *dict, syx_symbol key);
void syx_dictionary_at_const_put (SyxObject *dict, SyxObject *key, SyxObject *value);

/* Builders */

inline SyxObject *syx_metaclass_new (SyxObject *supermetaclass);
inline SyxObject *syx_class_new (SyxObject *superclass);
inline SyxObject *syx_array_new (syx_varsize size, syx_pointer data);
inline SyxObject *syx_array_new_size (syx_varsize size);
inline SyxObject *syx_symbol_new (syx_symbol symbol);
inline SyxObject *syx_string_new (syx_symbol string);
inline SyxObject *syx_link_new (SyxObject *key, SyxObject *value);
inline SyxObject *syx_dictionary_new (syx_varsize size);
inline SyxObject *syx_block_closure_new (SyxObject *block);
#define syx_method_new() (syx_object_new (syx_compiled_method_class))
#define syx_block_new() (syx_object_new (syx_compiled_block_class))
inline SyxObject *syx_method_context_new (SyxObject *parent, SyxObject *method, SyxObject *receiver, SyxObject *arguments);
inline SyxObject *syx_block_context_new (SyxObject *parent, SyxObject *block, SyxObject *receiver, SyxObject *arguments,
					 SyxObject *return_context);
inline SyxObject *syx_process_new (SyxObject *context);

/* Accessors */

#define SYX_CLASS_NAME(object) (SYX_OBJECT_DATA(object)[SYX_DATA_CLASS_NAME])
#define SYX_CLASS_SUPERCLASS(object) (SYX_OBJECT_DATA(object)[SYX_DATA_CLASS_SUPERCLASS])
#define SYX_CLASS_INSTANCE_VARIABLES(object) (SYX_OBJECT_DATA(object)[SYX_DATA_CLASS_INSTANCE_VARIABLES])
#define SYX_CLASS_INSTANCE_SIZE(object) (SYX_OBJECT_DATA(object)[SYX_DATA_CLASS_INSTANCE_SIZE])
#define SYX_CLASS_METHODS(object) (SYX_OBJECT_DATA(object)[SYX_DATA_CLASS_METHODS])

#define SYX_LINK_KEY(object) (SYX_OBJECT_DATA(object)[SYX_DATA_LINK_KEY])
#define SYX_LINK_VALUE(object) (SYX_OBJECT_DATA(object)[SYX_DATA_LINK_VALUE])
#define SYX_LINK_NEXT_LINK(object) (SYX_OBJECT_DATA(object)[SYX_DATA_LINK_NEXT_LINK])

#define SYX_DICTIONARY_HASH_TABLE(object) (SYX_OBJECT_DATA(object)[SYX_DATA_DICTIONARY_HASH_TABLE])

#define SYX_METHOD_SELECTOR(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_SELECTOR])
#define SYX_METHOD_BYTECODES(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_BYTECODES])
#define SYX_METHOD_LITERALS(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_LITERALS])
#define SYX_METHOD_ARGUMENTS_COUNT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_ARGUMENTS_COUNT])
#define SYX_METHOD_TEMPORARIES_COUNT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_TEMPORARIES_COUNT])
#define SYX_METHOD_STACK_SIZE(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_STACK_SIZE])

#define SYX_BLOCK_CLOSURE_BLOCK(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CLOSURE_BLOCK])
#define SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CLOSURE_DEFINED_CONTEXT])

#define SYX_METHOD_CONTEXT_PARENT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_PARENT])
#define SYX_METHOD_CONTEXT_METHOD(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_METHOD])
#define SYX_METHOD_CONTEXT_STACK(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_STACK])
#define SYX_METHOD_CONTEXT_SP(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_SP])
#define SYX_METHOD_CONTEXT_IP(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_IP])
#define SYX_METHOD_CONTEXT_RECEIVER(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_RECEIVER])
#define SYX_METHOD_CONTEXT_ARGUMENTS(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_ARGUMENTS])
#define SYX_METHOD_CONTEXT_TEMPORARIES(object) (SYX_OBJECT_DATA(object)[SYX_DATA_METHOD_CONTEXT_TEMPORARIES])

#define SYX_BLOCK_CONTEXT_OUTER_CONTEXT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CONTEXT_OUTER_CONTEXT])
#define SYX_BLOCK_CONTEXT_RETURN_CONTEXT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CONTEXT_RETURN_CONTEXT])
#define SYX_BLOCK_CONTEXT_HANDLED_EXCEPTION(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CONTEXT_HANDLED_EXCEPTION])
#define SYX_BLOCK_CONTEXT_HANDLER_BLOCK(object) (SYX_OBJECT_DATA(object)[SYX_DATA_BLOCK_CONTEXT_HANDLER_BLOCK])

#define SYX_PROCESS_CONTEXT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_CONTEXT])
#define SYX_PROCESS_SUSPENDED(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_SUSPENDED])
#define SYX_PROCESS_RETURNED_OBJECT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_RETURNED_OBJECT])
#define SYX_PROCESS_NEXT(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_NEXT])
#define SYX_PROCESS_SCHEDULED(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_SCHEDULED])

#define SYX_PROCESS_SCHEDULER_ACTIVE_PROCESS(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_SCHEDULER_ACTIVE_PROCESS])
#define SYX_PROCESS_SCHEDULER_BYTESLICE(object) (SYX_OBJECT_DATA(object)[SYX_DATA_PROCESS_SCHEDULER_BYTESLICE])

#endif /* SYX_OBJECT_H */
