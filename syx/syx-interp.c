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

#include "syx-interp.h"
#include "syx-object.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-init.h"
#include "syx-plugins.h"
#include "syx-memory.h"
#include "syx-bytecode.h"
#include "syx-error.h"

#ifdef SYX_DEBUG_FULL

#define SYX_DEBUG_CONTEXT
/* #define SYX_DEBUG_CONTEXT_STACK */
#define SYX_DEBUG_BYTECODE
/* #define SYX_DEBUG_TRACE_IP */
/* #define SYX_DEBUG_BYTECODE_PROFILE */

#endif /* SYX_DEBUG_FULL */

SyxExecState *_syx_exec_state = NULL;

static syx_uint16 _syx_interp_get_next_byte (void);
static syx_bool _syx_interp_execute_byte (syx_uint16 byte);

/*! Create a new execution state to link the interpreter and the active process */
SyxExecState *
syx_exec_state_new (void)
{
  SyxExecState *ret = (SyxExecState *) syx_malloc (sizeof (SyxExecState));
  ret->message_arguments = NULL;
  return ret;
}

/*! Fetch the execution state of a Process */
void
syx_exec_state_fetch (void)
{
  SyxOop method;
  _syx_exec_state->context = SYX_PROCESS_CONTEXT (_syx_exec_state->process);
  if (SYX_IS_NIL (_syx_exec_state->context))
    {
      _syx_exec_state->ip = 0;
      _syx_exec_state->bytecodes_count = 0;
      return;
    }

  method = SYX_METHOD_CONTEXT_METHOD (_syx_exec_state->context);

  _syx_exec_state->receiver = SYX_METHOD_CONTEXT_RECEIVER (_syx_exec_state->context);
  if (!SYX_IS_NIL (SYX_METHOD_CONTEXT_ARGUMENTS (_syx_exec_state->context)))
    _syx_exec_state->arguments = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_ARGUMENTS (_syx_exec_state->context));

  if (!SYX_IS_NIL (SYX_METHOD_CONTEXT_TEMPORARIES (_syx_exec_state->context)))
    _syx_exec_state->temporaries = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_TEMPORARIES (_syx_exec_state->context));

  _syx_exec_state->stack = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_STACK (_syx_exec_state->context));
  _syx_exec_state->literals = SYX_OBJECT_DATA (SYX_CODE_LITERALS (method));
  _syx_exec_state->bytecodes = (syx_uint16 *)SYX_OBJECT_DATA (SYX_CODE_BYTECODES (method));
  _syx_exec_state->bytecodes_count = SYX_OBJECT_DATA_SIZE (SYX_CODE_BYTECODES (method)) / 2;
  _syx_exec_state->ip = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_IP (_syx_exec_state->context));
  _syx_exec_state->sp = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_SP (_syx_exec_state->context));
}

/*! Frees the SyxExecState */
void
syx_exec_state_free (void)
{
  if (_syx_exec_state)
    {
      if (_syx_exec_state->message_arguments)
	syx_free (_syx_exec_state->message_arguments);

      syx_free (_syx_exec_state);
      _syx_exec_state = NULL;
    }
}

/*!
  Executes the given process and returnes once the byteslice is reached.

  This function automatically fetch the state of the Process, saves and frees it once it terminated its running time
*/
void
syx_process_execute_scheduled (SyxOop process)
{
  syx_uint16 byte;

  if (SYX_IS_NIL (SYX_PROCESS_CONTEXT (process)))
    {
      syx_scheduler_remove_process (process);
      return;
    }

  _syx_exec_state->process = process;
  syx_exec_state_fetch ();
  _syx_exec_state->byteslice = SYX_SMALL_INTEGER (syx_processor_byteslice);

  while (_syx_exec_state->ip < _syx_exec_state->bytecodes_count && _syx_exec_state->byteslice >= 0)
    {
      byte = _syx_interp_get_next_byte ();
      if (!_syx_interp_execute_byte (byte))
	break;
      _syx_exec_state->byteslice--;
    }

  syx_exec_state_save ();
}

/*! Same as syx_process_execute_scheduled but does not take care about the byteslice counter */
void
syx_process_execute_blocking (SyxOop process)
{
  SyxExecState *orig_es;
  syx_uint16 byte;
  SyxOop orig_process;

  if (SYX_IS_NIL (SYX_PROCESS_CONTEXT (process)))
    {
      syx_scheduler_remove_process (process);
      return;
    }

  orig_process = syx_processor_active_process;
  orig_es = _syx_exec_state;
  _syx_exec_state = syx_exec_state_new ();
  _syx_exec_state->process = process;
  syx_exec_state_fetch ();
  syx_processor_active_process = process;

  while (_syx_exec_state->ip < _syx_exec_state->bytecodes_count)
    {
      byte = _syx_interp_get_next_byte ();
      _syx_interp_execute_byte (byte);
    }

  syx_exec_state_save ();
  syx_exec_state_free ();

  _syx_exec_state = orig_es;
  syx_processor_active_process = orig_process;
}


SYX_FUNC_INTERPRETER (syx_interp_push_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push instance at %d\n", argument);
#endif
  syx_interp_stack_push (SYX_OBJECT_VARS(_syx_exec_state->receiver)[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_argument)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push argument at %d\n", argument);
#endif

  if (argument == 0)
    syx_interp_stack_push (_syx_exec_state->receiver);
  else
    syx_interp_stack_push (_syx_exec_state->arguments[argument - 1]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push temporary at %d\n", argument);
#endif
  syx_interp_stack_push (_syx_exec_state->temporaries[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_literal)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push literal at %d\n", argument);
#endif
  syx_interp_stack_push (_syx_exec_state->literals[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_constant)
{
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
      syx_interp_stack_push (_syx_exec_state->context);
      break;
    default:
      syx_signal (SYX_ERROR_INTERP, 2, syx_small_integer_new (__LINE__), syx_small_integer_new (argument));
      return FALSE;
    }
  
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_binding_variable)
{
  SyxOop binding;
  SyxOop object;

  binding = _syx_exec_state->literals[argument];
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
  SYX_OBJECT_VARS(_syx_exec_state->receiver)[argument] = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign temporary at %d\n", argument);
#endif
  _syx_exec_state->temporaries[argument] = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_binding_variable)
{
  SyxOop binding;
  SyxOop value;

  binding = _syx_exec_state->literals[argument];
  value = syx_interp_stack_peek ();

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign binding variable '%s' -> %p\n",
	     SYX_OBJECT_SYMBOL(SYX_ASSOCIATION_KEY(binding)),
	     SYX_OBJECT (value));
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

  _syx_exec_state->message_arguments_count = argument;

  if (_syx_exec_state->message_arguments)
    syx_free (_syx_exec_state->message_arguments);

  if (argument > 0)
    {
      _syx_exec_state->message_arguments = (SyxOop *) syx_calloc (argument, sizeof (SyxOop));
      for (i=argument - 1; i >= 0; i--)
	_syx_exec_state->message_arguments[i] = syx_interp_stack_pop ();
    }
  else
    _syx_exec_state->message_arguments = NULL;

  _syx_exec_state->message_receiver = syx_interp_stack_pop ();
  if (_syx_exec_state->sp < 0)
    puts ("ASD");
  _syx_exec_state->byteslice++; /* be sure we send the message */

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_message)
{
  SyxOop binding;
  SyxOop klass, method, context;
  syx_int32 primitive;

  binding = _syx_exec_state->literals[argument];
  klass = syx_object_get_class (_syx_exec_state->message_receiver); 
  method = syx_class_lookup_method_binding (klass, binding);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send message #%s\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD #%s\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif
      return syx_signal_does_not_understand (_syx_exec_state->message_receiver, SYX_ASSOCIATION_KEY (binding));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (_syx_exec_state, method);

  if (_syx_exec_state->message_arguments_count > 0)
    {
      syx_memory_gc_begin ();
      context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver,
					syx_array_new (_syx_exec_state->message_arguments_count, _syx_exec_state->message_arguments));
      syx_memory_gc_end ();
      _syx_exec_state->message_arguments = NULL;
    }
  else
    context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver, syx_nil);

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_super)
{
  SyxOop binding;
  SyxOop klass, method, context;
  syx_int32 primitive;

  binding = _syx_exec_state->literals[argument];
  klass = SYX_CLASS_SUPERCLASS (SYX_CODE_CLASS (SYX_METHOD_CONTEXT_METHOD (_syx_exec_state->context)));
  method = syx_class_lookup_method_binding (klass, binding);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send message #%s to super\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif

  if (SYX_IS_NIL (method))
    {
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - NOT UNDERSTOOD super #%s\n", SYX_OBJECT_SYMBOL (SYX_ASSOCIATION_KEY (binding)));
#endif
      return syx_signal_does_not_understand (_syx_exec_state->message_receiver, SYX_ASSOCIATION_KEY (binding));
    }

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);
  else if (primitive == -2)
    return syx_plugin_call_interp (_syx_exec_state, method);

  if (_syx_exec_state->message_arguments_count > 0)
    {
      syx_memory_gc_begin ();
      context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver,
					syx_array_new (_syx_exec_state->message_arguments_count, _syx_exec_state->message_arguments));
      syx_memory_gc_end ();
      _syx_exec_state->message_arguments = NULL;
    }
  else
    context = syx_method_context_new (_syx_exec_state->context, method, _syx_exec_state->message_receiver, syx_nil);

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_unary)
{
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
    case 0: /* isNil */
      #ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Send unary message isNil\n");
      #endif
      syx_interp_stack_push (syx_boolean_new (SYX_IS_NIL (_syx_exec_state->message_receiver)));
      return TRUE;
    case 1: /* notNil */
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

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_push_block_closure)
{
  SyxOop closure = syx_object_copy (_syx_exec_state->literals[argument]);
  syx_interp_stack_push (closure);
  SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(closure) = _syx_exec_state->context;
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_binary)
{
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
	case 0: /* + */
	  syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) + SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 1: /* - */
	  syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) - SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 2: /* < */
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) < SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 3: /* > */
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) > SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 4: /* <= */
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) <= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 5: /* >= */
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) >= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 6: /* = */
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(_syx_exec_state->message_receiver) == SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 7: /* ~= */
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

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_do_special)
{
  SyxOop returned_object;
  SyxOop condition;
  syx_uint16 jump;

  switch (argument)
    {
    case SYX_BYTECODE_POP_TOP:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Pop top\n");
#endif
      _syx_exec_state->sp--;
      return TRUE;
    case SYX_BYTECODE_SELF_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Self return\n");
#endif
      if (SYX_OOP_EQ (syx_object_get_class (_syx_exec_state->context), syx_block_context_class))
	returned_object = syx_interp_stack_pop ();
      else
	returned_object = _syx_exec_state->receiver;

      return syx_interp_leave_context_and_answer (returned_object, FALSE);
    case SYX_BYTECODE_STACK_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Stack return\n");
#endif
      returned_object = syx_interp_stack_pop ();
      return syx_interp_leave_context_and_answer (returned_object, TRUE);
    case SYX_BYTECODE_BRANCH_IF_TRUE:
    case SYX_BYTECODE_BRANCH_IF_FALSE:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Conditional\n");
#endif
      condition = syx_interp_stack_pop ();
      jump = _syx_interp_get_next_byte ();
      if (!SYX_IS_BOOLEAN (condition))
	syx_signal (SYX_ERROR_INTERP, 0);

      /* Check for jump to the other conditional branch */
      if ((argument == SYX_BYTECODE_BRANCH_IF_TRUE ? SYX_IS_FALSE (condition) : SYX_IS_TRUE (condition)))
	{
	  syx_interp_stack_push (syx_nil);
	  _syx_exec_state->ip = jump;
	}
      return TRUE;
    case SYX_BYTECODE_BRANCH:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Branch\n");
#endif
      jump = _syx_interp_get_next_byte ();
      if (jump)
	_syx_exec_state->ip = jump;
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
      syx_signal (SYX_ERROR_INTERP, 0);
      return FALSE;
    }

  return TRUE;
}

static syx_uint16
_syx_interp_get_next_byte (void)
{
#ifdef SYX_DEBUG_TRACE_IP
  syx_debug ("TRACE IP - Context %p fetch at ip %d bytecode: %p\n", _syx_exec_state->context, _syx_exec_state->ip, _syx_exec_state->bytecodes[_syx_exec_state->ip]);
#endif

  return SYX_COMPAT_SWAP_16 (_syx_exec_state->bytecodes[_syx_exec_state->ip++]);
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

#ifdef SYX_DEBUG_BYTECODE_PROFILE
  GTimer *timer = g_timer_new ();
#endif

  res = handler (argument);

#ifdef SYX_DEBUG_BYTECODE_PROFILE
  g_timer_stop (timer);
  syx_debug("BYTECODE PROFILE - Command %d with arguments %d: %fs\n", command, argument, g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);
#endif
  
  return res;
}
