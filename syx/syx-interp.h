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

#ifndef SYX_INTERP_H
#define SYX_INTERP_H

#include "syx-object.h"
#include "syx-types.h"
#include "syx-scheduler.h"
#include "syx-init.h"

SYX_BEGIN_DECLS

#define SYX_INTERP_STATE_NEW {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0}, 0}

/*
  Remember SyxOop has the same size of a pointer.
  All the pointers and native ints, in the image will be transformed to an index, to be cross-platform compatible.
  When reading the image, the indexes will be transformed back into pointers.
*/
typedef struct SyxInterpFrame SyxInterpFrame;
struct SyxInterpFrame
{
  SyxOop this_context;
  SyxOop detached_frame;
  SyxInterpFrame *parent_frame;
  SyxInterpFrame *outer_frame;
  SyxInterpFrame *stack_return_frame;
  SyxOop method;
  SyxOop closure;
  syx_nint next_instruction;
  SyxOop *stack;
  SyxOop receiver;
  SyxOop local; /* used to point to arguments */
};

typedef struct SyxInterpState SyxInterpState;
struct SyxInterpState
{
  SyxOop process;
  SyxInterpFrame *frame;
  SyxOop *arguments;
  SyxOop *temporaries;
  SyxOop *method_literals;
  syx_uint16 *method_bytecodes;
  syx_int32 method_bytecodes_count;
  syx_int32 byteslice;
  syx_int32 message_arguments_count;
  SyxOop message_arguments[0xFF];
  SyxOop message_receiver;
};


EXPORT SyxOop syx_interp_frame_to_context (SyxInterpFrame *frame);


/* Primitives */

/*! Back to the interpreter and push object into the stack */
#define SYX_PRIM_RETURN(object)                                         \
  syx_interp_stack_push (object);                                       \
  return TRUE

/*! Same as SYX_PRIM_RETURN but the process yield the control */
#define SYX_PRIM_YIELD(object)                   \
  syx_interp_stack_push (object);                \
  return FALSE

/*! Enter the method which contains the primitive call */
#define SYX_PRIM_FAIL                                                   \
  _syx_interp_frame_prepare_new (&_syx_interp_state, method);           \
  return FALSE

/*! Assert the number of minimum number of arguments given. Call SYX_PRIM_FAIL if assert fails */
#define SYX_PRIM_ARGS(count)                                   \
  if (count > _syx_interp_state.message_arguments_count)       \
    {                                                          \
      SYX_PRIM_FAIL;                                           \
    }

/*! The number of primitives */
#define SYX_PRIMITIVES_MAX 111

typedef syx_bool (* SyxPrimitiveFunc) (SyxInterpState *es, SyxOop method);
#define SYX_FUNC_PRIMITIVE(name)                          \
  syx_bool                                                \
  name (SyxInterpState *es, SyxOop method)

typedef struct SyxPrimitiveEntry SyxPrimitiveEntry;

/*! Used for keeping primitive informations into a static table to be used by
  the interpreter for primitive class */
struct SyxPrimitiveEntry {
  syx_symbol name;
  SyxPrimitiveFunc func;
};

extern EXPORT SyxPrimitiveEntry _syx_primitive_entries[SYX_PRIMITIVES_MAX];

/*! Returns the entry of a primitive at a given index */
INLINE SyxPrimitiveEntry *
syx_primitive_get_entry (syx_int32 index)
{
  if (index < SYX_PRIMITIVES_MAX)
    return &_syx_primitive_entries[index];

  return NULL;
}

/*! Returns the index of a primitive having a specific name */
EXPORT syx_int32 syx_primitive_get_index (syx_symbol name);

/* Interpreter */

EXPORT SyxInterpState _syx_interp_state;

typedef syx_bool (* SyxInterpreterFunc) (syx_uint16 argument);
#define SYX_FUNC_INTERPRETER(name)        \
  syx_bool                                \
  name (syx_uint16 argument)

EXPORT void syx_interp_init (void);
EXPORT void syx_interp_quit (void);

/*! Push an object into the stack */
#define syx_interp_stack_push(oop) (*(_syx_interp_state.frame->stack++) = (oop))

/*! Pop an object from the stack */
#define syx_interp_stack_pop() (*(--_syx_interp_state.frame->stack))

/*! Peek the last object pushed into the stack */
#define syx_interp_stack_peek() (*(_syx_interp_state.frame->stack-1))

EXPORT syx_bool syx_interp_swap_context (SyxOop process, SyxOop context);
EXPORT syx_bool syx_interp_enter_context (SyxOop process, SyxOop context);
EXPORT syx_bool syx_interp_leave_and_answer (SyxOop return_object, syx_bool use_stack_return);


/*!
  Calls a primitive.

  \param primitive the primitive index
  \param method the method in which the primitive is defined
*/
INLINE syx_bool
syx_interp_call_primitive (syx_int16 primitive, SyxOop method)
{
  SyxPrimitiveEntry *prim_entry;
  syx_bool result;

  /* yield */
  if (primitive == 0)
    {
      #ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Yield\n");
      #endif
      syx_interp_stack_push (_syx_interp_state.message_receiver);
      return FALSE;
    }

  prim_entry = syx_primitive_get_entry (primitive);
  result = prim_entry->func (&_syx_interp_state, method);
  return result;
}

/* Process execution */

EXPORT void syx_process_execute_scheduled (SyxOop process);
EXPORT void syx_process_execute_blocking (SyxOop process);

/* Interpreter functions */

EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_instance);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_argument);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_temporary);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_literal);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_constant);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_binding_variable);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_array);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_push_block_closure);

EXPORT SYX_FUNC_INTERPRETER (syx_interp_assign_instance);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_assign_temporary);

EXPORT SYX_FUNC_INTERPRETER (syx_interp_mark_arguments);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_send_message);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_send_super);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_send_unary);
EXPORT SYX_FUNC_INTERPRETER (syx_interp_send_binary);

EXPORT SYX_FUNC_INTERPRETER (syx_interp_do_special);

SYX_END_DECLS

#endif /* SYX_INTERP_H */
