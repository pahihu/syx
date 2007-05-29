#ifndef _SYX_MEMORY_H
#define _SYX_MEMORY_H

#include <stdlib.h>
#include <string.h>
#include "syx-object.h"
#include "syx-types.h"

G_BEGIN_DECLS

#define SYX_MEMORY_SIZE 10000
#define syx_free free

typedef struct SyxMemoryLink SyxMemoryLink;

struct SyxMemoryLink
{
  syx_pointer ptr;
  SyxMemoryLink *prev, *next;
};

void syx_memory_init ();
syx_pointer syx_memory_alloc ();
void syx_memory_free (syx_pointer ptr);

inline syx_pointer syx_malloc (syx_size size);
inline syx_pointer syx_malloc0 (syx_size size);
inline syx_pointer syx_calloc (syx_size elements, syx_size element_size);
inline syx_pointer syx_realloc (syx_pointer ptr, syx_size size);

G_END_DECLS

#endif /* _SYX_MEMORY_H */
