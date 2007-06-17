#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-interp.h"
#include "syx-object.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-init.h"
#include "syx-memory.h"
#include "syx-bytecode.h"
#include "syx-error.h"

#ifdef SYX_DEBUG_FULL

#define SYX_DEBUG_CONTEXT
#define SYX_DEBUG_CONTEXT_STACK
#define SYX_DEBUG_BYTECODE
/* #define SYX_DEBUG_TRACE_IP */
/* #define SYX_DEBUG_BYTECODE_PROFILE */

#endif /* SYX_DEBUG_FULL */

static SyxExecState *es = NULL;
static syx_uint16 _syx_interp_get_next_byte (void);
static syx_bool _syx_interp_execute_byte (syx_uint16 byte);

//! Push an object into the stack
inline void
syx_interp_stack_push (SyxOop object)
{
#ifdef SYX_DEBUG_CONTEXT_STACK
  syx_debug ("CONTEXT STACK - Push %x (sp = %d)\n", object.idx, es->sp);
#endif
  es->stack[es->sp++] = object;
}

//! Pop an object from the stack
inline SyxOop 
syx_interp_stack_pop (void)
{
#ifdef SYX_DEBUG_CONTEXT_STACK
  syx_debug ("CONTEXT STACK - Pop %x (sp = %d)\n", es->stack[es->sp - 1].idx, es->sp - 1);
#endif
  return es->stack[--es->sp];
}

//! Peek the last object pushed into the stack
inline SyxOop 
syx_interp_stack_peek (void)
{
  return es->stack[es->sp - 1];
}

//! Changes the current context with another context
/*!
  \return FALSE if the context was syx_nil
*/
inline syx_bool
syx_interp_swap_context (SyxOop context)
{
#ifdef SYX_DEBUG_CONTEXT
  syx_debug ("CONTEXT - Swap context %d with new %d\n", es->context.idx, context.idx);
#endif
  es->context = context;
  syx_exec_state_save ();
  syx_exec_state_fetch (es->process);
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
inline syx_bool
syx_interp_leave_context_and_answer (SyxOop return_object, syx_bool use_return_context)
{
  SyxOop return_context = use_return_context ? SYX_METHOD_CONTEXT_RETURN_CONTEXT(es->context) : SYX_METHOD_CONTEXT_PARENT(es->context);
#ifdef SYX_DEBUG_CONTEXT
  syx_debug ("CONTEXT - Leave context and answer: %x use return context: %d\n",
	     return_object.idx, use_return_context);
#endif

  SYX_PROCESS_RETURNED_OBJECT(es->process) = return_object;
  if (syx_interp_swap_context (return_context))
    {
      syx_interp_stack_push (return_object);
      return TRUE;
    }

  syx_scheduler_remove_process (es->process); /* The process have no contexts anymore */
  return FALSE;
}

//! Enters a new context
/*!
  \return FALSE if the context was syx_nil
*/
inline syx_bool
syx_interp_enter_context (SyxOop context)
{
#ifdef SYX_DEBUG_CONTEXT
  syx_debug ("CONTEXT - Enter context\n");
#endif

  es->byteslice--; // incremented by "mark arguments" bytecode
  return syx_interp_swap_context (context);
}

//! Calls a primitive
/*
  \param primitive the primitive index
  \param method the method in which the primitive is defined
*/
inline syx_bool
syx_interp_call_primitive (syx_int16 primitive, SyxOop method)
{
  // yield
  if (primitive == 0)
    {
      syx_interp_stack_push (es->receiver);
      return FALSE;
    }
  SyxPrimitiveEntry *prim_entry;

  prim_entry = syx_primitive_get_entry (primitive);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Do primitive %d (%s)\n", primitive, prim_entry->name);
#endif

  return prim_entry->func (es, method);
}

//! Get the current context being executed
inline SyxOop
syx_interp_get_current_context (void)
{
  return es->context;
}

//! Create a new execution state to link the interpreter and the active process
inline SyxExecState *
syx_exec_state_new (void)
{
  SyxExecState *ret = syx_malloc (sizeof (SyxExecState));
  ret->message_arguments = NULL;
  return ret;
}

//! Fetch the execution state of a Process
void
syx_exec_state_fetch (SyxOop process)
{
  SyxOop method;
  es->process = process;
  es->context = SYX_PROCESS_CONTEXT (process);
  if (SYX_IS_NIL (es->context))
    return;

  method = SYX_METHOD_CONTEXT_METHOD (es->context);

  es->receiver = SYX_METHOD_CONTEXT_RECEIVER (es->context);
  es->arguments = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_ARGUMENTS (es->context));
  es->temporaries = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_TEMPORARIES (es->context));
  es->stack = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_STACK (es->context));
  es->literals = SYX_OBJECT_DATA (SYX_METHOD_LITERALS (method));
  es->bytecodes = (syx_uint16 *)SYX_OBJECT_DATA (SYX_METHOD_BYTECODES (method));
  es->bytecodes_count = SYX_OBJECT_SIZE (SYX_METHOD_BYTECODES (method)) / 2;
  es->byteslice = SYX_SMALL_INTEGER (syx_processor_byteslice);
  es->ip = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_IP (es->context));
  es->sp = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_SP (es->context));
}

//! Save the current execution state
inline void
syx_exec_state_save (void)
{
  SyxOop context = SYX_PROCESS_CONTEXT (es->process);
  if (!SYX_IS_NIL (context))
    {
      SYX_METHOD_CONTEXT_IP(context) = syx_small_integer_new (es->ip);
      SYX_METHOD_CONTEXT_SP(context) = syx_small_integer_new (es->sp);
    }
  SYX_PROCESS_CONTEXT(es->process) = es->context;
}

//! Frees the SyxExecState
inline void
syx_exec_state_free (void)
{
  if (es)
    {
      if (es->message_arguments)
	syx_free (es->message_arguments);

      syx_free (es);
      es = NULL;
    }
}

//! Executes the given process and returnes once the byteslice is reached
/*!
  This function automatically fetch the state of the Process, saves and frees it once it terminated its running time
*/
void
syx_process_execute_scheduled (SyxOop process)
{
  syx_uint16 byte;
  
  es = syx_exec_state_new ();
  syx_exec_state_fetch (process);
  if (SYX_IS_NIL (es->context))
    {
      syx_scheduler_remove_process (process);
      syx_exec_state_free ();
      return;
    }

  while (es->ip < es->bytecodes_count && es->byteslice >= 0)
    {
      byte = _syx_interp_get_next_byte ();
      if (!_syx_interp_execute_byte (byte))
	break;
      es->byteslice--;
    }

  syx_exec_state_save ();
  syx_exec_state_free ();
}

//! Same as syx_process_execute_scheduled but does not take care about the byteslice counter
void
syx_process_execute_blocking (SyxOop process)
{
  syx_uint16 byte;

  es = syx_exec_state_new ();
  syx_exec_state_fetch (process);
  if (SYX_IS_NIL (es->context))
    {
      syx_scheduler_remove_process (process);
      syx_exec_state_free ();
      return;
    }

  syx_processor_active_process = process;
  while (es->ip < es->bytecodes_count)
    {
      byte = _syx_interp_get_next_byte ();
      if (!_syx_interp_execute_byte (byte))
	break;
    }

  syx_exec_state_save ();
  syx_exec_state_free ();
}


SYX_FUNC_INTERPRETER (syx_interp_push_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push instance at %d\n", argument);
#endif
  syx_interp_stack_push (SYX_OBJECT_DATA(es->receiver)[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_argument)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push argument at %d\n", argument);
#endif

  if (argument == 0)
    syx_interp_stack_push (es->receiver);
  else
    syx_interp_stack_push (es->arguments[argument - 1]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push temporary at %d\n", argument);
#endif
  syx_interp_stack_push (es->temporaries[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_literal)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push literal at %d\n", argument);
#endif
  syx_interp_stack_push (es->literals[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_constant)
{
  SyxOop constant;
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push constant %d\n", argument);
#endif
  if (argument < SYX_BYTECODE_CONST_CONTEXT)
    {
      constant.idx = argument;
      syx_interp_stack_push (constant);
    }
  else if (argument == SYX_BYTECODE_CONST_CONTEXT)
    syx_interp_stack_push (es->context);
  else
    {
      syx_signal (SYX_ERROR_INTERP, 2, syx_small_integer_new (__LINE__), syx_small_integer_new (argument));
      return FALSE;
    }
  
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_global)
{
  syx_symbol symbol;
  SyxOop object;

  symbol = SYX_OBJECT_SYMBOL (es->literals[argument]);

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Push global: '%s'\n", symbol);
#endif

  object = syx_globals_at (symbol);

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
  SYX_OBJECT_DATA(es->receiver)[argument] = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Assign temporary at %d\n", argument);
#endif
  es->temporaries[argument] = syx_interp_stack_peek ();
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_mark_arguments)
{
  syx_varsize i;

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Mark arguments %d + receiver\n", argument);
#endif

  es->message_arguments_count = argument;

  if (es->message_arguments)
    syx_free (es->message_arguments);

  if (argument > 0)
    {
      es->message_arguments = syx_calloc (argument, sizeof (SyxOop));
      for (i=argument - 1; i >= 0; i--)
	es->message_arguments[i] = syx_interp_stack_pop ();
    }
  else
    es->message_arguments = NULL;

  es->message_receiver = syx_interp_stack_pop ();
  es->byteslice++; // be sure we send the message

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_message)
{
  syx_symbol selector;
  SyxOop class, method, context;
  syx_int16 primitive;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = syx_object_get_class (es->message_receiver);
  method = syx_class_lookup_method (class, selector);

  if (SYX_IS_NIL (method))
    {
      syx_signal (SYX_ERROR_NOT_UNDERSTOOD, 0);
      return FALSE;
    }

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send message #%s\n", selector);
#endif

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);

  if (es->message_arguments_count > 0)
    {
      syx_memory_gc_begin ();
      context = syx_method_context_new (es->context, method, es->message_receiver,
					syx_array_new (es->message_arguments_count, es->message_arguments));
      syx_memory_gc_end ();
      es->message_arguments = NULL;
    }
  else
    context = syx_method_context_new (es->context, method, es->message_receiver, syx_nil);

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_super)
{
  syx_symbol selector;
  SyxOop class, method, context;
  syx_int16 primitive;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = SYX_CLASS_SUPERCLASS (syx_object_get_class (es->message_receiver));
  method = syx_class_lookup_method (class, selector);

  if (SYX_IS_NIL (method))
    {
      syx_signal (SYX_ERROR_NOT_UNDERSTOOD, 0);
      return FALSE;
    }

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send message #%s to super\n", selector);
#endif

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);

  if (es->message_arguments_count > 0)
    {
      syx_memory_gc_begin ();
      context = syx_method_context_new (es->context, method, es->message_receiver,
					syx_array_new (es->message_arguments_count, es->message_arguments));
      syx_memory_gc_end ();
      es->message_arguments = NULL;
    }
  else
    context = syx_method_context_new (es->context, method, es->message_receiver, syx_nil);

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_unary)
{
  SyxOop class, method, context;
  syx_int32 primitive;
  
  es->message_receiver = syx_interp_stack_pop ();

  switch (argument)
    {
    case 0: // isNil
      syx_interp_stack_push (syx_boolean_new (SYX_IS_NIL (es->message_receiver)));
      return TRUE;
    case 1: // notNil
      syx_interp_stack_push (syx_boolean_new (!SYX_IS_NIL (es->message_receiver)));
      return TRUE;
    }

  class = syx_object_get_class (es->message_receiver);
  method = syx_class_lookup_method (class, syx_bytecode_unary_messages[argument]);
  if (SYX_IS_NIL (method))
    {
      syx_signal (SYX_ERROR_NOT_UNDERSTOOD, 0);
      return FALSE;
    }

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send unary message #%s\n", syx_bytecode_unary_messages[argument]);
#endif

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    return syx_interp_call_primitive (primitive, method);

  context = syx_method_context_new (es->context, method, es->message_receiver, syx_nil);

  return syx_interp_enter_context (context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_binary)
{
  SyxOop class, method, context, first_argument, arguments;
  syx_int16 primitive;
  syx_bool ret;

  first_argument = syx_interp_stack_pop ();
  es->message_receiver = syx_interp_stack_pop ();

  if (argument < 8 && SYX_IS_SMALL_INTEGER(es->message_receiver) && SYX_IS_SMALL_INTEGER(first_argument))
    {
      switch (argument)
	{
	case 0: // +
	  syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(es->message_receiver) + SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 1: // -
	  syx_interp_stack_push (syx_small_integer_new (SYX_SMALL_INTEGER(es->message_receiver) - SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 2: // <
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) < SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 3: // >
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) > SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 4: // <=
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) <= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 5: // >=
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) >= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 6: // =
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) == SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 7: // ~=
	  syx_interp_stack_push (syx_boolean_new (SYX_SMALL_INTEGER(es->message_receiver) != SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	}
    }

  class = syx_object_get_class (es->message_receiver);
  method = syx_class_lookup_method (class, syx_bytecode_binary_messages[argument]);
  if (SYX_IS_NIL (method))
    {
      syx_signal (SYX_ERROR_NOT_UNDERSTOOD, 0);
      return FALSE;
    }

#ifdef SYX_DEBUG_BYTECODE
  syx_debug ("BYTECODE - Send binary message #%s\n", syx_bytecode_binary_messages[argument]);
#endif

  primitive = SYX_SMALL_INTEGER (SYX_METHOD_PRIMITIVE (method));
  if (primitive >= 0 && primitive < SYX_PRIMITIVES_MAX)
    {
      if (es->message_arguments)
	syx_free (es->message_arguments);

      es->message_arguments = &first_argument;
      ret = syx_interp_call_primitive (primitive, method);
      es->message_arguments = NULL;
      return ret;
    }

  syx_memory_gc_begin ();

  arguments = syx_array_new_size (1);
  SYX_OBJECT_DATA(arguments)[0] = first_argument;

  context = syx_method_context_new (es->context, method, es->message_receiver, arguments);

  syx_memory_gc_end ();
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
      es->sp--;
      return TRUE;
    case SYX_BYTECODE_SELF_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Self return\n");
#endif
      if (SYX_OOP_EQ (syx_object_get_class (es->context), syx_block_context_class))
	returned_object = syx_interp_stack_pop ();
      else
	returned_object = es->receiver;

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

      // Check for jump to the other conditional branch
      if ((argument == SYX_BYTECODE_BRANCH_IF_TRUE ? SYX_IS_FALSE (condition) : SYX_IS_TRUE (condition)))
	{
	  syx_interp_stack_push (syx_nil);
	  es->ip = jump;
	}
      return TRUE;
    case SYX_BYTECODE_BRANCH:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Branch\n");
#endif
      jump = _syx_interp_get_next_byte ();
      if (jump)
	es->ip = jump;
      return TRUE;
    case SYX_BYTECODE_DUPLICATE:
#ifdef SYX_DEBUG_BYTECODE
      syx_debug ("BYTECODE - Duplicate\n");
#endif
      syx_interp_stack_push (syx_interp_stack_peek ());
      return TRUE;
    case SYX_BYTECODE_SET_DEFINED_CONTEXT:
      SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(syx_interp_stack_peek ()) = es->context;
      return TRUE;
    default:
      syx_signal (SYX_ERROR_INTERP, 0);
      return FALSE;
    }

  return TRUE;
}

static syx_uint16
_syx_interp_get_next_byte (void)
{
#ifdef SYX_DEBUG_TRACE_IP
  syx_debug ("TRACE IP - Context %p fetch at ip %d bytecode: %p\n", es->context, es->ip, es->bytecodes[es->ip]);
#endif

  return es->bytecodes[es->ip++];
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
      syx_interp_push_global,
      syx_interp_push_array,

      syx_interp_assign_instance,
      syx_interp_assign_temporary,

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
