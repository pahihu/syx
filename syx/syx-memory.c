/* 
   Copyright (c) 2007-2008 Luca Bruno

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

typedef enum
{
  SYX_MEMORY_TYPE_IMMEDIATE,
  SYX_MEMORY_TYPE_OBJECT,
  SYX_MEMORY_TYPE_FRAME_POINTER,

  SYX_MEMORY_TYPE_NORMAL,
  SYX_MEMORY_TYPE_LARGE_INTEGER,
  
  SYX_MEMORY_TYPE_BOF, /* Beginning of frame */
  SYX_MEMORY_TYPE_EOS  /* End of stack */
} SyxMemoryType;

typedef struct SyxMemoryLazyPointer SyxMemoryLazyPointer;
struct SyxMemoryLazyPointer
{
  SyxOop stack;
  syx_int32 offset;
  SyxOop *entry;
};

/* Lazy pointers to be fixed once the image is loaded */
static SyxMemoryLazyPointer *_syx_memory_lazy_pointers = NULL;
static syx_int32 _syx_memory_lazy_pointers_top = 0;

/* Holds temporary objects that must not be freed during a transaction */
SyxOop _syx_memory_gc_trans[0x100];
syx_int32 _syx_memory_gc_trans_top = 0;
syx_int32 _syx_memory_gc_trans_running = 0;

void _syx_interp_save_process_state (SyxInterpState *state);
static syx_bool _syx_memory_read_process_stack (SyxOop *oop, FILE *image);
static syx_bool _syx_memory_read (SyxOop *oops, syx_bool mark_type, syx_varsize n, FILE *image);

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
          context = syx_send_unary_message (SYX_POINTER_CAST_OOP (object), "finalize");
          syx_interp_enter_context (process, context);
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
  SyxInterpFrame *frame;

  if (!SYX_IS_OBJECT (object) || SYX_OBJECT_IS_MARKED(object) || SYX_IS_NIL(syx_object_get_class (object)))
    return;

  SYX_OBJECT_IS_MARKED(object) = TRUE;

  _syx_memory_gc_mark (SYX_OBJECT(object)->klass);

  for (i=0; i < syx_object_vars_size (object); i++)
    _syx_memory_gc_mark (SYX_OBJECT_VARS(object)[i]);

  if (SYX_OOP_EQ (syx_object_get_class (object), syx_process_class))
    {
      frame = SYX_OOP_CAST_POINTER (SYX_PROCESS_FRAME_POINTER (object));
      while (frame)
        {
          if (!SYX_IS_NIL (frame->detached_frame))
            _syx_memory_gc_mark (frame->detached_frame);
          frame = frame->parent_frame;
        }
    }
  if (SYX_OBJECT_HAS_REFS (object))
    {
      for (i=0; i < SYX_OBJECT_DATA_SIZE (object); i++)
        _syx_memory_gc_mark (SYX_OBJECT_DATA(object)[i]);
    }
}

/* Walk trough the memory and collect unmarked objects */
static void
_syx_memory_gc_sweep ()
{
  SyxObject *object;

  /* skip constants */
  syx_memory[0].is_marked = FALSE;
  syx_memory[1].is_marked = FALSE;
  syx_memory[2].is_marked = FALSE;

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
          if (mark_type)
            fputc (SYX_MEMORY_TYPE_OBJECT, image);

          idx = SYX_MEMORY_INDEX_OF (oop);
          idx = SYX_COMPAT_SWAP_32 (idx);
          fwrite (&idx, sizeof (syx_int32), 1, image);
        }
      else
        {
          if (mark_type)
            fputc (SYX_MEMORY_TYPE_IMMEDIATE, image);

          idx = (syx_int32)oop;
          idx = SYX_COMPAT_SWAP_32 (idx);
          fwrite (&idx, sizeof (syx_int32), 1, image);
        }
    }
}


/* Write the variables of a Process or of a Context, fixing the frame pointer to match a valid index
   in the stack */
static void
_syx_memory_write_vars_with_fp (SyxObject *object, SyxVariables stack_var, SyxVariables fp_var, FILE *image)
{
  SyxInterpFrame *frame = SYX_OOP_CAST_POINTER (object->vars[fp_var]);
  SyxOop stack;
  syx_int32 offset;

  if (!SYX_IS_NIL (frame->detached_frame))
    {
      stack = frame->detached_frame;
      offset = 0;
    }
  else
    {
      stack = object->vars[stack_var];
      offset = SYX_COMPAT_SWAP_32 (SYX_POINTERS_OFFSET (frame, SYX_OBJECT_DATA (stack)));
    }

  /* Write all variables before FRAME_POINTER */
  _syx_memory_write (object->vars, TRUE, fp_var, image);
  /* Now specify our own type for frame pointers */
  fputc (SYX_MEMORY_TYPE_FRAME_POINTER, image);
  /* We have to store the stack OOP in order to point to the right stack when loading back the image */
  _syx_memory_write (&stack, FALSE, 1, image);
  fwrite (&offset, sizeof (syx_int32), 1, image);
  /* Let's store the remaining variables */
  _syx_memory_write (object->vars + fp_var + 1, TRUE,
                     syx_object_vars_size ((SyxOop)object) - fp_var - 1, image);
}

/* Dump the header of the object with variables */
static void
_syx_memory_write_object_with_vars (SyxObject *object, FILE *image)
{
  syx_int32 data;

  _syx_memory_write ((SyxOop *)&object, FALSE, 1, image);
  _syx_memory_write (&object->klass, FALSE, 1, image);
  fputc (object->has_refs, image);
  fputc (object->is_constant, image);

  data = syx_object_vars_size ((SyxOop)object);
  data = SYX_COMPAT_SWAP_32(data);
  fwrite (&data, sizeof (syx_int32), 1, image);

  /* store instance variables, keep an eye on special cases */
  if ((SYX_OOP_EQ (object->klass, syx_block_context_class) ||
       SYX_OOP_EQ (object->klass, syx_method_context_class))
      && !SYX_IS_NIL (object->vars[SYX_VARS_CONTEXT_PART_STACK]))
    _syx_memory_write_vars_with_fp (object, SYX_VARS_CONTEXT_PART_STACK, SYX_VARS_CONTEXT_PART_FRAME_POINTER, image);
  else if (SYX_OOP_EQ (object->klass, syx_process_class)
           && !SYX_IS_NIL (object->vars[SYX_VARS_PROCESS_STACK]))
    _syx_memory_write_vars_with_fp (object, SYX_VARS_PROCESS_STACK, SYX_VARS_PROCESS_FRAME_POINTER, image);
  else
    _syx_memory_write (object->vars, TRUE, SYX_COMPAT_SWAP_32(data), image);
}

/* Writes a single entry of the frame that points to another frame */
static void
_syx_memory_write_lazy_pointer (SyxObject *process, SyxInterpFrame *frame, FILE *image)
{
  SyxOop stack;
  syx_int32 offset;
  if (!process || !frame)
    stack = syx_nil;
  else if (!SYX_IS_NIL (frame->detached_frame))
    stack = frame->detached_frame;
  else
    stack = process->vars[SYX_VARS_PROCESS_STACK];

  _syx_memory_write (&stack, FALSE, 1, image);
  offset = SYX_COMPAT_SWAP_32 (SYX_POINTERS_OFFSET (frame, SYX_OBJECT_DATA (stack)));

  fwrite (&offset, sizeof (syx_int32), 1, image);
}

/* Dump a single frame */
static void
_syx_memory_write_frame (SyxObject *process, SyxInterpFrame *frame, SyxInterpFrame *upper_frame, FILE *image)
{
  syx_int32 data;
  SyxInterpFrame *bottom_frame;

  if (!process)
    bottom_frame = NULL;
  else
    bottom_frame = (SyxInterpFrame *)SYX_OBJECT_DATA (process->vars[SYX_VARS_PROCESS_STACK]);

  _syx_memory_write (&frame->this_context, FALSE, 1, image);
  _syx_memory_write (&frame->detached_frame, FALSE, 1, image);
  _syx_memory_write_lazy_pointer (process, frame->parent_frame, image);
  _syx_memory_write_lazy_pointer (process, frame->outer_frame, image);
  _syx_memory_write_lazy_pointer (process, frame->stack_return_frame, image);
  _syx_memory_write (&frame->method, FALSE, 1, image);
  _syx_memory_write (&frame->closure, FALSE, 1, image);
  /* this is not a SmallInteger */
  data = SYX_COMPAT_SWAP_32 (frame->next_instruction);
  fwrite (&data, sizeof (syx_int32), 1, image);
  /* the stack pointer should point inside the process stack itself */
  if (process)
    _syx_memory_write (&process->vars[SYX_VARS_PROCESS_STACK], FALSE, 1, image);
  else
    {
      data = SYX_COMPAT_SWAP_32 (0);
      fwrite (&data, sizeof (syx_int32), 1, image);
    }
  data = SYX_COMPAT_SWAP_32 (SYX_POINTERS_OFFSET (frame->stack, bottom_frame));

  fwrite (&data, sizeof (syx_int32), 1, image);
  _syx_memory_write (&frame->receiver, TRUE, 1, image);
  /* Store arguments, temporaries and local stack.
     Only copy arguments and temporaries for detached frames without following the stack pointer */
  if (SYX_IS_NIL (frame->detached_frame))
    {
      /* if no upper_frame is given, this frame is the top most frame of the process stack */
      if (!upper_frame)
        data = SYX_POINTERS_OFFSET (frame->stack, &frame->local);
      else
        data = SYX_POINTERS_OFFSET (upper_frame, &frame->local);
    }
  else
    data = SYX_OBJECT_DATA_SIZE (frame->detached_frame) - SYX_POINTERS_OFFSET (&frame->local, frame);
  data = SYX_COMPAT_SWAP_32 (data);
  fwrite (&data, sizeof (syx_int32), 1, image);
  _syx_memory_write (&frame->local, TRUE, SYX_COMPAT_SWAP_32 (data), image);
}

/* Dump the whole stack of the process.
   This will also dump relative objects containing stack, like block closure outerFrames. */
static void
_syx_memory_write_process_stack (SyxObject *process, FILE *image)
{
  syx_int32 data;
  SyxObject *stack = SYX_OBJECT (process->vars[SYX_VARS_PROCESS_STACK]);
  SyxInterpFrame *bottom_frame = (SyxInterpFrame *)stack->data;
  SyxInterpFrame *frame = SYX_OOP_CAST_POINTER (process->vars[SYX_VARS_PROCESS_FRAME_POINTER]);
  SyxInterpFrame *upper_frame = NULL;

  if (SYX_IS_NIL (SYX_POINTER_CAST_OOP (stack)))
    return;

  _syx_memory_write_object_with_vars (stack, image);

  /* store data size */
  data = SYX_COMPAT_SWAP_32 (stack->data_size);
  fwrite (&data, sizeof (syx_varsize), 1, image);
  /* We have to do things in reverse order because the stack is such a reverse single linked list,
     each frame connected by parent frames */
  while (frame)
    {
      /* We store detached frames later */
      if (!SYX_IS_NIL (frame->detached_frame))
        {
          frame = frame->parent_frame;
          continue;
        }

      /* Store the index of this frame */
      fputc (SYX_MEMORY_TYPE_BOF, image);
      data = SYX_COMPAT_SWAP_32 (SYX_POINTERS_OFFSET (frame, bottom_frame));
      fwrite (&data, sizeof (syx_varsize), 1, image);
      _syx_memory_write_frame (process, frame, NULL, image);
      upper_frame = frame;
      frame = frame->parent_frame;
    }
  fputc (SYX_MEMORY_TYPE_EOS, image);
  stack->is_marked = TRUE;

  /* Let's store all detached frames until they have a reference to this process */
  frame = SYX_OOP_CAST_POINTER (process->vars[SYX_VARS_PROCESS_FRAME_POINTER]);
  while (frame)
    {
      stack = SYX_OBJECT (frame->detached_frame);
      /* Also check if the stack has been collected */
      if (SYX_IS_NIL (frame->detached_frame))
        {
          frame = frame->parent_frame;
          continue;
        }

      _syx_memory_write_object_with_vars (stack, image);

      data = SYX_COMPAT_SWAP_32 (stack->data_size);
      fwrite (&data, sizeof (syx_varsize), 1, image);    
      /* Store the index of this frame */
      fputc (SYX_MEMORY_TYPE_BOF, image);
      data = SYX_COMPAT_SWAP_32 (0);
      fwrite (&data, sizeof (syx_varsize), 1, image);
      _syx_memory_write_frame (process, frame, NULL, image);
      fputc (SYX_MEMORY_TYPE_EOS, image);

      stack->is_marked = TRUE;
      frame = frame->parent_frame;
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
  syx_int32 data = 0;
  SyxObject *stack;
  SyxOop process;

  if (!path)
    path = SYX_OBJECT_SYMBOL (syx_globals_at ("ImageFileName"));

  if (!path)
    return FALSE;

  image = fopen (path, "wb");
  if (!image)
    return FALSE;

  syx_memory_gc ();

  /* save the state of the current process, if any */
  _syx_interp_save_process_state (&_syx_interp_state);

  data = SYX_COMPAT_SWAP_32 (_syx_memory_size);
  fwrite (&data, sizeof (syx_int32), 1, image);
  data = SYX_COMPAT_SWAP_32 (_syx_freed_memory_top);
  fwrite (&data, sizeof (syx_int32), 1, image);
  _syx_memory_write (_syx_freed_memory, FALSE, _syx_freed_memory_top, image);

  _syx_scheduler_save (image);

  _syx_memory_write (&syx_globals, FALSE, 1, image);
  _syx_memory_write (&syx_symbols, FALSE, 1, image);

  /* First store the processes */
  process = syx_processor_first_process;
  while (!SYX_IS_NIL (process))
    {
      _syx_memory_write_process_stack (SYX_OBJECT (process), image);
      process = SYX_PROCESS_NEXT (process);
    }

  for (object=syx_memory; object <= SYX_MEMORY_TOP; object++)
    {
      /* the mark check is not related to the GC but means the object has been already written */
      if (SYX_IS_NIL (object->klass) || object->is_marked)
        continue;

      _syx_memory_write_object_with_vars (object, image);

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
                     for systems that don't support GMP */

                  syx_int32 offset = 0;
                  syx_nint start, end;
                  /* specify that's a large integer */
                  fputc (SYX_MEMORY_TYPE_LARGE_INTEGER, image);
                  /* make space to hold the offset */
                  fwrite (&offset, sizeof (syx_int32), 1, image);
                  start = ftell (image);
                  mpz_out_raw (image, SYX_OBJECT_LARGE_INTEGER ((SyxOop)object));
                  end = ftell (image);
                  offset = end - start;
                  /* go back to the offset */
                  fseek (image, - offset - sizeof (syx_int32), SEEK_CUR);
                  /* now write the length of the data written by mpz_out_raw () */
                  data = SYX_COMPAT_SWAP_32 (offset);
                  fwrite (&data, sizeof (syx_int32), 1, image);
                  /* return again to continue normal writing */
                  fseek (image, offset, SEEK_CUR);
                }
              else
#endif /* HAVE_LIBGMP */
                {
                  /* it's not a large integer */
                  fputc (SYX_MEMORY_TYPE_NORMAL, image);
                  fwrite (object->data, sizeof (syx_int8), object->data_size, image);
                }
            }
        }

      /* Check for block closures that are not attached to any process */
      if (SYX_OOP_EQ (object->klass, syx_block_closure_class))
        {
          stack = SYX_OBJECT (object->vars[SYX_VARS_BLOCK_CLOSURE_OUTER_FRAME]);
          /* Check if the stack has been collected or written to the image */
          if (SYX_IS_NIL (SYX_POINTER_CAST_OOP (stack)) || stack->is_marked)
            continue;

          _syx_memory_write_object_with_vars (stack, image);

          data = SYX_COMPAT_SWAP_32 (stack->data_size);
          fwrite (&data, sizeof (syx_varsize), 1, image);
          /* Store the index of this frame */
          fputc (SYX_MEMORY_TYPE_BOF, image);
          data = SYX_COMPAT_SWAP_32 (0);
          fwrite (&data, sizeof (syx_varsize), 1, image);
          /* Outer frames have only one frame */
          _syx_memory_write_frame (NULL, (SyxInterpFrame *)stack->data, NULL, image);
          fputc (SYX_MEMORY_TYPE_EOS, image);
          
          stack->is_marked = TRUE;
        }
    }

  fclose (image);

  /* be sure all objects are unmarked */
  for (object=syx_memory; object <= SYX_MEMORY_TOP; object++)
    object->is_marked = FALSE;

  return TRUE;
}

static void
_syx_memory_read_lazy_pointer (SyxOop *entry, FILE *image)
{
  SyxMemoryLazyPointer *lazy;
  syx_int32 idx;
  _syx_memory_lazy_pointers = syx_realloc (_syx_memory_lazy_pointers,
                                           ++_syx_memory_lazy_pointers_top * sizeof (SyxMemoryLazyPointer));
  lazy = &_syx_memory_lazy_pointers[_syx_memory_lazy_pointers_top - 1];
  
  /* Store the stack oop */
  fread(&idx, sizeof (syx_int32), 1, image);
  if (!idx)
    lazy->stack = 0;
  else
    lazy->stack = (SyxOop)(syx_memory + idx);
  
  /* Store the offset */
  fread(&idx, sizeof (syx_int32), 1, image);
  idx = SYX_COMPAT_SWAP_32 (idx);
  lazy->offset = idx;

  /* Save the address of the framePointer variable */
  lazy->entry = entry;
}

static syx_bool
_syx_memory_read (SyxOop *oops, syx_bool mark_type, syx_varsize n, FILE *image)
{
  syx_int32 i, idx;
  SyxOop oop;
  SyxMemoryType type = SYX_MEMORY_TYPE_OBJECT;

  for (i=0; i < n; i++)
    {
      oop = 0;
      
      if (mark_type)
        type = fgetc (image);
      
      switch (type)
        {
        case SYX_MEMORY_TYPE_OBJECT:
          if (!fread (&idx, sizeof (syx_int32), 1, image))
            return FALSE;

          idx = SYX_COMPAT_SWAP_32 (idx);
          oop = (SyxOop)(syx_memory + idx);
          break;
        case SYX_MEMORY_TYPE_IMMEDIATE:
          if (!fread (&idx, sizeof (syx_int32), 1, image))
            return FALSE;

          oop = SYX_COMPAT_SWAP_32 (idx);
          break;
        case SYX_MEMORY_TYPE_FRAME_POINTER:
          _syx_memory_read_lazy_pointer (&oops[i], image);
          break;
        case SYX_MEMORY_TYPE_BOF:
          return _syx_memory_read_process_stack (&oops[i], image);
        default:
          return FALSE;
        }

      oops[i] = oop;
    }  

  return TRUE;
}

static syx_bool
_syx_memory_read_process_stack (SyxOop *oop, FILE *image)
{
  syx_varsize i;
  syx_int32 data;
  SyxOop *frame;

  do
    {
      i = 0;
      if (!fread (&data, sizeof (syx_int32), 1, image)) 
        return FALSE;

      frame = oop + SYX_COMPAT_SWAP_32 (data);
      _syx_memory_read (frame+i++, FALSE, 1, image); /* this context */
      _syx_memory_read (frame+i++, FALSE, 1, image); /* detached frame */
      _syx_memory_read_lazy_pointer (frame+i++, image); /* parent frame */
      _syx_memory_read_lazy_pointer (frame+i++, image); /* outer frame */
      _syx_memory_read_lazy_pointer (frame+i++, image); /* stack return frame */
      _syx_memory_read (frame+i++, FALSE, 1, image); /* method */
      _syx_memory_read (frame+i++, FALSE, 1, image); /* closure */
      if (!fread (&data, sizeof (syx_int32), 1, image))
        return FALSE;
      frame[i++] = SYX_COMPAT_SWAP_32 (data); /* next instruction */
      _syx_memory_read_lazy_pointer (frame+i++, image); /* stack pointer */
      _syx_memory_read (frame+i++, TRUE, 1, image); /* receiver */
      if (!fread (&data, sizeof (syx_int32), 1, image))
        return FALSE;
      data = SYX_COMPAT_SWAP_32 (data);
      _syx_memory_read (frame+i, TRUE, data, image); /* arguments, temporaries and local stack */
    } while (fgetc (image) != SYX_MEMORY_TYPE_EOS);

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
  syx_int32 i;
  SyxMemoryLazyPointer *lazy;
  
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
          if (object->data && object->data_size > 0)
            syx_free (object->data);
          
          if (object->has_refs)
            {
              object->data = (SyxOop *) syx_calloc (object->data_size, sizeof (SyxOop));
              _syx_memory_read (object->data, TRUE, object->data_size, image);
            }
          else
            {
              object->data = (SyxOop *) syx_calloc (object->data_size, sizeof (syx_int8));
              if (fgetc (image) == SYX_MEMORY_TYPE_LARGE_INTEGER)
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
  
  /* Fix lazy pointers */
  for (i=0; i < _syx_memory_lazy_pointers_top; i++)
    {
      lazy = &_syx_memory_lazy_pointers[i];
      if (lazy->stack != 0)
        *lazy->entry = SYX_POINTER_CAST_OOP (SYX_OBJECT_DATA (lazy->stack) + lazy->offset);
      else
        *lazy->entry = SYX_POINTER_CAST_OOP (NULL);
    }
  syx_free (_syx_memory_lazy_pointers);

  SYX_END_PROFILE(load_image);

  syx_initialize_system ();

  return TRUE;
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
