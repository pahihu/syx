/* 
   Copyright (c) 2007 Luca Bruno

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

#include "syx-config.h"
#include "syx-memory.h"
#include "syx-object.h"
#include "syx-error.h"
#include "syx-scheduler.h"
#include "syx-utils.h"
#include "syx-interp.h"
#include "syx-profile.h"

#include <assert.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#include <stdio.h>
#include <string.h>

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif

#ifdef SYX_DEBUG_INFO
#define SYX_DEBUG_GC
#endif

syx_int32 _syx_memory_size;
SyxObject *syx_memory;
SyxOop *_syx_freed_memory;
syx_int32 _syx_freed_memory_top;

static syx_bool _syx_memory_initialized = FALSE;

#define SYX_MEMORY_TOP (&syx_memory[_syx_memory_size - 1])

/* Holds temporary objects that must not be freed during a transaction */
SyxOop _syx_memory_gc_trans[0x100];
syx_int32 _syx_memory_gc_trans_top = 0;
syx_int32 _syx_memory_gc_trans_running = 0;

static void _syx_memory_gc_sweep ();

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

/*! Initialize or realloc the memory according to the given size */
void
syx_memory_init (syx_int32 mem_size)
{
  SyxObject *object;

  if (_syx_memory_initialized)
    {
      if (mem_size > _syx_memory_size)
	{
	  syx_realloc (syx_memory, sizeof (SyxObject) * mem_size);
	  syx_realloc (_syx_freed_memory, sizeof (SyxOop) * mem_size);
	}

      return;
    }

  _syx_memory_size = mem_size;

  syx_memory = (SyxObject *) syx_calloc (_syx_memory_size, sizeof (SyxObject));
  _syx_freed_memory = (SyxOop *) syx_calloc (_syx_memory_size, sizeof (SyxOop));

  /* fill freed memory with all memory oops */
  for (_syx_freed_memory_top=0, object=SYX_MEMORY_TOP;
       _syx_freed_memory_top < _syx_memory_size;
       _syx_freed_memory_top++, object--)
    _syx_freed_memory[_syx_freed_memory_top] = (SyxOop) object;
  _syx_memory_gc_trans_running = 0;
  _syx_memory_gc_trans_top = 0;

  _syx_memory_initialized = TRUE;
}

/*! Clears all the allocated memory */
void
syx_memory_clear (void)
{
  SyxObject *object = syx_memory;
  SyxOop context, process;

  if (!_syx_memory_initialized)
    return;

  object = syx_memory;

  /* finalize objects */
  for (object=syx_memory; object <= SYX_MEMORY_TOP; object++)
    {
      if (SYX_IS_NIL (object->klass))
	continue;

      if (SYX_IS_TRUE (SYX_CLASS_FINALIZATION (object->klass)))
	{
	  process = syx_process_new ();
	  context = syx_send_unary_message (process, syx_nil,
					    SYX_POINTER_CAST_OOP (object), "finalize");
	  syx_process_execute_blocking (process);
	}
    }

  /* free memory used by objects */
  for (object=syx_memory; object <= SYX_MEMORY_TOP; object++)
    {
      if (object->vars)
	syx_free (object->vars);
      if (object->data)
	syx_free (object->data);
    }

  syx_free (syx_memory);
  syx_free (_syx_freed_memory);
  _syx_memory_initialized = FALSE;
}

/*! Returns a new SyxOop */
SyxOop
syx_memory_alloc (void)
{
  SyxOop oop;

  if (_syx_freed_memory_top == 0)
    {
      syx_memory_gc ();
      if (_syx_freed_memory_top == 0)
	syx_error ("object memory heap is really full\n");
    }

  oop = _syx_freed_memory[--_syx_freed_memory_top];

  /* Prevent the object from being collected */
  if (_syx_memory_gc_trans_running)
    {
      if (_syx_memory_gc_trans_top == 0x100)
	syx_error ("transactions can hold up to 256 objects\n");

      SYX_OBJECT_IS_MARKED(oop) = TRUE;
      _syx_memory_gc_trans[_syx_memory_gc_trans_top++] = oop;
    }
  else
    SYX_OBJECT_IS_MARKED(oop) = FALSE;

  return oop;
}



INLINE void
_syx_memory_gc_mark (SyxOop object)
{
  syx_varsize i;
  if (!SYX_IS_OBJECT (object) || SYX_OBJECT_IS_MARKED(object) || SYX_IS_NIL(syx_object_get_class (object)))
    return;

  SYX_OBJECT_IS_MARKED(object) = TRUE;

  _syx_memory_gc_mark (SYX_OBJECT(object)->klass);

  for (i=0; i < syx_object_vars_size (object); i++)
    _syx_memory_gc_mark (SYX_OBJECT_VARS(object)[i]);

  if (SYX_OBJECT_HAS_REFS (object))
    {
      for (i=0; i < SYX_OBJECT_DATA_SIZE (object); i++)
	_syx_memory_gc_mark (SYX_OBJECT_DATA(object)[i]);
    }
}


/*! Calls the Syx garbage collector */
void
syx_memory_gc (void)
{
#ifdef SYX_DEBUG_GC
  syx_int32 old_top = _syx_freed_memory_top;
  syx_int32 reclaimed;
#endif

  /* Save the state of transactions.
     syx_object_free can call #finalize methods, so we need another transaction */
  syx_int32 trans_top = _syx_memory_gc_trans_top;
  syx_int32 trans_running = _syx_memory_gc_trans_running;
  SyxOop trans[0x100];
  memcpy (trans, _syx_memory_gc_trans, sizeof (SyxOop) * 0x100);
  _syx_memory_gc_trans_top = 0;
  _syx_memory_gc_trans_running = 0;

  _syx_memory_gc_mark (syx_symbols);
  _syx_memory_gc_mark (syx_globals);
  _syx_memory_gc_sweep ();

#ifdef SYX_DEBUG_GC
  reclaimed = _syx_freed_memory_top - old_top;
  syx_debug ("GC: reclaimed %d (%d%%); available %d; used %d; total %d\n", reclaimed, reclaimed * 100 / _syx_memory_size, _syx_freed_memory_top, _syx_memory_size - _syx_freed_memory_top, _syx_memory_size);
#endif

  /* Restore the normal transaction */
  _syx_memory_gc_trans_top = trans_top;
  _syx_memory_gc_trans_running = trans_running;
  memcpy (_syx_memory_gc_trans, trans, sizeof (SyxOop) * 0x100);
}


static void
_syx_memory_write (SyxOop *oops, syx_bool mark_type, syx_varsize n, FILE *image)
{
  syx_int32 i, idx;
  SyxOop oop;
  for (i=0; i < n; i++)
    {
      oop = oops[i];
      if (SYX_IS_OBJECT (oop))
	{
	  idx = SYX_MEMORY_INDEX_OF(oop);

	  if (mark_type)
	    fputc (1, image);

	  idx = SYX_COMPAT_SWAP_32 (idx);
	  fwrite (&idx, sizeof (syx_int32), 1, image);
	}
      else
	{
	  if (mark_type)
	    fputc (0, image);

	  idx = (syx_int32)oop;
	  idx = SYX_COMPAT_SWAP_32 (idx);
	  fwrite (&idx, sizeof (syx_int32), 1, image);
	}
    }
}


/*!
  Dumps all the memory.

  \param path the file path to put all inside
  \return FALSE if an error occurred
*/
syx_bool
syx_memory_save_image (syx_symbol path)
{
  SyxObject *object;
  FILE *image;
  syx_int32 data;

  if (!path)
    path = SYX_OBJECT_SYMBOL (syx_globals_at ("ImageFileName"));

  if (!path)
    return FALSE;

  image = fopen (path, "wb");
  if (!image)
    return FALSE;

  syx_memory_gc ();

  data = SYX_COMPAT_SWAP_32 (_syx_memory_size);
  fwrite (&data, sizeof (syx_int32), 1, image);
  data = SYX_COMPAT_SWAP_32 (_syx_freed_memory_top);
  fwrite (&data, sizeof (syx_int32), 1, image);
  _syx_memory_write (_syx_freed_memory, FALSE, _syx_freed_memory_top, image);

  _syx_scheduler_save (image);

  _syx_memory_write (&syx_globals, FALSE, 1, image);
  _syx_memory_write (&syx_symbols, FALSE, 1, image);

  for (object=syx_memory; object <= SYX_MEMORY_TOP; object++)
    {
      if (SYX_IS_NIL (object->klass))
	continue;

      _syx_memory_write ((SyxOop *)&object, FALSE, 1, image);
      _syx_memory_write (&object->klass, FALSE, 1, image);
      fputc (object->has_refs, image);
      fputc (object->is_constant, image);

      /* store instance variables */
      data = syx_object_vars_size ((SyxOop)object);
      data = SYX_COMPAT_SWAP_32(data);
      fwrite (&data, sizeof (syx_varsize), 1, image);
      _syx_memory_write (object->vars, TRUE, SYX_COMPAT_SWAP_32(data), image);

      /* store data */
      data = SYX_COMPAT_SWAP_32 (object->data_size);
      fwrite (&data, sizeof (syx_varsize), 1, image);
      if (object->data_size > 0)
	{
	  if (object->has_refs)
	    _syx_memory_write (object->data, TRUE, object->data_size, image);
	  else
	    {
#ifdef HAVE_LIBGMP
	      if (SYX_OBJECT_IS_LARGE_INTEGER ((SyxOop)object))
		{
		  /* This algorithm is used to store large integers.
		     We need to specify how many bytes GMP wrote to the image,
		     for systems that doesn't support GMP */

		  syx_int32 offset = 0;
		  syx_nint start, end;
		  /* specify that's a large integer */
		  fputc (1, image);
		  /* make space to hold the offset */
		  fwrite (&offset, sizeof (syx_int32), 1, image);
		  start = ftell (image);
		  mpz_out_raw (image, SYX_OBJECT_LARGE_INTEGER ((SyxOop)object));
		  end = ftell (image);
		  offset = end - start;
		  /* go back to the offset */
		  fseek (image, - offset - sizeof (syx_int32), SEEK_CUR);
		  data = SYX_COMPAT_SWAP_32 (offset);
		  fwrite (&data, sizeof (syx_int32), 1, image);
		  /* return again to continue normal writing */
		  fseek (image, offset, SEEK_CUR);
		}
	      else
#endif
		{
		  /* it's not a large integer */
		  fputc (0, image);
		  fwrite (object->data, sizeof (syx_int8), object->data_size, image);
		}
	    }
	}
    }

  fclose (image);

  return TRUE;
}



static syx_bool
_syx_memory_read (SyxOop *oops, syx_bool mark_type, syx_varsize n, FILE *image)
{
  syx_int32 i, idx;
  SyxOop oop;
  syx_bool is_pointer = TRUE;

  for (i=0; i < n; i++)
    {
      oop = 0;
      
      if (mark_type)
	is_pointer = fgetc (image);
      
      if (is_pointer)
	{
	  if (!fread (&idx, sizeof (syx_int32), 1, image))
	    return FALSE;

	  idx = SYX_COMPAT_SWAP_32 (idx);
	  oop = (SyxOop)(syx_memory + idx);
	}
      else
	{
	  if (!fread (&idx, sizeof (syx_int32), 1, image))
	    return FALSE;

	  oop = SYX_COMPAT_SWAP_32 (idx);
	}

      oops[i] = oop;
    }  

  return TRUE;
}


/*!
  Loads the memory.

  \param path the file containing the data dumped by syx_memory_save_image
  \return FALSE if an error occurred
*/
syx_bool
syx_memory_load_image (syx_symbol path)
{
  SyxObject *object;
  FILE *image;
  syx_int32 data;
  
  SYX_START_PROFILE;

  if (!path)
    {
      if (SYX_IS_NIL (syx_globals))
	path = syx_get_image_path ();
      else
	path = SYX_OBJECT_SYMBOL (syx_globals_at ("ImageFileName"));
    }

  if (!path)
    return FALSE;

  image = fopen (path, "rb");
  if (!image)
    return FALSE;

  fread (&data, sizeof (syx_int32), 1, image);
  data = SYX_COMPAT_SWAP_32 (data);
  syx_memory_init (data);

  fread (&data, sizeof (syx_int32), 1, image);
  _syx_freed_memory_top = SYX_COMPAT_SWAP_32 (data);
  _syx_memory_read (_syx_freed_memory, FALSE, _syx_freed_memory_top, image);

  _syx_scheduler_load (image);

  _syx_memory_read (&syx_globals, FALSE, 1, image);
  _syx_memory_read (&syx_symbols, FALSE, 1, image);

  while (!feof (image))
    {
      if (!_syx_memory_read ((SyxOop *)&object, FALSE, 1, image))
	break;

      _syx_memory_read (&object->klass, FALSE, 1, image);
      object->has_refs = fgetc (image);
      object->is_constant = fgetc (image);

      /* fetch instance variables */
      fread (&data, sizeof (syx_varsize), 1, image);
      data = SYX_COMPAT_SWAP_32 (data);
      if (object->vars)
	syx_free (object->vars);
      object->vars = (SyxOop *) syx_calloc (data, sizeof (SyxOop));
      _syx_memory_read (object->vars, TRUE, data, image);

      /* fetch data */
      fread (&data, sizeof (syx_varsize), 1, image);
      object->data_size = SYX_COMPAT_SWAP_32 (data);
      if (object->data_size > 0)
	{
	  if (object->data)
	    syx_free (object->data);
	  
	  if (object->has_refs)
	    {
	      object->data = (SyxOop *) syx_calloc (object->data_size, sizeof (SyxOop));
	      _syx_memory_read (object->data, TRUE, object->data_size, image);
	    }
	  else
	    {
	      object->data = (SyxOop *) syx_calloc (object->data_size, sizeof (syx_int8));
	      if (fgetc (image))
		{
		  fread (&data, sizeof (syx_int32), 1, image);
		  data = SYX_COMPAT_SWAP_32 (data);
#ifdef HAVE_LIBGMP
		  mpz_init (SYX_OBJECT_LARGE_INTEGER ((SyxOop)object));
		  mpz_inp_raw (SYX_OBJECT_LARGE_INTEGER ((SyxOop)object), image);
#else
		  /* skip GMP data since we can't handle it */
		  fseek (image, data, SEEK_CUR);
#endif
		}
	      else
		fread (object->data, sizeof (syx_int8), object->data_size, image);
	    }
	}
    }
  
  fclose (image);

  syx_fetch_basic ();
  
  SYX_END_PROFILE(load_image);

  syx_initialize_system ();

  return TRUE;
}

static void
_syx_memory_gc_sweep ()
{
  SyxObject *object;

  /* skip constants */
  for (object=syx_memory+3; object <= SYX_MEMORY_TOP; object++)
    {
      if (SYX_IS_NIL (object->klass))
	continue;

      if (object->is_marked)
	object->is_marked = FALSE;
      else
	syx_object_free ((SyxOop) object);
    }
}


/*! Release a transaction started with syx_memory_gc_begin and unmark all objects in the transaction */
void
syx_memory_gc_end (void)
{
  syx_int32 i;
  if (--_syx_memory_gc_trans_running > 0)
    return;

  for (i=0; i < _syx_memory_gc_trans_top; i++)
    SYX_OBJECT_IS_MARKED(_syx_memory_gc_trans[i]) = FALSE;

  _syx_memory_gc_trans_top = 0;
  _syx_memory_gc_trans_running = 0;
}
