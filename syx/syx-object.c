#include <stdio.h>
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-enums.h"
#include "syx-types.h"
#include "syx-scheduler.h"

/*! \page syx_object Syx Object
  
  \section Description
  syx-object.c: this file contains all the functions needed to work with Smalltalk objects.
  
  Objects are the core of Syx. They can represent both instances or classes.
  \note all objects are allocated in the Syx Memory
*/
 
SyxObject *syx_metaclass_class,

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

/* Inlines */

inline void
syx_object_grow_by (SyxObject *object, syx_varsize size)
{
  SYX_OBJECT_DATA(object) = syx_realloc (SYX_OBJECT_DATA(object), SYX_OBJECT_SIZE(object) + size);
}

inline SyxObject *
syx_object_get_class (SyxObject *object)
{
  /* ordered by usage */

  if (SYX_IS_POINTER(object))
    return object->class;

  if (SYX_IS_SMALL_INTEGER(object))
    return syx_small_integer_class;

  if (SYX_IS_NIL(object))
    return syx_undefined_object_class;

  if (SYX_IS_TRUE(object))
    return syx_true_class;

  if (SYX_IS_FALSE(object))
    return syx_false_class;

  if (SYX_IS_CHARACTER(object))
    return syx_character_class;
    
  return SYX_NIL;
}

inline void
syx_object_set_class (SyxObject *object, SyxObject *val)
{
  if (!SYX_IS_POINTER(object))
    return;

  object->class = val;
}

inline syx_nint
syx_object_hash (SyxObject *object)
{
  if (SYX_IS_POINTER (object))
    return (syx_nint) object;
  else if (SYX_IS_SMALL_INTEGER (object))
    return SYX_SMALL_INTEGER (object);
  else if (SYX_IS_CHARACTER (object))
    return SYX_CHARACTER (object);

  return 0;
}

/* Builders */

inline SyxObject *
syx_metaclass_new (SyxObject *supermetaclass)
{
  SyxObject *metaclass = syx_object_new (syx_metaclass_class, TRUE, TRUE);
  SYX_CLASS_SUPERCLASS(metaclass) = supermetaclass;
  SYX_CLASS_INSTANCE_SIZE(metaclass) = SYX_CLASS_INSTANCE_SIZE(supermetaclass);
  SYX_CLASS_INSTANCE_VARIABLES(metaclass) = syx_array_new (0, NULL);
  return metaclass;
}

inline SyxObject *
syx_class_new (SyxObject *superclass)
{
  SyxObject *metaclass = syx_metaclass_new (syx_object_get_class (superclass));
  SyxObject *class = syx_object_new (metaclass, TRUE, TRUE);
  SYX_CLASS_SUPERCLASS(class) = superclass;
  SYX_CLASS_INSTANCE_SIZE(class) = SYX_CLASS_INSTANCE_SIZE(superclass);
  SYX_CLASS_INSTANCE_VARIABLES(class) = syx_array_new (0, NULL);
  return class;
}

inline SyxObject *
syx_array_new (syx_varsize size, syx_pointer data)
{
  return syx_object_new_data (syx_array_class, FALSE, TRUE, size, data);
}

inline SyxObject *
syx_array_new_size (syx_varsize size)
{
  return syx_object_new_size (syx_array_class, FALSE, TRUE, size);
}

inline SyxObject *
syx_symbol_new (syx_symbol symbol)
{
  SyxObject *object = syx_dictionary_at_symbol (syx_symbols, symbol);
  if (SYX_IS_NIL (object))
    {
      object = syx_object_new_data (syx_symbol_class, FALSE, FALSE, strlen (symbol), strdup (symbol));
      syx_dictionary_at_const_put (syx_symbols, object, object);
    }

  return object;
}

inline SyxObject *
syx_string_new (syx_symbol string)
{
  return syx_object_new_data (syx_string_class, FALSE, FALSE, strlen (string), strdup (string));
}

inline SyxObject *
syx_link_new (SyxObject *key, SyxObject *value)
{
  SyxObject *object = syx_object_new (syx_link_class, FALSE, TRUE);
  SYX_LINK_KEY(object) = key;
  SYX_LINK_VALUE(object) = value;
  return object;
}

SyxObject *
syx_dictionary_new (syx_varsize size)
{
  SyxObject *object = syx_object_new (syx_dictionary_class, FALSE, TRUE);
  SYX_DICTIONARY_HASH_TABLE(object) = syx_array_new_size (size * 2);
  return object;
}

SyxObject *
syx_dictionary_at_const (SyxObject *dict, SyxObject *key)
{
  SyxObject *table = SYX_DICTIONARY_HASH_TABLE (dict);
  syx_varsize size = SYX_OBJECT_SIZE (table);
  syx_varsize i;

  for (i=0; i < size; i+=2)
    {
      if (SYX_OBJECT_DATA(table)[i] == key)
	return SYX_OBJECT_DATA(table)[i+1];
    }
  
  return SYX_NIL;
}

SyxObject *
syx_dictionary_at_symbol (SyxObject *dict, syx_symbol key)
{
  SyxObject *table = SYX_DICTIONARY_HASH_TABLE (dict);
  SyxObject *entry;
  syx_varsize size = SYX_OBJECT_SIZE (table);
  syx_varsize i;

  for (i=0; i < size; i+=2)
    {
      entry = SYX_OBJECT_DATA(table)[i];
      if (!SYX_IS_NIL (entry) && !strcmp (SYX_OBJECT_SYMBOL (entry), key))
	return SYX_OBJECT_DATA(table)[i+1];
    }
  
  return SYX_NIL;
}

void
syx_dictionary_at_const_put (SyxObject *dict, SyxObject *key, SyxObject *value)
{
  SyxObject *table = SYX_DICTIONARY_HASH_TABLE (dict);
  syx_varsize size = SYX_OBJECT_SIZE (table);
  syx_varsize i;

  for (i=0; i < size; i+=2)
    {
      if (SYX_IS_NIL (SYX_OBJECT_DATA(table)[i]) || SYX_OBJECT_DATA(table)[i] == key)
	{
	  SYX_OBJECT_DATA(table)[i] = key;
	  SYX_OBJECT_DATA(table)[i+1] = value;
	  return;
	}
    }

  printf("Not enough space for dictionary %p\n", SYX_POINTER (dict));
}

inline SyxObject *
syx_block_closure_new (SyxObject *block)
{
  SyxObject *object = syx_object_new (syx_block_closure_class, FALSE, TRUE);
  SYX_BLOCK_CLOSURE_BLOCK(object) = block;
  return object;
}

inline SyxObject *
syx_process_new (SyxObject *context)
{
  SyxObject *object = syx_object_new (syx_process_class, FALSE, TRUE);
  SYX_PROCESS_CONTEXT(object) = context;
  SYX_PROCESS_SUSPENDED(object) = SYX_TRUE;
  syx_scheduler_add_process (object);
  return object;
}

inline SyxObject *
syx_method_context_new (SyxObject *parent, SyxObject *method, SyxObject *receiver, SyxObject *arguments)
{
  SyxObject *object = syx_object_new (syx_method_context_class, FALSE, TRUE);

  SYX_METHOD_CONTEXT_PARENT(object) = parent;
  SYX_METHOD_CONTEXT_METHOD(object) = method;
  SYX_METHOD_CONTEXT_RECEIVER(object) = receiver;
  SYX_METHOD_CONTEXT_ARGUMENTS(object) = arguments;

  SYX_METHOD_CONTEXT_TEMPORARIES(object) = syx_array_new_size (SYX_SMALL_INTEGER(SYX_METHOD_TEMPORARIES_COUNT (method)));
  SYX_METHOD_CONTEXT_IP(object) = syx_small_integer_new (0);
  SYX_METHOD_CONTEXT_SP(object) = syx_small_integer_new (0);
  SYX_METHOD_CONTEXT_STACK(object) = syx_array_new_size (SYX_SMALL_INTEGER(SYX_METHOD_STACK_SIZE (method)));

  return object;
}

inline SyxObject *
syx_block_context_new (SyxObject *parent, SyxObject *block, SyxObject *receiver, SyxObject *arguments,
		       SyxObject *return_context)
{
  SyxObject *object = syx_object_new (syx_block_context_class, FALSE, TRUE);

  SYX_METHOD_CONTEXT_PARENT(object) = parent;
  SYX_METHOD_CONTEXT_METHOD(object) = block;
  SYX_METHOD_CONTEXT_RECEIVER(object) = receiver;
  SYX_METHOD_CONTEXT_ARGUMENTS(object) = arguments;

  SYX_METHOD_CONTEXT_TEMPORARIES(object) = syx_array_new_size (SYX_SMALL_INTEGER(SYX_METHOD_TEMPORARIES_COUNT (block)));
  SYX_METHOD_CONTEXT_IP(object) = syx_small_integer_new (0);
  SYX_METHOD_CONTEXT_STACK(object) = syx_array_new_size (SYX_SMALL_INTEGER(SYX_METHOD_STACK_SIZE (block)));

  SYX_BLOCK_CONTEXT_RETURN_CONTEXT(object) = return_context;

  return object;
}

/* Object */

SyxObject *
syx_object_new (SyxObject *class, syx_bool is_static, syx_bool has_refs)
{
  SyxObject *object = syx_memory_alloc ();
  
  object->class = class;
  object->has_refs = has_refs;
  object->size = SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE (class));
  object->data = object->size ? syx_calloc (object->size, sizeof (SyxObject *)) : NULL;

  return object;
}

SyxObject *
syx_object_new_size (SyxObject *class, syx_bool is_static, syx_bool has_refs, syx_varsize size)
{
  SyxObject *object = syx_memory_alloc ();
  
  object->class = class;
  object->has_refs = has_refs;
  object->size = size;
  object->data = size ? syx_calloc (size, sizeof (SyxObject *)) : NULL;

  return object;
}

SyxObject *
syx_object_new_data (SyxObject *class, syx_bool is_static, syx_bool has_refs, syx_varsize size, syx_pointer data)
{
  SyxObject *object = syx_memory_alloc ();

  object->class = class;
  object->has_refs = has_refs;
  object->size = size;
  object->data = (SyxObject **) data;

  return object;
}

inline void
syx_object_free (SyxObject *object)
{
  syx_free (SYX_OBJECT_DATA (object));
  syx_memory_free (object);
}

syx_bool
syx_class_is_superclass_of (SyxObject *class, SyxObject *subclass)
{
  if (class == subclass)
    return FALSE;

  SyxObject *cur = SYX_CLASS_SUPERCLASS (subclass);

  for (; !SYX_IS_NIL (cur) && cur != class; cur=SYX_CLASS_SUPERCLASS(cur));

  return !SYX_IS_NIL (cur);
}

syx_symbol *
syx_class_get_all_instance_variables (SyxObject *class)
{
  syx_symbol names[256];
  syx_symbol *ret_names = NULL;
  SyxObject *inst_vars;
  syx_varsize i, size, tot_size;

  for (tot_size=0; !SYX_IS_NIL(class); class=SYX_CLASS_SUPERCLASS (class))
    {
      inst_vars = SYX_CLASS_INSTANCE_VARIABLES (class);
      size = SYX_OBJECT_SIZE (inst_vars);

      for (i=size; i > 0; i--)
	{
	  tot_size++;
	  names[255-tot_size+1] = SYX_OBJECT_SYMBOL (SYX_OBJECT_DATA(inst_vars)[i-1]);
	}
    }
  if (tot_size > 0)
    {
      ret_names = syx_calloc (tot_size + 1, sizeof (syx_symbol));
      memcpy (ret_names, &names[255-tot_size+1], tot_size * sizeof (syx_symbol));
    }
  return ret_names;
}

SyxObject *
syx_class_lookup_method (SyxObject *class, syx_symbol selector)
{
  SyxObject *cur;
  SyxObject *method;

  for (cur=class; !SYX_IS_NIL (cur); cur = SYX_CLASS_SUPERCLASS (cur))
    {
      if (SYX_IS_NIL (SYX_CLASS_METHODS (cur)))
	continue;

      method = syx_dictionary_at_symbol (SYX_CLASS_METHODS (cur), selector);
      if (!SYX_IS_NIL (method))
	return method;
    }

  return SYX_NIL;
}
