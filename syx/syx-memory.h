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

//! Obtain a SyxOop from the effective memory pointer
inline SyxOop SYX_POINTER_TO_OOP (syx_pointer ptr);

//! Get the effective memory address of a SyxOop
#define SYX_OOP_TO_POINTER(oop) (syx_memory + ((oop).idx))

void syx_memory_init (syx_varsize size);
void syx_memory_clear (void);
SyxOop syx_memory_alloc (void);
inline void syx_memory_free (SyxOop oop);
inline syx_varsize syx_memory_get_size (void);
void syx_memory_gc (void);
inline void syx_memory_gc_begin (void);
inline void syx_memory_gc_end (void);

syx_bool syx_memory_save_image (syx_symbol path);
syx_bool syx_memory_load_image (syx_symbol path);

inline syx_pointer syx_malloc (syx_varsize size);
inline syx_pointer syx_malloc0 (syx_varsize size);
inline syx_pointer syx_calloc (syx_varsize elements, syx_varsize element_size);
inline syx_pointer syx_realloc (syx_pointer ptr, syx_varsize size);
#define syx_free free
void syx_freev (syx_pointer *ptrv);

#ifndef HAVE_STRNDUP
  inline syx_string strndup (syx_string src, syx_size n);
#endif

#ifndef HAVE_MEMDUP
  inline syx_pointer memdup (syx_pointer src, syx_size n);
#endif

#endif /* SYX_MEMORY_H */
