#include <assert.h>
#include <unistd.h>
#include <glib.h>
#include "syx-object.h"
#include "syx-memory.h"
#include "syx-scheduler.h"

SyxObject *syx_memory;
static SyxOop *_syx_freed_memory = NULL;
static syx_size _syx_memory_size = 10000;
static syx_size _syx_memory_top = 0;
static syx_size _syx_freed_memory_top = 0;
static syx_pointer _syx_empty_memory = NULL;

// Holds temporary objects that must not be freed during a transaction
static SyxOop _syx_memory_gc_trans[256];
static syx_int8 _syx_memory_gc_trans_top = 0;
static syx_bool _syx_memory_gc_trans_running = FALSE;

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

#define DEBUG_GC

void
syx_memory_init (void)
{
  static syx_bool initialized = FALSE;
  if (initialized)
    return;

  syx_memory = syx_calloc (_syx_memory_size, sizeof (SyxObject));
  _syx_freed_memory = syx_calloc (_syx_memory_size, sizeof (SyxOop));
  _syx_empty_memory = syx_malloc (getpagesize ());

  syx_nil = syx_memory_alloc ();
  syx_true = syx_memory_alloc ();
  syx_false = syx_memory_alloc ();
  initialized = TRUE;
}

SyxOop
syx_memory_alloc (void)
{
  SyxOop oop;

  if (_syx_memory_top >= _syx_memory_size - 1 && _syx_freed_memory_top == 0)
    {
      syx_memory_gc ();
      if (_syx_memory_top >= _syx_memory_size - 1 && _syx_freed_memory_top == 0)
	g_error ("object memory heap is full\n");
    }

  if (_syx_freed_memory_top == 0)
    oop.idx = _syx_memory_top++;
  else
    oop = _syx_freed_memory[--_syx_freed_memory_top];

  /* Prevent the object from being collected */
  if (_syx_memory_gc_trans_running)
    {
      SYX_OBJECT_IS_MARKED(oop) = TRUE;
      _syx_memory_gc_trans[(syx_int32) _syx_memory_gc_trans_top++] = oop;
    }

  return oop;
}

inline void
syx_memory_free (SyxOop oop)
{
  _syx_freed_memory[_syx_freed_memory_top++] = oop;
}


inline syx_size
syx_memory_get_size (void)
{
  return _syx_memory_size;
}

inline SyxOop
SYX_POINTER_TO_OOP (syx_pointer ptr)
{
  SyxOop oop;
  oop.idx = ((syx_nint)ptr - (syx_nint)syx_memory) / sizeof (SyxObject);
  oop.c.type = SYX_TYPE_OBJECT;
  return oop;
}

inline void
_syx_memory_gc_mark (SyxOop object)
{
  syx_varsize i;
  if (!SYX_IS_OBJECT (object) || SYX_OBJECT_IS_MARKED(object))
    return;

  SYX_OBJECT_IS_MARKED(object) = TRUE;

  _syx_memory_gc_mark (SYX_OBJECT(object)->class);

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
  SyxObject *object = syx_memory;
  SyxOop oop;

  for (i=0; i < _syx_memory_size; i++, object++)
    {
      if (object->is_marked)
	object->is_marked = FALSE;
      else
	{
	  oop.idx = i;
	  syx_object_free (oop);
	}
    }
}

/*!
  Calls the Syx garbage collector
 */
inline void
syx_memory_gc (void)
{
#ifdef DEBUG_GC
  syx_size old_top = _syx_freed_memory_top;
  syx_size reclaimed;
#endif

  _syx_memory_gc_mark (syx_globals);
  _syx_memory_gc_sweep ();

#ifdef DEBUG_GC
  reclaimed = _syx_freed_memory_top - old_top;
  printf("GC: reclaimed %ld (%d%%) objects over %d\n", reclaimed, reclaimed * 100 / _syx_memory_size, _syx_memory_size);
#endif
}

/*!
  Begins a garbage collection transaction.
  In this transaction, all objects being allocated must not be freed.
  The transaction can hold up to 255 objects.
*/
inline void
syx_memory_gc_begin (void)
{
  _syx_memory_gc_trans_running = TRUE;
}

/*!
  Release a transaction started with syx_memory_gc_begin
*/
inline void
syx_memory_gc_end (void)
{
  syx_int32 i;

  for (i=0; i < _syx_memory_gc_trans_top; i++)
    SYX_OBJECT_IS_MARKED(_syx_memory_gc_trans[i]) = FALSE;

  _syx_memory_gc_trans_top = 0;
  _syx_memory_gc_trans_running = FALSE;
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
