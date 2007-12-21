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
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#include "../syx/syx.h"

int SYX_CDECL
main (int argc, char *argv[])
{
  syx_uint64 start, end;
  syx_bool saved, loaded;
  syx_init (0, NULL, "..");

  puts ("- Test saving image");
  start = syx_nanotime ();
  syx_build_basic ();
  saved = syx_memory_save_image ("test.sim");
  assert (saved == TRUE);
  end = syx_nanotime ();
  printf ("Time elapsed: %ld nanoseconds\n\n", end - start);

  puts ("- Test loading image");
  start = syx_nanotime ();
  loaded = syx_memory_load_image ("test.sim");
  assert (loaded == TRUE);
  end = syx_nanotime ();
  printf ("Time elapsed: %ld nanoseconds\n\n", end - start);

  syx_quit ();

  return 0;
}
