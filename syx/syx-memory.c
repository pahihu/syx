#include <unistd.h>
#include "syx-object.h"
#include "syx-memory.h"

G_BEGIN_DECLS

static SyxObject _syx_memory[SYX_MEMORY_SIZE];
static SyxMemoryLink *_syx_freed_memory = NULL;
static syx_int32 _syx_registered_objects = 0;
syx_pointer _empty_memory = NULL;

/* Memory */

void
syx_memory_init (void)
{
  _empty_memory = syx_malloc (getpagesize ());
}

syx_pointer
syx_memory_alloc (void)
{
  syx_pointer ptr;
  SyxMemoryLink *old_link;

  if (_syx_registered_objects == SYX_MEMORY_SIZE - 1)
    g_error ("object memory is full\n");

  if (!_syx_freed_memory)
    ptr = &_syx_memory[_syx_registered_objects++];
  else
    {
      old_link = _syx_freed_memory;
      ptr = old_link->ptr;
      _syx_freed_memory = old_link->prev;

      syx_free (old_link);
      _syx_registered_objects++;
    }

  return ptr;
}

void
syx_memory_free (syx_pointer ptr)
{
  SyxMemoryLink *link;

  link = syx_malloc (sizeof (SyxMemoryLink));
  link->ptr = ptr;
  link->prev = _syx_freed_memory;
  link->next = NULL;
  if (_syx_freed_memory)
    _syx_freed_memory->next = link;

  _syx_freed_memory = link;
  _syx_registered_objects--;
}

inline syx_pointer
syx_malloc (syx_size size)
{
  syx_pointer ptr;

  ptr = malloc (size);
  if (!ptr)
    g_error ("out of memory");

  return ptr;
}

inline syx_pointer
syx_malloc0 (syx_size size)
{
  syx_pointer ptr;

  ptr = malloc (size);
  if (!ptr)
    g_error ("out of memory");

  bzero (ptr, size);
  return ptr;
}

inline syx_pointer
syx_calloc (syx_size elements, syx_size element_size)
{
  syx_pointer ptr;

  ptr = calloc (elements, element_size);
  if (!ptr)
    g_error ("out of memory");

  return ptr;
}

inline syx_pointer
syx_realloc (syx_pointer ptr, syx_size size)
{
  syx_pointer nptr;

  nptr = realloc (ptr, size);
  if (!nptr)
    g_error ("out of memory");

  return nptr;
}

G_END_DECLS
