#include <assert.h>
#include <stdio.h>
#include <time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxOop obj, instobj;
  clock_t start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");

  start = clock ();

  obj = syx_small_integer_new (123);
  assert (SYX_SMALL_INTEGER(obj) == 123);

  obj = syx_character_new ('c');
  assert (SYX_CHARACTER(obj) == 'c');

  obj = syx_symbol_new ("symbol");
  assert (!strcmp (SYX_OBJECT_SYMBOL(obj), "symbol"));

  obj = syx_float_new (123.321);
  assert (SYX_OBJECT_FLOAT(obj) == 123.321);

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

  end = clock ();
  printf ("Time elapsed: %f\n", ((double) (start - end)) / CLOCKS_PER_SEC);

  syx_quit ();

  return 0;
}
