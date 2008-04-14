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

/*! \page syx_interpreter Syx Interpreter

  Frame representation:
  this context - * may be nil, it's set when a the context is demanded from the Smalltalk-side
  parent frame - points to the frame which created the current one, used for "self return"
  outer frame - points to the most outer frame, usually the frame which created the block closure. It's NULL for method contexts.
  return frame - points the frame used for stack return
  compiled code - a CompiledMethod or a CompiledBlock
  instruction pointer - pointer to the next method bytecode to be executed
  arguments pointer
  temporaries pointer
  stack pointer
  ... stack ... - contains in order: receiver, arguments, temporaries and others
  
  * When a context is needed from the Smalltalk-side (e.g. thisContext, Processor activeProcess context,
  context parent), a MethodContext or BlockContext is created on the fly.
  Working on the context instance will have effects on the Process stack, and, when possible,
  return the existing one (this context).
*/

#include "syx-object.h"
#include "syx-interp.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-init.h"
#include "syx-plugins.h"
#include "syx-memory.h"
#include "syx-bytecode.h"
#include "syx-error.h"
#include "syx-profile.h"

#include <assert.h>

#ifdef SYX_DEBUG_FULL

#define SYX_DEBUG_CONTEXT
#define SYX_DEBUG_BYTECODE
/*#define SYX_DEBUG_TRACE_IP*/

#endif /* SYX_DEBUG_FULL */

#define _SYX_INTERP_IN_BLOCK (_syx_interp_state.frame->outer_frame != NULL)

SyxInterpState _syx_interp_state;

#ifdef SYX_DEBUG_CONTEXT
syx_int32 _frame_depth;
#endif

static syx_uint16 _syx_interp_get_next_byte (void);
static syx_bool _syx_interp_execute_byte (syx_uint16 byte);

/*! Saves the current execution state into the active Process */
void
_syx_interp_save_process_state (void)
{
  SYX_PROCESS_FRAME_POINTER(syx_processor_active_process) = syx_small_integer_new (SYX_POINTERS_OFFSET (_syx_interp_state.frame, _syx_interp_state.process_frame));
}

/* Fetches and updates the execution state of the interpreter to be ready for next instructions */
static void
_syx_interp_state_update (void)
{
  SyxOop method;
  SyxOop bytecodes;

  method = _syx_interp_state.frame->method;
  if (SYX_IS_NIL (method))
    return;

  bytecodes = SYX_CODE_BYTECODES (method);
  _syx_interp_state.arguments = &_syx_interp_state.frame->local;
  _syx_interp_state.temporaries = _syx_interp_state.arguments + SYX_SMALL_INTEGER (SYX_CODE_ARGUMENTS_COUNT (method));
  _syx_interp_state.method_literals = SYX_OBJECT_DATA (SYX_CODE_LITERALS (method));
  _syx_interp_state.method_bytecodes = (syx_uint16 *)SYX_OBJECT_DATA (bytecodes);
  _syx_interp_state.method_bytecodes_count = SYX_OBJECT_DATA_SIZE (bytecodes);
}

/*! "Maybe" switch process and return TRUE if it's valid, FALSE otherwise */
static syx_bool
_syx_interp_switch_process (SyxOop process)
{
  SyxInterpFrame *frame;

  frame = (SyxInterpFrame *)SYX_OBJECT_DATA (SYX_PROCESS_STACK (process));
  if (!frame)
    return FALSE;

  _syx_interp_save_process_state ();
  _syx_interp_state.process_frame = frame;
  frame += SYX_SMALL_INTEGER (SYX_PROCESS_FRAME_POINTER (process));
  _syx_interp_state.frame = frame;
  _syx_interp_state_update ();

  if (SYX_IS_NIL (_syx_interp_state.frame->method))
    return FALSE;

  _syx_interp_state.byteslice = SYX_SMALL_INTEGER (syx_processor_byteslice);
  return TRUE;
}

/*! Sending the message means changing the frame and gaining all necessary informations to run
  the given method.
  It's not static because it's called form within syx primitives. */
void
_syx_interp_frame_prepare_new (SyxOop method)
{
  SyxInterpFrame *frame;
  SyxInterpFrame *parent_frame;
  syx_int32 temporaries_count;

  parent_frame = _syx_interp_state.frame;
  /* We create the new frame just after the current one. The top of the stack is a good point then.
   If the stack pointer isn't available (e.g. for first process run) just use the process stack bottom. */
  if (!parent_frame->stack)
    {
      parent_frame = NULL;
      frame = _syx_interp_state.frame = _syx_interp_state.process_frame;
    }
  else
    frame = _syx_interp_state.frame = (SyxInterpFrame *)parent_frame->stack;

#ifdef SYX_DEBUG_CONTEXT
  printf("CONTEXT - New frame %p - Depth: %d\n", _syx_interp_state.frame, ++_frame_depth);
#endif

  frame->this_context = syx_nil;
  frame->parent_frame = parent_frame;
  frame->stack_return_frame = parent_frame;
  frame->outer_frame = NULL;
  frame->method = method;
  frame->next_instruction = 0;

  _syx_interp_state_update ();

  temporaries_count = SYX_SMALL_INTEGER (SYX_CODE_TEMPORARIES_COUNT (method));
  frame->stack = _syx_interp_state.temporaries + temporaries_count;

  frame->receiver = _syx_interp_state.message_receiver;
  memcpy (_syx_interp_state.arguments, _syx_interp_state.message_arguments,
          _syx_interp_state.message_arguments_count * sizeof (SyxOop));
  memset (_syx_interp_state.temporaries, '\0', temporaries_count * sizeof (SyxOop));
}

/*! Both create a new frame and prepare for calling a block closure.
  This function shouldn't be called by any applications.
  It's not static because it's called form within syx primitives. */
void
_syx_interp_frame_prepare_new_closure (SyxOop closure)
{
  _syx_interp_frame_prepare_new (SYX_BLOCK_CLOSURE_BLOCK (closure));

  _syx_interp_state.frame->outer_frame = (SyxInterpFrame *)SYX_OBJECT_DATA (SYX_BLOCK_CLOSURE_OUTER_FRAME (closure));
  _syx_interp_state.frame->receiver = _syx_interp_state.frame->outer_frame->receiver;

  /* We can't return more if there's no parent frame. See BlockClosure_newProcess primitive for instance. */
  if (_syx_interp_state.frame->parent_frame)
    _syx_interp_state.frame->stack_return_frame = _syx_interp_state.frame->outer_frame->stack_return_frame;
}

/*! Creates a MethodContext or BlockContext from a frame */
static SyxOop
_syx_interp_frame_to_context (SyxInterpFrame *frame)
{
  SyxOop context;
  SyxOop arguments;

  if (frame->this_context)
    return frame->this_context;
  
  syx_memory_gc_begin ();
  arguments = syx_array_new (SYX_CODE_ARGUMENTS_COUNT (frame->method), &frame->local);
  if (_SYX_INTERP_IN_BLOCK)
    context = syx_block_context_new (frame->method, arguments);
  else
    context = syx_method_context_new (frame->method, frame->receiver, arguments);
  frame->this_context = context;
  syx_memory_gc_end ();

  return context;
}

/*!
  Initialize the interpreter to be ready to execute processes.

  This function is called internally by Syx and should not be called from user applications.
*/
void
syx_interp_init (void)
{
  memset (&_syx_interp_state, '\0', sizeof (SyxInterpState));
}

/*!
  Finalize the execution of processes and free all the memory used by the interpreter.

  This function is called internally by Syx e should not be called from user applications
*/
void
syx_interp_quit (void)
{
}

/*!
  Swap the current context with the given one.
  
  \return FALSE if the context was syx_nil
*/
syx_bool
syx_interp_swap_context (SyxOop process, SyxOop context)
{
  /* TODO: implement */
  return TRUE;
}

/*!
  Enters a new MethodContext or BlockContext.

  \return FALSE if the context was syx_nil
*/
syx_bool
syx_interp_enter_context (SyxOop process, SyxOop context)
{
  SyxInterpState orig_state;
  SyxOop arguments;

  if (SYX_IS_NIL (process) || SYX_IS_NIL (context))
    return FALSE;

  if (SYX_OOP_NE (process, syx_processor_active_process) || !_syx_interp_state.frame)
    {
      orig_state = _syx_interp_state;
      _syx_interp_switch_process (process);
    }

  arguments = SYX_METHOD_CONTEXT_ARGUMENTS (context);
  if (SYX_IS_NIL (arguments))
    _syx_interp_state.message_arguments_count = 0;
  else
    {
      _syx_interp_state.message_arguments_count = SYX_OBJECT_DATA_SIZE (arguments);
      memcpy (_syx_interp_state.message_arguments, SYX_OBJECT_DATA (arguments), _syx_interp_state.message_arguments_count * sizeof (SyxOop));
    }

  if (SYX_OOP_EQ (syx_object_get_class (context), syx_block_context_class))
    _syx_interp_frame_prepare_new_closure (SYX_BLOCK_CONTEXT_CLOSURE (context));
  else
    {
      _syx_interp_state.message_receiver = SYX_METHOD_CONTEXT_RECEIVER (context);
      _syx_interp_frame_prepare_new (SYX_METHOD_CONTEXT_METHOD (context));
    }
  _syx_interp_state.frame->this_context = context;

  if (SYX_OOP_NE (process, syx_processor_active_process))
    {
      _syx_interp_state = orig_state;
      _syx_interp_switch_process (syx_processor_active_process);
    }

  return TRUE;
}

/*!
  Leaves the current frame and push an object into the returning context.

  Use the stack return frame use_stack_return is specified, otherwise use the parent frame.
  Then sets the returned object variable of the process to the specified object.
  Finally swap the context with the new one. Terminate the process if no valid return frame is found.

  \param return_object the object to be pushed into the returning context
  \param use_stack_return TRUE to use the stack return frame, FALSE to use the parent frame
  \return FALSE if no valid return frame is found
*/
syx_bool
syx_interp_leave_and_answer (SyxOop return_object, syx_bool use_stack_return)
{
  SyxInterpFrame *return_frame = (use_stack_return
                                  ? _syx_interp_state.frame->stack_return_frame
                                  : _syx_interp_state.frame->parent_frame);

#ifdef SYX_DEBUG_CONTEXT
  printf("CONTEXT - Leave frame %p for %p - Depth: %d\n", _syx_interp_state.frame, return_frame, --_frame_depth);
#endif

  SYX_PROCESS_RETURNED_OBJECT(syx_processor_active_process) = return_object;

  if (!return_frame)
    {
      syx_scheduler_remove_process (syx_processor_active_process);
      return FALSE;
    }

  _syx_interp_state.frame = return_frame;
  _syx_interp_state_update ();
  syx_interp_stack_push (return_object);
  return TRUE;
}

/*!
  Executes the given process and returns once the byteslice is reached, no more instructions left or
  yield has been requested.
*/
void
syx_process_execute_scheduled (SyxOop process)
{
  syx_uint16 byte;

  if (!_syx_interp_switch_process (process))
    {
      syx_scheduler_remove_process (process);
      return;
    }

  while (_syx_interp_state.frame->next_instruction < _syx_interp_state.method_bytecodes_count && _syx_interp_state.byteslice >= 0)
    {
      byte = _syx_interp_get_next_byte ();
      /* No more instructions or somebody wants to yield control to other processes */
      if (!_syx_interp_execute_byte (byte))
        break;
      _syx_interp_state.byteslice--;
    }

  _syx_interp_save_process_state ();
}

/*! Same as syx_process_execute_scheduled but does not take care about the byteslice counter,
  and control is not yield until the process is terminated.
*/
void
syx_process_execute_blocking (SyxOop process)
{
  SyxInterpState orig_state;
  SyxOop orig_process;
  syx_uint16 byte;

  SYX_START_PROFILE;

  orig_process = syx_processor_active_process;
  orig_state = _syx_interp_state;

  if (!_syx_interp_switch_process (process))
    {
      syx_processor_active_process = orig_process;
      _syx_interp_state = orig_state;
      syx_scheduler_remove_process (process);
      return;
    }

  while (_syx_interp_state.frame->next_instruction < _syx_interp_state.method_bytecodes_count)
    {
      byte = _syx_interp_get_next_byte ();
      _syx_interp_execute_byte (byte);
    }
  _syx_interp_save_process_state ();

  _syx_interp_state = orig_state;
  syx_processor_active_process = orig_process;

  SYX_END_PROFILE(blocking);
}


/* Bytecode intepreter */

static SyxOop *
_syx_interp_find_argument (syx_uint16 argument)
{
  SyxInterpFrame *frame = _syx_interp_state.frame;
  /* The argument index created by the parser is the totally index of all outer arguments.
     So we need to find the right scope by looping trough outer frames and their arguments. */
  while (frame)
    {
      syx_int32 count = SYX_SMALL_INTEGER (SYX_CODE_ARGUMENTS_COUNT (frame->method));
      if (count > argument)
        return ((SyxOop *)&frame->local) + argument;
      argument -= count;
      frame = frame->outer_frame;
    }
  
  /* this shouldn't be reached, maybe a parser fault? */
  assert (FALSE);
  return NULL;
}

static SyxOop *
_syx_interp_find_temporary (syx_uint16 temporary)
{
  SyxInterpFrame *frame = _syx_interp_state.frame;
  /* The temporary index created by the parser is the totally index of all outer temporaries.
     So we need to find the right scope by looping trough outer frames and their arguments. */
  while (frame)
    {
      syx_int32 count = SYX_SMALL_INTEGER (SYX_CODE_TEMPORARIES_COUNT (frame->method));
      if (count > temporary)
        return ((SyxOop *)&frame->local + SYX_SMALL_INTEGER (SYX_CODE_ARGUMENTS_COUNT (frame->method))) + temporary;
      temporary -= count;
      frame = frame->outer_frame;
    }

  /* this shouldn't be reached, maybe a parser fault? */
  assert (FALSE);
  return NULL;
}

SYX_FUNC_INTERPRETER (syx_interp_push_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push instance at %d\n", argument);
#endif
  syx_interp_stack_push (SYX_OBJECT_VARS(_syx_interp_state.frame->receiver)[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_argument)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push argument at %d\n", argument);
#endif
  
  if (argument == 0)
    syx_interp_stack_push (_syx_interp_state.frame->receiver);
  else
    syx_interp_stack_push (*_syx_interp_find_argument (argument - 1));
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push temporary at %d\n", argument);
#endif
  syx_interp_stack_push (*_syx_interp_find_temporary (argument));
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_literal)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push literal at %d\n", argument);
#endif
  syx_interp_stack_push (_syx_interp_state.method_literals[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_constant)
{
  SyxOop context;
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push constant %d\n", argument);
#endif
  switch (argument)
    {
    case SYX_BYTECODE_CONST_NIL:
      syx_interp_stack_push (syx_nil);
      break;
    case SYX_BYTECODE_CONST_TRUE:
      syx_interp_stack_push (syx_true);
      break;
    case SYX_BYTECODE_CONST_FALSE:
      syx_interp_stack_push (syx_false);
      break;
    case SYX_BYTECODE_CONST_CONTEXT:
      context = _syx_interp_frame_to_context (_syx_interp_state.frame);
      syx_interp_stack_push (context);
      break;
    default:
      syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unknown constant"));
      return FALSE;
    }
  
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_binding_variable)
{
  SyxOop binding;
  SyxOop object;

  binding = _syx_interp_state.method_literals[argument];
  object = syx_dictionary_bind (binding);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push binding variable: '%s' -> %d\n",
             SYX_OBJECT_SYMBOL(SYX_ASSOCIATION_KEY(binding)),
             SYX_SMALL_INTEGER (SYX_ASSOCIATION_VALUE (binding)));
#endif

  syx_interp_stack_push (object);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_array)
{
  SyxOop array;
  syx_uint16 i;

  array = syx_array_new_size (argument);
  for (i=1; i <= argument; i++)
    SYX_OBJECT_DATA(array)[argument - i] = syx_interp_stack_pop ();

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push array of elements: %d\n", argument);
#endif

  syx_interp_stack_push (array);

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign instance at %d\n", argument);
#endif
  SYX_OBJECT_VARS(_syx_interp_state.frame->receiver)[argument] = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign temporary at %d\n", argument);
#endif
  *(_syx_interp_find_temporary (argument)) = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_binding_variable)
{
  SyxOop binding;
  SyxOop value;

  binding = _syx_interp_state.method_literals[argument];
  value = syx_interp_stack_peek ();

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign binding variable '%s' -> %p\n",
             SYX_OBJECT_SYMBOL(SYX_ASSOCIATION_KEY(binding)),
             SYX_OOP_CAST_POINTER (value));
#endif

  syx_dictionary_bind_set_value (binding, value);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_mark_arguments)
{
  syx_varsize i;

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Mark arguments %d + receiver\n", argument);
#endif

  if (argument > 0xFF)
    syx_signal (SYX_ERROR_INTERP, syx_string_new ("Max number of arguments exceeded: %d\n", argument));

  _syx_interp_state.message_arguments_count = argument;
  for (i=argument - 1; i >= 0; i--)
    _syx_interp_state.message_arguments[i] = syx_interp_stack_pop ();

  _syx_interp_state.message_receiver = syx_interp_stack_pop ();
  _syx_interp_state.byteslice++; /* be sure we send the message */

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_message)
{
  SyxOop binding;
  SyxOop klass, method;
  syx_int32 primitive;
#ifdef SYX_DEBUG_CONTEXT
  syx_int32 depth;
#endif

  SYX_START_PROFILE;

  binding = _syx_interp_state.method_literals[argument];
  klass = syx_object_get_class (_syx_interp_state.message_receiver); 
  method = syx_class_lookup_method_binding (klass, binding);
  SYX_END_PROFILE(send_message);
#ifdef SYX_DEBUG_BYTECODE
#ifdef SYX_DEBUG_CONTEXT
  putchar('`');
  for (depth=0; depth < _frame_depth; depth++)
    putchar('-');
#endif
  syx_debug ("BYTECODE - Send message %s%s#%s\n",
             SYX_IS_NIL (SYX_CLASS_NAME (syx_object_get_class (_syx_interp_state.message_receiver)))
             ? SYX_OBJECT_STRING (SYX_CLASS_NAME (_syx_interp_state.message_receiver))
             : SYX_OBJECT_STRING (SYX_CLASS_NAME (syx_object_get_class (_syx_interp_state.message_receiver))),
             SYX_IS_NIL (SYX_CLASS_NAME (syx_object_get_class (_syx_interp_state.message_receiver)))
             ? " class"
             : "",
             SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD #%s\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif
      return syx_signal_does_not_understand (_syx_interp_state.message_receiver, SYX_ASSOCIATION_KEY (binding));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (&_syx_interp_state, method);

  _syx_interp_frame_prepare_new (method);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_super)
{
  SyxOop binding;
  SyxOop klass, method;
  syx_int32 primitive;

  binding = _syx_interp_state.method_literals[argument];
  klass = SYX_CLASS_SUPERCLASS (SYX_CODE_CLASS (_syx_interp_state.frame->method));
  method = syx_class_lookup_method_binding (klass, binding);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send message #%s to super\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD super #%s\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif
      return syx_signal_does_not_understand (_syx_interp_state.message_receiver, SYX_ASSOCIATION_KEY (binding));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (&_syx_interp_state, method);

  _syx_interp_frame_prepare_new (method);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_unary)
{
  /*
  SyxOop klass, method, context;
  syx_int32 primitive;
  syx_int32 index;
  SyxOop binding;
  syx_symbol selector;
  
  _syx_exec_state->message_receiver = syx_interp_stack_pop ();
  index = SYX_SMALL_INTEGER (SYX_ASSOCIATION_KEY (_syx_exec_state->literals[argument]));
  binding = SYX_ASSOCIATION_VALUE (_syx_exec_state->literals[argument]);
  selector = SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding));

  switch (index)
    {
    case 0:
      #ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Send unary message isNil\n");
      #endif
      syx_interp_stack_push (syx_boolean_new (SYX_IS_NIL (_syx_exec_state->message_receiver)));
      return TRUE;
    case 1:
      #ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Send unary message notNil\n");
      #endif
      syx_interp_stack_push (syx_boolean_new (!SYX_IS_NIL (_syx_exec_state->message_receiver)));
      return TRUE;
    }

  klass = syx_object_get_class (_syx_exec_state->message_receiver);
  method = syx_class_lookup_method_binding (klass, binding);  

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send unary message #%s\n", selector);
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD unary #%s\n", selector);
#endif
      return syx_signal_does_not_understand (_syx_exec_state->message_receiver, syx_symbol_new (selector));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (_syx_exec_state, method);

    context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver, syx_nil);

    return syx_interp_enter_context (context);*/
  return 0;
}

SYX_FUNC_INTERPRETER (syx_interp_push_block_closure)
{
  SyxOop frame;
  SyxOop closure = syx_object_copy (_syx_interp_state.method_literals[argument]);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push block closure %d -> %p\n", argument, SYX_OOP_CAST_POINTER (closure));
#endif

  syx_interp_stack_push (closure);
  
  /* Copy a piece of the process stack: the current frame without the "local" structure member
     which is unuseful. */
  frame = syx_array_new (sizeof (SyxInterpFrame) / 4 - 1, (SyxOop *)_syx_interp_state.frame);
  SYX_BLOCK_CLOSURE_OUTER_FRAME(closure) = frame;
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_binary)
{
  /*
  SyxOop klass, method, context, first_argument;
  syx_int32 primitive;
  SyxOop binding;
  syx_int32 index;
  syx_symbol selector;

  first_argument = syx_interp_stack_pop ();
  _syx_exec_state->message_receiver = syx_interp_stack_pop ();
  index = SYX_SMALL_INTEGER (SYX_ASSOCIATION_KEY (_syx_exec_state->literals[argument]));
  binding = SYX_ASSOCIATION_VALUE (_syx_exec_state->literals[argument]);
  selector = SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding));

  if (index < 8 && SYX_IS_SMALL_INTEGER(_syx_exec_state->message_receiver) && SYX_IS_SMALL_INTEGER(first_argument))
    {
      switch (index)
        {
        case 0:
          syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) + SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 1:
          syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) - SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 2:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) < SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 3:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) > SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 4:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) <= SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 5:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) >= SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 6:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) == SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        case 7:
          syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) != SYX_SMALL_INTEGER(first_argument)));
          return TRUE;
        }
    }

  klass = syx_object_get_class (_syx_exec_state->message_receiver);
  method = syx_class_lookup_method_binding (klass, binding);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send binary message #%s\n", selector);
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD binary #%s\n", selector);
#endif
      return syx_signal_does_not_understand (_syx_exec_state->message_receiver, syx_symbol_new (selector));
    }

  if (_syx_exec_state->message_arguments)
    syx_free (_syx_exec_state->message_arguments);
  
  _syx_exec_state->message_arguments = (SyxOop *) syx_calloc (1, sizeof (SyxOop));
  _syx_exec_state->message_arguments[0] = first_argument;

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (_syx_exec_state, method);

  syx_memory_gc_begin ();
  context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver,
    syx_array_new (1, _syx_exec_state->message_arguments));
  syx_memory_gc_end ();
  _syx_exec_state->message_arguments = NULL;

  return syx_interp_enter_context (context);*/
  return 0;
}

SYX_FUNC_INTERPRETER (syx_interp_do_special)
{
  SyxOop returned_object;
  SyxOop condition;
  syx_uint16 jump;
  SyxOop ensure_block;

  switch (argument)
    {
    case SYX_BYTECODE_POP_TOP:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Pop top\n");
#endif
      _syx_interp_state.frame->stack--;
      return TRUE;
    case SYX_BYTECODE_SELF_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Self return\n");
#endif
      if (_SYX_INTERP_IN_BLOCK)
        {
          if (!SYX_IS_NIL (_syx_interp_state.frame->this_context))
            {
              /* check for ensured blocks */
              ensure_block = SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context);
              if (SYX_IS_TRUE (ensure_block))
                {
                  /* ensured block has been called,
                     so pop its returned object */
                  _syx_interp_state.frame->stack--;
                  SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context) = syx_nil;
                  returned_object = syx_interp_stack_pop ();
                }
              else if (!SYX_IS_NIL (ensure_block))
                {
                  /* no arguments passed to the ensure block */
                  _syx_interp_state.message_arguments_count = 0;
                  /* decrease instruction pointer re-execute self-return */
                  _syx_interp_state.frame->next_instruction--;
                  
                  /* set the ensure block to true, so that next time self-return bytecode is executed */
                  SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context) = syx_true;
                  _syx_interp_frame_prepare_new_closure (ensure_block);
                  return TRUE;
                }
            }
          else
            returned_object = syx_interp_stack_pop ();
        }
      else
        returned_object = _syx_interp_state.frame->receiver;
      
      return syx_interp_leave_and_answer (returned_object, FALSE);

    case SYX_BYTECODE_STACK_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Stack return\n");
#endif

      if (_SYX_INTERP_IN_BLOCK)
        {
          if (!SYX_IS_NIL (_syx_interp_state.frame->this_context))
            {
              /* check for ensure blocks */
              ensure_block = SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context);
              if (SYX_IS_TRUE (ensure_block))
                {
                  /* ensured block has been called,
                     so pop its returned object */
                  _syx_interp_state.frame->stack--;
                  SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context) = syx_nil;
                }
              else if (!SYX_IS_NIL (ensure_block))
                {
                  /* no arguments passed to the ensure block */
                  _syx_interp_state.message_arguments_count = 0;
                  /* decrease instruction pointer re-execute self-return */
                  _syx_interp_state.frame->next_instruction--;
                  
                  /* set the ensure block to true, so that next time self-return bytecode is executed */
                  SYX_BLOCK_CONTEXT_ENSURE_BLOCK (_syx_interp_state.frame->this_context) = syx_true;
                  _syx_interp_frame_prepare_new_closure (ensure_block);
                  return TRUE;
                }
            }
        }

      returned_object = syx_interp_stack_pop ();

      return syx_interp_leave_and_answer (returned_object, TRUE);
    case SYX_BYTECODE_BRANCH_IF_TRUE:
    case SYX_BYTECODE_BRANCH_IF_FALSE:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Conditional\n");
#endif
      condition = syx_interp_stack_pop ();
      jump = _syx_interp_get_next_byte ();
      if (!SYX_IS_BOOLEAN (condition))
        syx_signal (SYX_ERROR_INTERP, syx_string_new ("Condition must be boolean"));

      /* Check for jump to the other conditional branch */
      if ((argument == SYX_BYTECODE_BRANCH_IF_TRUE ? SYX_IS_FALSE (condition) : SYX_IS_TRUE (condition)))
        {
          syx_interp_stack_push (syx_nil);
          _syx_interp_state.frame->next_instruction = jump;
        }

      return TRUE;
    case SYX_BYTECODE_BRANCH:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Branch\n");
#endif
      jump = _syx_interp_get_next_byte ();
      if (jump)
        _syx_interp_state.frame->next_instruction = jump;

      return TRUE;
    case SYX_BYTECODE_DUPLICATE:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Duplicate\n");
#endif

      syx_interp_stack_push (syx_interp_stack_peek ());
      return TRUE;
    default:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE ------- UNKNOWN --------\n");
#endif
      syx_signal (SYX_ERROR_INTERP, syx_string_new ("Unknown bytecode: %p", argument));
      return FALSE;
    }

  return TRUE;
}

static syx_uint16
_syx_interp_get_next_byte (void)
{
#ifdef SYX_DEBUG_TRACE_IP
  syx_debug ("TRACE IP - Fetch at ip %d bytecode: %u - %p\n", _syx_interp_state.frame->next_instruction, _syx_interp_state.method_bytecodes[_syx_interp_state.frame->next_instruction], _syx_interp_state.frame);
#endif

  return SYX_COMPAT_SWAP_16 (_syx_interp_state.method_bytecodes[_syx_interp_state.frame->next_instruction++]);
}

static syx_bool
_syx_interp_execute_byte (syx_uint16 byte)
{
  syx_uint16 command, argument;
  static SyxInterpreterFunc handlers[] =
    {
      syx_interp_push_instance,
      syx_interp_push_argument,
      syx_interp_push_temporary,
      syx_interp_push_literal,
      syx_interp_push_constant,
      syx_interp_push_binding_variable,
      syx_interp_push_array,
      syx_interp_push_block_closure,

      syx_interp_assign_instance,
      syx_interp_assign_temporary,
      syx_interp_assign_binding_variable,

      syx_interp_mark_arguments,
      syx_interp_send_message,
      syx_interp_send_super,
      syx_interp_send_unary,
      syx_interp_send_binary,

      syx_interp_do_special
    };
  SyxInterpreterFunc handler;
  syx_bool res;

  command = (byte & SYX_BYTECODE_COMMAND_MASK) >> SYX_BYTECODE_ARGUMENT_BITS;
  argument = byte & SYX_BYTECODE_ARGUMENT_MASK;

  if (command == SYX_BYTECODE_EXTENDED)
    {
      command = argument;
      argument = _syx_interp_get_next_byte ();
    }

  handler = handlers[command];

  res = handler (argument);

  return res;
}
