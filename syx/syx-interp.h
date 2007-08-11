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

#ifndef SYX_INTERP_H
#define SYX_INTERP_H

#include "syx-types.h"
#include "syx-object.h"
#include "syx-scheduler.h"

/* Execution state of a Process */

typedef struct SyxExecState SyxExecState;

struct SyxExecState
{
  SyxOop process;
  SyxOop context;
  SyxOop receiver;
  SyxOop *arguments;
  SyxOop *temporaries;
  SyxOop *stack;
  SyxOop *literals;
  syx_uint16 *bytecodes;
  syx_int32 bytecodes_count;
  syx_int32 byteslice;
  syx_int32 ip, sp;

  //! Holds the receiver of a new message
  SyxOop message_receiver;
  //! Holds the arguments of a new message
  SyxOop *message_arguments;
  syx_varsize message_arguments_count;
};

extern EXPORT SyxExecState *_syx_exec_state;

EXPORT SyxExecState *syx_exec_state_new (void);
EXPORT void syx_exec_state_fetch (void);
EXPORT void syx_exec_state_free (void);

//! Save the current execution state
INLINE void
syx_exec_state_save (void)
{
  SyxOop context = SYX_PROCESS_CONTEXT (_syx_exec_state->process);
  if (!SYX_IS_NIL (context))
    {
      SYX_METHOD_CONTEXT_IP(context) = syx_small_integer_new (_syx_exec_state->ip);
      SYX_METHOD_CONTEXT_SP(context) = syx_small_integer_new (_syx_exec_state->sp);
    }
  SYX_PROCESS_CONTEXT(_syx_exec_state->process) = _syx_exec_state->context;
}

/* Primitives */

//! Back to the interpreter and push object into the stack
#define SYX_PRIM_RETURN(object)						\
  syx_interp_stack_push (object);					\
  return TRUE

//! Same as SYX_PRIM_RETURN but the process yield the control
#define SYX_PRIM_YIELD(object)			\
  syx_interp_stack_push (object);		\
  return FALSE

//! Enter the method which contains the primitive call
#define SYX_PRIM_FAIL							\
  syx_memory_gc_begin ();						\
  syx_interp_enter_context (syx_method_context_new (es->context, method, \
						    es->message_receiver, \
						    syx_array_new_ref (es->message_arguments_count, \
								       es->message_arguments))); \
  syx_memory_gc_end ();							\
  return FALSE

//! Assert the number of minimum number of arguments given. Call SYX_PRIM_FAIL if assert fails
#define SYX_PRIM_ARGS(count)				\
  if (count > _syx_exec_state->message_arguments_count)	\
    {							\
      SYX_PRIM_FAIL;					\
    }

//! The number of primitives
#define SYX_PRIMITIVES_MAX 96

typedef syx_bool (* SyxPrimitiveFunc) (SyxExecState *es, SyxOop method);
#define SYX_FUNC_PRIMITIVE(name)					\
  syx_bool						\
  name (SyxExecState *es, SyxOop method)

typedef struct SyxPrimitiveEntry SyxPrimitiveEntry;

struct SyxPrimitiveEntry {
  syx_symbol name;
  SyxPrimitiveFunc func;
};

extern EXPORT SyxPrimitiveEntry _syx_primitive_entries[SYX_PRIMITIVES_MAX];

//! Returns the entry of a primitive at a given index
INLINE SyxPrimitiveEntry *
syx_primitive_get_entry (syx_int32 index)
{
  if (index < SYX_PRIMITIVES_MAX)
    return &_syx_primitive_entries[index];

  return NULL;
}

//! Returns the index of a primitive having a specific name
EXPORT syx_int32 syx_primitive_get_index (syx_symbol name);

/* Interpreter */

typedef syx_bool (* SyxInterpreterFunc) (syx_uint16 argument);
#define SYX_FUNC_INTERPRETER(name)		\
  syx_bool				\
  name (syx_uint16 argument)


//! Initialize the interpreter to be ready to execute processes
/*!
  This function is called internally by Syx e should not be called from user applications
*/
INLINE void
syx_interp_init (void)
{
  if (!_syx_exec_state)
    _syx_exec_state = syx_exec_state_new ();
}

//! Finalize the execution of processes and free all the memory used by the interpreter
/*!
  This function is called internally by Syx e should not be called from user applications
*/
INLINE void
syx_interp_quit (void)
{
  syx_exec_state_free ();
}



//! Push an object into the stack
#define syx_interp_stack_push(oop) (_syx_exec_state->stack[_syx_exec_state->sp++] = (oop))

//! Pop an object from the stack
#define syx_interp_stack_pop() (_syx_exec_state->stack[--_syx_exec_state->sp])

//! Peek the last object pushed into the stack
#define syx_interp_stack_peek() (_syx_exec_state->stack[_syx_exec_state->sp - 1])

//! Get the current context being executed
#define syx_interp_get_current_context() (_syx_exec_state->context)



//! Changes the current context with another context
/*!
  \return FALSE if the context was syx_nil
*/
INLINE syx_bool
syx_interp_swap_context (SyxOop context)
{
  _syx_exec_state->context = context;
  syx_exec_state_save ();
  syx_exec_state_fetch ();
  return !SYX_IS_NIL (context);
}

//! Leaves the current context and push an object into the returning context
/*!
  Obtain the returning context from the returnContext variable of the context if use_return_context is specified, otherwise use the parent context.
  Then sets the returned object variable of the process to the specified object.
  Finally swap the context with the new one: syx_interp_swap_context returns TRUE, then push return_object into the new context, else remove the process from being scheduled.

  \param return_object the object to be pushed into the returning context
  \param use_return_context TRUE to get the returning context from returnContext variable, FALSE to use the parent context
  \return FALSE if the context was syx_nil and the process is removed from being scheduled
*/
INLINE syx_bool
syx_interp_leave_context_and_answer (SyxOop return_object, syx_bool use_return_context)
{
  SyxOop return_context = (use_return_context
			   ? SYX_METHOD_CONTEXT_RETURN_CONTEXT(_syx_exec_state->context)
			   : SYX_METHOD_CONTEXT_PARENT(_syx_exec_state->context));

  SYX_PROCESS_RETURNED_OBJECT(_syx_exec_state->process) = return_object;
  if (syx_interp_swap_context (return_context))
    {
      syx_interp_stack_push (return_object);
      return TRUE;
    }

  syx_scheduler_remove_process (_syx_exec_state->process); /* The process have no contexts anymore */
  return FALSE;
}

//! Enters a new context
/*!
  \return FALSE if the context was syx_nil
*/
INLINE syx_bool
syx_interp_enter_context (SyxOop context)
{
  _syx_exec_state->byteslice--; // incremented by "mark arguments" bytecode
  return syx_interp_swap_context (context);
}



//! Calls a primitive
/*
  \param primitive the primitive index
  \param method the method in which the primitive is defined
*/
INLINE syx_bool
syx_interp_call_primitive (syx_int16 primitive, SyxOop method)
{
  SyxPrimitiveEntry *prim_entry;

  // yield
  if (primitive == 0)
    {
      #ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Yield\n");
      #endif
      syx_interp_stack_push (_syx_exec_state->message_receiver);
      return FALSE;
    }

  prim_entry = syx_primitive_get_entry (primitive);
  return prim_entry->func (_syx_exec_state, method);
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

#endif /* SYX_INTERP_H */
