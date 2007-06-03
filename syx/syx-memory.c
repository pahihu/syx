#include <assert.h>
#include <unistd.h>
#include <glib.h>
#include "syx-object.h"
#include "syx-memory.h"

static SyxObject *_syx_memory = NULL;
static SyxObject **_syx_freed_memory = NULL;
static syx_size _syx_freed_memory_top = 0;
static syx_size _syx_registered_objects = 0;
syx_pointer _syx_empty_memory = NULL;

/*! \page syx_memory Syx Memory
    
    The objects are inserted into a whole space of static memory:

    \code
    static SyxObject **_syx_freed_memory[SYX_MEMORY_SIZE];
    static SyxObject *_syx_memory[SYX_MEMORY_SIZE];
    \endcode

    The idea is to keep a stack containing free memory pointers. Once we free an object, we push on top of the stack the freed location. When we allocate a new object, we just pop from the stack the pointer.

    \note the data field, containing SyxObject pointers, is allocated outside this memory, in the heap.
*/

void
syx_memory_init (void)
{
  static syx_bool initialized = FALSE;
  if (initialized)
    return;

  _syx_memory = syx_calloc (SYX_MEMORY_SIZE, sizeof (SyxObject));
  _syx_freed_memory = syx_calloc (SYX_MEMORY_SIZE, sizeof (SyxObject *));
  _syx_empty_memory = syx_malloc (getpagesize ());
  initialized = TRUE;
}

syx_pointer
syx_memory_alloc (void)
{
  syx_pointer ptr;

  if (_syx_registered_objects == SYX_MEMORY_SIZE - 1)
    g_error ("object memory is full\n");

  if (_syx_freed_memory_top == 0)
    ptr = _syx_memory + _syx_registered_objects++;
  else
    ptr = _syx_freed_memory[--_syx_freed_memory_top];

  return ptr;
}

inline void
syx_memory_free (syx_pointer ptr)
{
  _syx_freed_memory[_syx_freed_memory_top++] = ptr;
}

inline syx_pointer
syx_memory_get_heap (void)
{
  return _syx_memory;
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

void
syx_freev (syx_pointer *ptrv)
{
  syx_pointer *ptrv_p = ptrv;

  while (*ptrv_p)
    {
      syx_free (*ptrv_p);
      ptrv_p++;
    }
  syx_free (ptrv);
}
