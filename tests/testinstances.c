#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxInstance *obj;
  SyxInstance *instobj;
  GPtrArray *indexed;
  GTimer *timer;
  static gint integers[] = {1, 5, 2, 45};

  syx_init ("..");
  syx_build_basic ();
  timer = g_timer_new ();

  g_timer_start (timer);

  obj = syx_character_new ('c');
  g_assert (SYX_CHARACTER(obj)->value == 'c');

  obj = syx_symbol_new ("symbol");
  g_assert (!g_strcasecmp (SYX_SYMBOL(obj)->string, "symbol"));

  // Now test basic inheritance between classes and metaclasses
  instobj = syx_globals_lookup ("Signal");
  obj = syx_class_get_superclass (SYX_CLASS (instobj));
  g_assert (!g_strcasecmp (syx_string_fetch (syx_instance_get_variable (obj, "name")), "Object"));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (obj == syx_nil);

  obj = syx_instance_get_class (instobj);
  g_assert (!g_strcasecmp (SYX_CLASS_NAME (obj), "Signal class"));
  g_assert (syx_instance_get_class (obj) == syx_globals_lookup ("Metaclass"));
  g_assert (syx_instance_get_class (syx_instance_get_class (syx_instance_get_class (obj))) == syx_globals_lookup ("Metaclass"));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (!g_strcasecmp (syx_string_fetch (syx_instance_get_variable (obj, "name")), "Object class"));
  g_assert (obj == syx_instance_get_class (syx_class_get_superclass (SYX_CLASS (instobj))));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (obj == syx_globals_lookup ("Class"));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (obj == syx_globals_lookup ("Behavior"));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (obj == syx_globals_lookup ("Object"));
  obj = syx_class_get_superclass (SYX_CLASS (obj));
  g_assert (obj == syx_nil);

  obj = syx_string_new ("string");
  g_assert (!g_strcasecmp (syx_string_fetch (obj), "string"));

  indexed = syx_integers_from_array ((guint8 *)integers, sizeof (integers), sizeof (gint));
  g_assert (SYX_SMALL_INTEGER(indexed->pdata[1])->value == 5);

  g_assert (SYX_OBJECT(syx_metaclass_class)->type == SYX_OBJECT_TYPE_CLASS);
  g_assert (syx_metaclass_class->factory_type == SYX_OBJECT_TYPE_CLASS);
  g_assert (syx_small_integer_class->factory_type == SYX_OBJECT_TYPE_SMALL_INTEGER);
  g_assert (syx_character_class->factory_type == SYX_OBJECT_TYPE_CHARACTER);
  g_assert (syx_symbol_class->factory_type == SYX_OBJECT_TYPE_SYMBOL);
  g_assert (syx_string_class->factory_type == SYX_OBJECT_TYPE_COLLECTION);
  g_assert (syx_array_class->factory_type == SYX_OBJECT_TYPE_COLLECTION);
  g_assert (syx_method_context_class->factory_type == SYX_OBJECT_TYPE_METHOD_CONTEXT);
  g_assert (syx_block_context_class->factory_type == SYX_OBJECT_TYPE_BLOCK_CONTEXT);

  obj = syx_class_create_instance (syx_method_context_class);
  g_assert (SYX_OBJECT(obj)->type == SYX_OBJECT_TYPE_METHOD_CONTEXT);
  obj = syx_class_create_instance (syx_block_context_class);
  g_assert (SYX_OBJECT(obj)->type == SYX_OBJECT_TYPE_BLOCK_CONTEXT);

  g_timer_stop (timer);

  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);

  return 0;
}
