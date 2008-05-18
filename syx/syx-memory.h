/* 
   Copyright (c) 2007-2008 Luca Bruno

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

#include "syx-platform.h"
#include "syx-object.h"
#include "syx-init.h"

SYX_BEGIN_DECLS

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

/*! Frees the memory of a SyxOop and saves it to be reused for the next syx_memory_alloc */
INLINE void
syx_memory_free (SyxOop oop)
{
  memset (SYX_OBJECT(oop), '\0', sizeof (SyxObject));
  _syx_freed_memory[_syx_freed_memory_top++] = oop;
}


/*! Returns the size of the memory */
INLINE syx_int32
syx_memory_get_size (void)
{
  return _syx_memory_size;
}

/*!
  Begins a garbage collection transaction.

  In this transaction, all objects being allocated must not be freed because marked.
  The transaction can hold up to 256 objects.
*/
INLINE void
syx_memory_gc_begin (void)
{
  _syx_memory_gc_trans_running++;
}

/*! Release a transaction started with syx_memory_gc_begin and unmark all objects in the transaction */
EXPORT void syx_memory_gc_end (void);

SYX_END_DECLS

#endif /* SYX_MEMORY_H */
