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

//#define SYX_DEBUG_CONTEXT
//#define SYX_DEBUG_CONTEXT_STACK
//#define SYX_DEBUG_BYTECODE
//#define SYX_DEBUG_TRACE_IP
//#define SYX_DEBUG_BYTECODE_PROFILE

static syx_uint16 _syx_interp_get_next_byte (SyxExecState *es);

inline void
syx_interp_stack_push (SyxExecState *es, SyxOop object)
{
#ifdef SYX_DEBUG_CONTEXT_STACK
  g_debug ("CONTEXT STACK - Push %p\n", object);
#endif
  es->stack[es->sp++] = object;
}

inline SyxOop 
syx_interp_stack_pop (SyxExecState *es)
{
#ifdef SYX_DEBUG_CONTEXT_STACK
  g_debug ("CONTEXT STACK - Pop %p\n", es->stack[es->sp - 1]);
#endif
  return es->stack[--es->sp];
}

inline SyxOop 
syx_interp_stack_peek (SyxExecState *es)
{
  return es->stack[es->sp - 1];
}

inline syx_bool
syx_interp_swap_context (SyxExecState *es, SyxOop context)
{
#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Swap context %p with new %p\n", es->context, context);
#endif
  es->context = context;
  syx_exec_state_save (es);
  syx_exec_state_fetch (es, es->process);
  return !SYX_IS_NIL (context);
}

inline syx_bool
syx_interp_leave_context_and_answer (SyxExecState *es, SyxOop return_object, syx_bool use_return_context)
{
  SyxOop return_context = use_return_context ? SYX_METHOD_CONTEXT_RETURN_CONTEXT(es->context) : SYX_METHOD_CONTEXT_PARENT(es->context);
#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Leave context and answer: %p use return context: %d\n",
	   return_object, use_return_context);
#endif

  SYX_PROCESS_RETURNED_OBJECT(es->process) = return_object;
  if (syx_interp_swap_context (es, return_context))
    {
      syx_interp_stack_push (es, return_object);
      return TRUE;
    }

  syx_scheduler_remove_process (es->process); /* The process have no contexts anymore */
  return FALSE;
}

inline syx_bool
syx_interp_enter_context (SyxExecState *es, SyxOop context)
{
#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Enter context\n");
#endif
  return syx_interp_swap_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_push_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push instance at %d\n", argument);
#endif
  syx_interp_stack_push (es, SYX_OBJECT_DATA(es->receiver)[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_argument)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push argument at %d\n", argument);
#endif
  if (argument == 0)
    syx_interp_stack_push (es, es->receiver);
  else
    syx_interp_stack_push (es, es->arguments[argument - 1]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push temporary at %d\n", argument);
#endif
  syx_interp_stack_push (es, es->temporaries[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_literal)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push literal at %d\n", argument);
#endif
  syx_interp_stack_push (es, es->literals[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_constant)
{
  SyxOop constant;
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push constant %d\n", argument);
#endif
  if (argument < SYX_BYTECODE_CONST_CONTEXT)
    {
      constant.idx = argument;
      syx_interp_stack_push (es, constant);
    }
  else if (argument == SYX_BYTECODE_CONST_CONTEXT)
    syx_interp_stack_push (es, es->context);
  else
    g_error ("unknown constant %d\n", argument);
  
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_global)
{
  syx_symbol symbol;
  SyxOop object;

  symbol = SYX_OBJECT_SYMBOL (es->literals[argument]);
  object = syx_globals_at (symbol);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push global: '%s'\n", symbol);
#endif

  syx_interp_stack_push (es, object);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_array)
{
  SyxOop array;
  syx_uint16 i;

  array = syx_array_new_size (argument);
  for (i=1; i <= argument; i++)
    SYX_OBJECT_DATA(array)[argument - i] = syx_interp_stack_pop (es);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Push array of elements: %d\n", argument);
#endif

  syx_interp_stack_push (es, array);

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_instance)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Assign instance at %d\n", argument);
#endif
  SYX_OBJECT_DATA(es->receiver)[argument] = syx_interp_stack_peek (es);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_temporary)
{
#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Assign temporary at %d\n", argument);
#endif
  es->temporaries[argument] = syx_interp_stack_peek (es);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_mark_arguments)
{
  syx_varsize i;

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Mark arguments %d + receiver\n", argument);
#endif

  es->message_arguments = syx_array_new_size (argument);
  for (i=argument - 1; i >= 0; i--)
    SYX_OBJECT_DATA(es->message_arguments)[i] = syx_interp_stack_pop (es);

  es->message_receiver = syx_interp_stack_pop (es);

  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_send_message)
{
  syx_symbol selector;
  SyxOop class, method, context;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = syx_object_get_class (es->message_receiver);
  method = syx_class_lookup_method (class, selector);
  if (SYX_IS_NIL (method))
    g_error ("Class at %p doesn't respond to #%s\n", class, selector);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send message #%s\n", selector);
#endif

  context = syx_method_context_new (es->context, method, es->message_receiver, es->message_arguments);
  return syx_interp_enter_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_super)
{
  syx_symbol selector;
  SyxOop class, method, context;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = SYX_CLASS_SUPERCLASS (syx_object_get_class (es->message_receiver));
  method = syx_class_lookup_method (class, selector);

  if (SYX_IS_NIL (method))
    g_error ("Superclass at %p doesn't respond to #%s\n", class, selector);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send message #%s to super\n", selector);
#endif

  context = syx_method_context_new (es->context, method, es->message_receiver, es->message_arguments);
  return syx_interp_enter_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_unary)
{
  SyxOop class, method, context, receiver;
  
  receiver = syx_interp_stack_pop (es);

  switch (argument)
    {
    case 0: // isNil
      syx_interp_stack_push (es, syx_boolean_new (SYX_IS_NIL (receiver)));
      return TRUE;
    case 1: // notNil
      syx_interp_stack_push (es, syx_boolean_new (!SYX_IS_NIL (receiver)));
      return TRUE;
    }
  
  class = syx_object_get_class (receiver);
  method = syx_class_lookup_method (class, syx_bytecode_unary_messages[argument]);

  if (SYX_IS_NIL (method))
    g_error ("Class at %p doesn't respond to known unary #%s\n", class, syx_bytecode_unary_messages[argument]);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send unary message #%s\n", syx_bytecode_unary_messages[argument]);
#endif

  context = syx_method_context_new (es->context, method, receiver, syx_array_new_size (0));
  return syx_interp_enter_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_binary)
{
  SyxOop class, method, context, receiver, first_argument, arguments;

  first_argument = syx_interp_stack_pop (es);
  receiver = syx_interp_stack_pop (es);

  if (argument < 8 && SYX_IS_SMALL_INTEGER(receiver) && SYX_IS_SMALL_INTEGER(first_argument))
    {
      switch (argument)
	{
	case 0: // +
	  syx_interp_stack_push (es, syx_small_integer_new (SYX_SMALL_INTEGER(receiver) + SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 1: // -
	  syx_interp_stack_push (es, syx_small_integer_new (SYX_SMALL_INTEGER(receiver) - SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 2: // <
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) < SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 3: // >
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) > SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 4: // <=
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) <= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 5: // >=
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) >= SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 6: // =
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) == SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	case 7: // ~=
	  syx_interp_stack_push (es, syx_boolean_new (SYX_SMALL_INTEGER(receiver) != SYX_SMALL_INTEGER(first_argument)));
	  return TRUE;
	}
    }

  class = syx_object_get_class (receiver);
  method = syx_class_lookup_method (class, syx_bytecode_binary_messages[argument]);

  if (SYX_IS_NIL (method))
    g_error ("Class at %p doesn't respond to known binary #%s\n", class, syx_bytecode_unary_messages[argument]);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send binary message #%s\n", syx_bytecode_unary_messages[argument]);
#endif

  arguments = syx_array_new_size (1);
  SYX_OBJECT_DATA(arguments)[0] = first_argument;

  context = syx_method_context_new (es->context, method, receiver, arguments);
  return syx_interp_enter_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_do_primitive)
{
  SyxPrimitiveEntry *prim_entry;

  prim_entry = syx_primitive_get_entry (argument);
  if (!prim_entry)
    g_error ("can't find primitive number %d\n", argument);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Do primitive %d (%s)\n", argument, prim_entry->name);
#endif

  return prim_entry->func (es);
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
      g_debug ("BYTECODE - Pop top\n");
#endif
      es->sp--;
      return TRUE;
    case SYX_BYTECODE_SELF_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Self return\n");
#endif
      if (SYX_OOP_EQ (syx_object_get_class (es->context), syx_block_context_class))
	returned_object = syx_interp_stack_pop (es);
      else
	returned_object = es->receiver;

      return syx_interp_leave_context_and_answer (es, returned_object, FALSE);
    case SYX_BYTECODE_STACK_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Stack return\n");
#endif
      returned_object = syx_interp_stack_pop (es);
      return syx_interp_leave_context_and_answer (es, returned_object, TRUE);
    case SYX_BYTECODE_BRANCH_IF_TRUE:
    case SYX_BYTECODE_BRANCH_IF_FALSE:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Conditional\n");
#endif
      condition = syx_interp_stack_pop (es);
      jump = _syx_interp_get_next_byte (es);
      // Check for jump to the other conditional branch

      if ((argument == SYX_BYTECODE_BRANCH_IF_TRUE ? SYX_IS_FALSE (condition) : SYX_IS_TRUE (condition)))
	{
	  syx_interp_stack_push (es, SYX_NIL);
	  es->ip = jump;
	}
      return TRUE;
    case SYX_BYTECODE_BRANCH:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Branch\n");
#endif
      jump = _syx_interp_get_next_byte (es);
      if (jump)
	es->ip = jump;
      return TRUE;
    case SYX_BYTECODE_DUPLICATE:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Duplicate\n");
#endif
      syx_interp_stack_push (es, syx_interp_stack_peek (es));
      return TRUE;
    case SYX_BYTECODE_SET_DEFINED_CONTEXT:
      SYX_BLOCK_CLOSURE_DEFINED_CONTEXT(syx_interp_stack_peek (es)) = es->context;
      return TRUE;
    default:
      g_error ("unknown special bytecode: %d\n", argument);
    }

  return TRUE;
}

#define _syx_interp_should_yield(es) (es->ip >= es->bytecodes_count || es->byteslice <= 0)

static syx_uint16
_syx_interp_get_next_byte (SyxExecState *es)
{
#ifdef SYX_DEBUG_TRACE_IP
  g_debug ("TRACE IP - Context %p fetch at ip %d bytecode: %p\n", es->context, es->ip, es->bytecodes[es->ip]);
#endif

  return es->bytecodes[es->ip++];
}

static syx_bool
_syx_interp_execute_byte (SyxExecState *es, syx_uint16 byte)
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

      syx_interp_do_primitive,
      syx_interp_do_special
    };
  SyxInterpreterFunc handler;
  syx_bool res;

  command = byte >> 8;
  argument = byte & 0xFF;

  if (command == SYX_BYTECODE_EXTENDED)
    {
      command = argument;
      argument = _syx_interp_get_next_byte (es);
    }

  if (command > SYX_BYTECODE_EXTENDED)
    g_error ("unsupported bytecode: %d\n", command);

  handler = handlers[command];

#ifdef SYX_DEBUG_BYTECODE_PROFILE
  GTimer *timer = g_timer_new ();
#endif

  res = handler (es, argument);

#ifdef SYX_DEBUG_BYTECODE_PROFILE
  g_timer_stop (timer);
  g_debug("BYTECODE PROFILE - Command %d with arguments %d: %fs\n", command, argument, g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);
#endif
  
  return res;
}

void
syx_exec_state_fetch (SyxExecState *es, SyxOop process)
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

inline void
syx_exec_state_save (SyxExecState *es)
{
  SyxOop context = SYX_PROCESS_CONTEXT (es->process);
  if (!SYX_IS_NIL (context))
    {
      SYX_METHOD_CONTEXT_IP(context) = syx_small_integer_new (es->ip);
      SYX_METHOD_CONTEXT_SP(context) = syx_small_integer_new (es->sp);
    }
  SYX_PROCESS_CONTEXT(es->process) = es->context;
}

inline void
syx_exec_state_free (SyxExecState *es)
{
  syx_free (es);
}

void
syx_process_execute_scheduled (SyxOop process)
{
  syx_uint16 byte;
  SyxExecState *es;
  
  es = syx_exec_state_new ();
  syx_exec_state_fetch (es, process);

  while (!_syx_interp_should_yield (es))
    {
      byte = _syx_interp_get_next_byte (es);
      if (!_syx_interp_execute_byte (es, byte))
	{
	  syx_exec_state_save (es);
	  return;
	}
    }

  syx_exec_state_save (es);
  syx_exec_state_free (es);
}

void
syx_process_execute_blocking (SyxOop process)
{
  syx_uint16 byte;
  SyxExecState *es;

  syx_processor_active_process = process; // this is a bad fix, will change it later
  es = syx_exec_state_new ();
  syx_exec_state_fetch (es, process);

  while (es->ip < es->bytecodes_count)
    {
      byte = _syx_interp_get_next_byte (es);
      if (!_syx_interp_execute_byte (es, byte))
	break;
    }

  syx_exec_state_save (es);
  syx_exec_state_free (es);
}
