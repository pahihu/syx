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

#ifndef SYX_MEMORY_H
#define SYX_MEMORY_H

#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#ifdef HAVE_STRNDUP
  #define _GNU_SOURCE
#endif

#include <stdlib.h>
#include <string.h>
#include "syx-object.h"
#include "syx-types.h"
#include "syx-init.h"

extern SyxObject *syx_memory;
extern syx_int32 _syx_memory_size;

void syx_memory_init (syx_int32 size);
void syx_memory_clear (void);
SyxOop syx_memory_alloc (void);
inline void syx_memory_free (SyxOop oop);
inline syx_int32 syx_memory_get_size (void);
void syx_memory_gc (void);
inline void syx_memory_gc_begin (void);
inline void syx_memory_gc_end (void);

syx_bool syx_memory_save_image (syx_symbol path);
syx_bool syx_memory_load_image (syx_symbol path);

inline syx_pointer syx_malloc (syx_int32 size);
inline syx_pointer syx_malloc0 (syx_int32 size);
inline syx_pointer syx_calloc (syx_int32 elements, syx_int32 element_size);
inline syx_pointer syx_realloc (syx_pointer ptr, syx_int32 size);
#define syx_free free
void syx_freev (syx_pointer *ptrv);

#ifndef HAVE_STRNDUP
  inline syx_string strndup (syx_symbol src, syx_size n);
#endif

#endif /* SYX_MEMORY_H */
