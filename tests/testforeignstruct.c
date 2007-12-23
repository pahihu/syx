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
#include "../syx/syx.h"

struct _test1
{
  char f1;
  char f2;
  char f3;
  char f4;
  int f5;
  long f6;
} test1;

struct _test2
{
  char f1;
  char f2;
  short int f3;
  short int f4;
  int f5;
  int f6;
  void *f7;
  void *f8;
  char f9;
  int f10;
  char f11;
  void *f12;
  short int f13; 
  void *f14;
} test2;

struct _test3
{
  short int f1;
  int f2;
  char f3;
  double f4;
  float f5;
  long f6;
} test3;

union _test4
{
  char f1;
  short int f2;
  int f3;
  long f4;
} test4;

int SYX_CDECL
main (int argc, char *argv[])
{
  SyxOop process, context;
  SyxOop arguments;
  SyxOop structTestClass;
  SyxOop structTest;

  syx_init (0, NULL, "..");
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

  syx_cold_file_in ("stsupport/TestCStruct.st");
  structTestClass = syx_globals_at ("TestCStruct");
  syx_object_initialize (structTestClass);
  structTest = syx_object_new (structTestClass);

  puts ("- Test fields alignment 1");
  arguments = syx_array_new_size (6);
  SYX_OBJECT_DATA(arguments)[0] = syx_small_integer_new ((syx_nint)&test1.f1 - (syx_nint)&test1);
  SYX_OBJECT_DATA(arguments)[1] = syx_small_integer_new ((syx_nint)&test1.f2 - (syx_nint)&test1);
  SYX_OBJECT_DATA(arguments)[2] = syx_small_integer_new ((syx_nint)&test1.f3 - (syx_nint)&test1);
  SYX_OBJECT_DATA(arguments)[3] = syx_small_integer_new ((syx_nint)&test1.f4 - (syx_nint)&test1);
  SYX_OBJECT_DATA(arguments)[4] = syx_small_integer_new ((syx_nint)&test1.f5 - (syx_nint)&test1);
  SYX_OBJECT_DATA(arguments)[5] = syx_small_integer_new ((syx_nint)&test1.f6 - (syx_nint)&test1);
  process = syx_process_new ();
  context = syx_send_message (process, syx_nil,
                              structTest,
                              "testOffsets:from:",
                              2, arguments, syx_symbol_new ("Test1Struct"));
  syx_process_execute_blocking (process);

  puts ("- Test fields alignment 2");
  arguments = syx_array_new_size (14);
  SYX_OBJECT_DATA(arguments)[0] = syx_small_integer_new ((syx_nint)&test2.f1 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[1] = syx_small_integer_new ((syx_nint)&test2.f2 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[2] = syx_small_integer_new ((syx_nint)&test2.f3 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[3] = syx_small_integer_new ((syx_nint)&test2.f4 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[4] = syx_small_integer_new ((syx_nint)&test2.f5 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[5] = syx_small_integer_new ((syx_nint)&test2.f6 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[6] = syx_small_integer_new ((syx_nint)&test2.f7 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[7] = syx_small_integer_new ((syx_nint)&test2.f8 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[8] = syx_small_integer_new ((syx_nint)&test2.f9 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[9] = syx_small_integer_new ((syx_nint)&test2.f10 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[10] = syx_small_integer_new ((syx_nint)&test2.f11 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[11] = syx_small_integer_new ((syx_nint)&test2.f12 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[12] = syx_small_integer_new ((syx_nint)&test2.f13 - (syx_nint)&test2);
  SYX_OBJECT_DATA(arguments)[13] = syx_small_integer_new ((syx_nint)&test2.f14 - (syx_nint)&test2);
  process = syx_process_new ();
  context = syx_send_message (process, syx_nil,
                              structTest,
                              "testOffsets:from:",
                              2, arguments, syx_symbol_new ("Test2Struct"));
  syx_process_execute_blocking (process);

  puts ("- Test fields alignment 3");
  arguments = syx_array_new_size (6);
  SYX_OBJECT_DATA(arguments)[0] = syx_small_integer_new ((syx_nint)&test3.f1 - (syx_nint)&test3);
  SYX_OBJECT_DATA(arguments)[1] = syx_small_integer_new ((syx_nint)&test3.f2 - (syx_nint)&test3);
  SYX_OBJECT_DATA(arguments)[2] = syx_small_integer_new ((syx_nint)&test3.f3 - (syx_nint)&test3);
  SYX_OBJECT_DATA(arguments)[3] = syx_small_integer_new ((syx_nint)&test3.f4 - (syx_nint)&test3);
  SYX_OBJECT_DATA(arguments)[4] = syx_small_integer_new ((syx_nint)&test3.f5 - (syx_nint)&test3);
  SYX_OBJECT_DATA(arguments)[5] = syx_small_integer_new ((syx_nint)&test3.f6 - (syx_nint)&test3);
  process = syx_process_new ();
  context = syx_send_message (process, syx_nil,
                              structTest,
                              "testOffsets:from:",
                              2, arguments, syx_symbol_new ("Test3Struct"));
  syx_process_execute_blocking (process);

  puts ("- Test reading");
  test3.f1 = 240;
  test3.f2 = 7143;
  test3.f3 = 'R';
  test3.f4 = 199.11822;
  test3.f5 = 23.5; /* won't read yet */
  process = syx_process_new ();
  context = syx_send_binary_message (process, syx_nil,
                                     structTest,
                                     "testRead:",
                                     SYX_POINTER_CAST_OOP (&test3));
  syx_process_execute_blocking (process);

  puts ("- Test writing");
  process = syx_process_new ();
  context = syx_send_binary_message (process, syx_nil,
                                     structTest,
                                     "testWrite:",
                                     SYX_POINTER_CAST_OOP (&test3));
  syx_process_execute_blocking (process);
  assert(test3.f1 == 320);
  assert(test3.f2 == 10293);
  assert(test3.f3 == ',');
  assert(test3.f4 == 291.4837);
  /* Double to float conversion
     assert(test3.f5 == 76.119);
  */
  /* won't write longs yet */

  puts ("- Test unions");
  test4.f1 = 'S';
  process = syx_process_new ();
  context = syx_send_binary_message (process, syx_nil,
                                     structTest,
                                     "testUnion:",
                                     SYX_POINTER_CAST_OOP (&test4));
  syx_process_execute_blocking (process);
  assert(test4.f1 == 'T');

  syx_quit ();
  return 0;
}
