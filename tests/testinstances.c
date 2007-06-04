#include <assert.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxOop obj, instobj;
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();
  timer = g_timer_new ();

  g_timer_start (timer);

  obj = syx_character_new ('c');
  assert (SYX_CHARACTER(obj) == 'c');

  obj = syx_symbol_new ("symbol");
  assert (!strcmp (SYX_OBJECT_SYMBOL(obj), "symbol"));

  // Now test basic inheritance between classes and metaclasses
  instobj = syx_globals_at ("Signal");
  obj = SYX_CLASS_SUPERCLASS (instobj);
  assert (!strcmp (SYX_OBJECT_SYMBOL(SYX_CLASS_NAME(obj)), "Object"));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_IS_NIL (obj));

  obj = syx_object_get_class (instobj);
  assert (SYX_OOP_EQ (syx_object_get_class (obj), syx_globals_at ("Metaclass")));
  assert (SYX_OOP_EQ (syx_object_get_class (syx_object_get_class (syx_object_get_class (obj))), syx_globals_at ("Metaclass")));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_OOP_EQ (obj, syx_object_get_class (SYX_CLASS_SUPERCLASS (instobj))));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_OOP_EQ (obj, syx_globals_at ("Class")));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_OOP_EQ (obj, syx_globals_at ("Behavior")));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_OOP_EQ (obj, syx_globals_at ("Object")));
  obj = SYX_CLASS_SUPERCLASS (obj);
  assert (SYX_IS_NIL (obj));

  obj = syx_string_new ("string");
  assert (!strcmp (SYX_OBJECT_SYMBOL (obj), "string"));

  g_timer_stop (timer);

  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);

  return 0;
}
