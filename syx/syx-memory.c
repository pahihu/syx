#include <assert.h>
#include <unistd.h>
#include <glib.h>
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-scheduler.h"

static SyxObject *_syx_memory = NULL;
static SyxObject **_syx_freed_memory = NULL;
static syx_size _syx_memory_size = 10000;
static syx_size _syx_memory_top = 0;
static syx_size _syx_freed_memory_top = 0;
static syx_pointer _syx_empty_memory = NULL;

/*! \page syx_memory Syx Memory
    
    The objects are inserted into a whole space allocated in the heap (syx-memory.c):

    \code
    SyxObject *_syx_memory;
    SyxObject **_syx_freed_memory;
    \endcode

    The idea is to keep a stack containing free memory pointers. Once we free an object, we push on top of the stack of freed locations When we allocate a new SyxObject, we just pop the pointer from this stack.

    Take a look at syx-memory.c for more detailed informations.
    \note the SyxObject::data field, containing SyxObject pointers, is allocated outside this memory.
*/

void
syx_memory_init (void)
{
  static syx_bool initialized = FALSE;
  if (initialized)
    return;

  _syx_memory = syx_calloc (_syx_memory_size, sizeof (SyxObject));
  _syx_freed_memory = syx_calloc (_syx_memory_size, sizeof (SyxObject *));
  _syx_empty_memory = syx_malloc (getpagesize ());
  initialized = TRUE;
}

syx_pointer
syx_memory_alloc (void)
{
  syx_pointer ptr;

  if (_syx_memory_top >= _syx_memory_size - 1 && _syx_freed_memory_top == 0)
    {
      syx_memory_gc ();
      if (_syx_memory_top >= _syx_memory_size - 1 && _syx_freed_memory_top == 0)
	g_error ("object memory heap is full\n");
    }

  if (_syx_freed_memory_top == 0)
    ptr = _syx_memory + _syx_memory_top++;
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

inline syx_size
syx_memory_get_heap_size (void)
{
  return _syx_memory_size;
}



inline void
_syx_memory_gc_mark (SyxObject *object)
{
  syx_varsize i;
  if (!SYX_IS_POINTER (object) || SYX_OBJECT_IS_MARKED(object))
    return;

  SYX_OBJECT_IS_MARKED(object) = TRUE;
  if (SYX_OBJECT_HAS_REFS (object))
    {
      for (i=0; i < SYX_OBJECT_SIZE (object); i++)
	_syx_memory_gc_mark (SYX_OBJECT_DATA(object)[i]);
    }
}

static void
_syx_memory_gc_sweep ()
{
  syx_size i;
  SyxObject *object = _syx_memory;

  for (i=0; i < _syx_memory_size; i++, object++)
    {
      if (SYX_OBJECT_IS_STATIC(object) || SYX_OBJECT_IS_MARKED(object))
	SYX_OBJECT_IS_MARKED(object) = FALSE;
      else
	syx_object_free (object);
    }
}

/*!
  Calls the Syx garbage collector
 */
inline void
syx_memory_gc (void)
{
  puts ("Called garbage collector");
  _syx_memory_gc_mark (syx_globals);
  _syx_memory_gc_sweep ();
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
