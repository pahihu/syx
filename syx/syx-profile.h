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
  Macros to profile Syx sections execution time in microseconds
*/

#include "syx-platform.h"

EXPORT extern syx_uint64 syx_nanotime (void);
EXPORT extern void syx_profile_print (void);

#define SYX_PROFILE_ETYPE(p) EXPORT extern syx_uint64 _p_ ## p

SYX_PROFILE_ETYPE(load_image);
SYX_PROFILE_ETYPE(exec_state_fetch);
SYX_PROFILE_ETYPE(block_context);
SYX_PROFILE_ETYPE(method_context);
SYX_PROFILE_ETYPE(send_message);
SYX_PROFILE_ETYPE(perform_message);
SYX_PROFILE_ETYPE(dict_access);
SYX_PROFILE_ETYPE(fileop);
SYX_PROFILE_ETYPE(blocking);
SYX_PROFILE_ETYPE(scheduler);

#ifdef SYX_PROFILE
#define SYX_START_PROFILE syx_uint64 _p_start = syx_nanotime() / 1000
#else
#define SYX_START_PROFILE
#endif

#ifdef SYX_PROFILE
#define SYX_END_PROFILE(p) _p_ ## p = _p_ ## p + syx_nanotime() / 1000 - _p_start
#else
#define SYX_END_PROFILE(p)
#endif

