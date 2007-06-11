#ifndef SYX_MEMORY_H
#define SYX_MEMORY_H

#include <alloca.h>
#include <stdlib.h>
#include <string.h>
#include "syx-object.h"
#include "syx-types.h"
#include "syx-init.h"

extern SyxObject *syx_memory;

inline SyxOop SYX_POINTER_TO_OOP (syx_pointer ptr);
#define SYX_OOP_TO_POINTER(oop) (syx_memory + ((oop).idx))

void syx_memory_init (syx_varsize size);
void syx_memory_clear (void);
SyxOop syx_memory_alloc (void);
inline void syx_memory_free (SyxOop oop);
inline void syx_memory_free_all (void);
inline syx_varsize syx_memory_get_size (void);
inline void syx_memory_gc (void);
inline void syx_memory_gc_begin (void);
inline void syx_memory_gc_end (void);

syx_bool syx_memory_save_image (syx_symbol path);
syx_bool syx_memory_load_image (syx_symbol path);

inline syx_pointer syx_malloc (syx_varsize size);
inline syx_pointer syx_malloc0 (syx_varsize size);
inline syx_pointer syx_calloc (syx_varsize elements, syx_varsize element_size);
inline syx_pointer syx_realloc (syx_pointer ptr, syx_varsize size);
#define syx_free free
#define syx_alloca alloca
void syx_freev (syx_pointer *ptrv);

#endif /* SYX_MEMORY_H */
