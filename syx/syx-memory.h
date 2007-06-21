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
  inline syx_string strndup (syx_string src, syx_size n);
#endif

#endif /* SYX_MEMORY_H */
