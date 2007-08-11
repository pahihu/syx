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

#include "syx-config.h"

#ifdef HAVE_STRNDUP
  #define _GNU_SOURCE
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-init.h"

#include <stdlib.h>
#include <string.h>

extern EXPORT SyxOop *_syx_freed_memory;
extern EXPORT syx_int32 _syx_freed_memory_top;

extern EXPORT SyxOop _syx_memory_gc_trans[0x100];
extern EXPORT syx_int32 _syx_memory_gc_trans_top;
extern EXPORT syx_int32 _syx_memory_gc_trans_running;

EXPORT void syx_memory_init (syx_int32 size);
EXPORT void syx_memory_clear (void);
EXPORT SyxOop syx_memory_alloc (void);
EXPORT void syx_memory_gc (void);

EXPORT syx_bool syx_memory_save_image (syx_symbol path);
EXPORT syx_bool syx_memory_load_image (syx_symbol path);


//! Frees the memory of a SyxOop and saves it to be reused for the next syx_memory_alloc
INLINE void
syx_memory_free (SyxOop oop)
{
  memset (SYX_OBJECT(oop), '\0', sizeof (SyxObject));
  _syx_freed_memory[_syx_freed_memory_top++] = oop;
}


//! Returns the size of the memory
INLINE syx_int32
syx_memory_get_size (void)
{
  return _syx_memory_size;
}

//! Begins a garbage collection transaction.
/*!
  In this transaction, all objects being allocated must not be freed because marked.
  The transaction can hold up to 256 objects.
*/
INLINE void
syx_memory_gc_begin (void)
{
  _syx_memory_gc_trans_running++;
}

//! Release a transaction started with syx_memory_gc_begin and unmark all objects in the transaction
EXPORT void syx_memory_gc_end (void);

#define syx_free free


INLINE syx_pointer
syx_malloc (syx_int32 size)
{
  syx_pointer ptr;

  ptr = malloc (size);
  if (!ptr)
    syx_error ("out of memory\n");

  return ptr;
}

INLINE syx_pointer
syx_malloc0 (syx_int32 size)
{
  syx_pointer ptr;

  ptr = malloc (size);
  if (!ptr)
    syx_error ("out of memory\n");

  memset (ptr, '\0', size);
  return ptr;
}

INLINE syx_pointer
syx_calloc (syx_int32 elements, syx_int32 element_size)
{
  syx_pointer ptr;

  ptr = calloc (elements, element_size);
  if (!ptr)
    syx_error ("out of memory\n");

  return ptr;
}

INLINE syx_pointer
syx_realloc (syx_pointer ptr, syx_int32 size)
{
  syx_pointer nptr;

  nptr = realloc (ptr, size);
  if (!nptr)
    syx_error ("out of memory\n");

  return nptr;
}

//! Return a new allocated memory which is a copy of the given one
INLINE syx_pointer
syx_memdup (syx_pointer ptr, syx_int32 elements, syx_int32 element_size)
{
  syx_pointer nptr;

  nptr = syx_malloc (element_size * elements);
  memcpy (nptr, ptr, element_size * elements);

  return nptr;
}

#ifndef HAVE_STRNDUP

INLINE syx_string
strndup (syx_symbol src, syx_size n)
{
  syx_string ret = (syx_string) syx_malloc (n + 1);
  memcpy (ret, src, n);
  ret[n] = '\0';
  return ret;
}

#endif /* HAVE_STRNDUP */

#endif /* SYX_MEMORY_H */
