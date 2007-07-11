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

#include <assert.h>
#include <stdio.h>
#include <sys/time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxOop obj, instobj;
  struct timeval start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");

  gettimeofday (&start, NULL);

  obj = syx_small_integer_new (123);
  assert (SYX_SMALL_INTEGER(obj) == 123);

#ifdef HAVE_LIBGMP
  obj = syx_large_integer_new_integer (0xFFFFFFFF);
  assert (mpz_cmp_si (SYX_OBJECT_LARGE_INTEGER(obj), 0xFFFFFFFF));
#endif

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
  assert (SYX_OOP_EQ (instobj, SYX_METACLASS_INSTANCE_CLASS (obj)));
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

  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n", end.tv_usec - start.tv_usec);

  syx_quit ();

  return 0;
}
