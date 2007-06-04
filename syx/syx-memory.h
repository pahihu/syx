#ifndef SYX_MEMORY_H
#define SYX_MEMORY_H

#include <stdlib.h>
#include <string.h>
#include "syx-object.h"
#include "syx-types.h"

extern SyxObject *syx_memory;

inline SyxOop SYX_POINTER_TO_OOP (syx_pointer ptr);
#define SYX_OOP_TO_POINTER(oop) (syx_memory + ((oop).idx))

void syx_memory_init (void);
SyxOop syx_memory_alloc (void);
inline void syx_memory_free (SyxOop oop);
inline syx_size syx_memory_get_size (void);
inline void syx_memory_gc (void);

inline syx_pointer syx_malloc (syx_size size);
inline syx_pointer syx_malloc0 (syx_size size);
inline syx_pointer syx_calloc (syx_size elements, syx_size element_size);
inline syx_pointer syx_realloc (syx_pointer ptr, syx_size size);
#define syx_free free
void syx_freev (syx_pointer *ptrv);

#endif /* SYX_MEMORY_H */
