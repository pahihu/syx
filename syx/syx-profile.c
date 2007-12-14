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

/*!
  Functions to profile Syx execution
*/

#include "syx-types.h"
#include "syx-profile.h"

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <ctype.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifdef HAVE_SYS_TIME_H
  #include <sys/time.h>
#endif

#ifdef HAVE_WINDOWS_H
  #include <windows.h>
#endif

/* Return current time seconds in nanoseconds */
syx_uint64
syx_nanotime (void)
{
#if defined(WINDOWS) && !defined(WINCE)

  syx_uint64 value;
  GetSystemTimeAsFileTime ((FILETIME *)&value);
  value = (value - (syx_uint64) 116444736000000000) * 100;
  return value;

#elif !defined(WINDOWS) /* WINDOWS */

  struct timeval tv;
  gettimeofday (&tv, NULL);
  /* convert timeval to nanoseconds */
  return ((syx_uint64) tv.tv_sec * SYX_NSEC_PER_SEC) + tv.tv_usec * SYX_NSEC_PER_USEC;

#endif
}

#ifdef SYX_PROFILE

#define SYX_PROFILE_TYPE(name) syx_uint64 _p_ ## name = 0
#define SYX_PROFILE_PRINT(p, s) printf(s ": %lu us\n", _p_ ## p)

SYX_PROFILE_TYPE(load_image);
SYX_PROFILE_TYPE(exec_state_fetch);
SYX_PROFILE_TYPE(block_context);
SYX_PROFILE_TYPE(method_context);
SYX_PROFILE_TYPE(send_message);
SYX_PROFILE_TYPE(perform_message);
SYX_PROFILE_TYPE(dict_access);
SYX_PROFILE_TYPE(fileop);
SYX_PROFILE_TYPE(blocking);
SYX_PROFILE_TYPE(scheduler);

void
syx_profile_print (void)
{
  puts ("--- Profile ---");
  SYX_PROFILE_PRINT(load_image, "Image loading");
  SYX_PROFILE_PRINT(exec_state_fetch, "Execution state fetch");
  SYX_PROFILE_PRINT(method_context, "Method context creation");
  SYX_PROFILE_PRINT(block_context, "Block context creation");
  SYX_PROFILE_PRINT(send_message, "Send message");
  SYX_PROFILE_PRINT(perform_message, "Perform message from ST");
  SYX_PROFILE_PRINT(dict_access, "Dictionary access");
  SYX_PROFILE_PRINT(fileop, "File operations");
  SYX_PROFILE_PRINT(blocking, "Total blocking processes");
  SYX_PROFILE_PRINT(scheduler, "Total scheduler including nested blocking processes");
  printf("Total: %lu us\n", (_p_scheduler ? _p_scheduler : _p_blocking) + _p_load_image);
  puts ("---------------");
}

#else /* SYX_PROFILE */

void
syx_profile_print (void)
{
}

#endif /* SYX_PROFILE */
