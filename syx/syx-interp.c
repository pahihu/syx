#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-interp.h"
#include "syx-object.h"
#include "syx-utils.h"
#include "syx-scheduler.h"
#include "syx-init.h"

//#define SYX_DEBUG_CONTEXT
//#define SYX_DEBUG_CONTEXT_STACK
//#define SYX_DEBUG_BYTECODE
//#define SYX_DEBUG_TRACE_IP
//#define SYX_DEBUG_BYTECODE_PROFILE

static syx_uint8 _syx_interp_get_next_byte (SyxExecState *es);

#define syx_interp_stack_push(es, ptr) (es->stack[es->sp++] = ptr)
#define syx_interp_stack_pop(es) (es->stack[es->sp-- - 1])
#define syx_interp_stack_peek(es) (es->stack[es->sp-1])

syx_bool
syx_interp_swap_context (SyxExecState *es, SyxObject *context)
{
#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Swap context %p with new %p\n", es->context, context);
#endif
  SYX_METHOD_CONTEXT_IP(es->context) = syx_small_integer_new (es->ip);
  SYX_METHOD_CONTEXT_SP(es->context) = syx_small_integer_new (es->sp);
  SYX_PROCESS_CONTEXT(es->process) = es->context = context;
  return !SYX_IS_NIL (context);
}

syx_bool
syx_interp_leave_context_and_answer (SyxExecState *es, SyxObject *return_object, syx_bool requested_return, SyxObject *requested_return_context)
{
  SyxObject *return_context = requested_return ? requested_return_context : SYX_METHOD_CONTEXT_PARENT (es->context);

#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Requested return context: %p (requested? %d). Push object: %p\n", requested_return_context, requested_return, return_object);
#endif

  SYX_PROCESS_RETURNED_OBJECT(es->process) = return_object;
  if (!syx_interp_swap_context (es, return_context))
    {
      syx_interp_stack_push (es, return_object);
      return FALSE;
    }

  syx_scheduler_remove_process (es->process); /* The process have no contexts anymore */
  return TRUE;
}

syx_bool
syx_interp_enter_context (SyxExecState *es, SyxObject *context)
{
#ifdef SYX_DEBUG_CONTEXT
  g_debug ("CONTEXT - Enter context\n");
#endif
  return syx_interp_swap_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_push_instance)
{
  syx_interp_stack_push (es, SYX_OBJECT_DATA(es->receiver)[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_argument)
{
  syx_interp_stack_push (es, es->arguments[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_temporary)
{
  syx_interp_stack_push (es, es->temporaries[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_literal)
{
  syx_interp_stack_push (es, es->literals[argument]);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_constant)
{
  if (argument < SYX_BYTECODE_CONST_CONTEXT)
    syx_interp_stack_push (es, SYX_POINTER(argument));
  else if (argument == SYX_BYTECODE_CONST_CONTEXT)
    syx_interp_stack_push (es, es->context);
  else
    g_error ("unknown constant %d\n", argument);
  
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_push_global)
{
  syx_symbol symbol;
  SyxObject *object;

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
  SyxObject *array;
  syx_uint8 i;

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
  SYX_OBJECT_DATA(es->receiver)[argument] = syx_interp_stack_peek (es);
  return TRUE;
}

SYX_FUNC_INTERPRETER (syx_interp_assign_temporary)
{
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
  SyxObject *class, *method, *context;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = syx_object_get_class (es->message_receiver);
  method = syx_class_lookup_method (class, selector);
  if (SYX_IS_NIL (method))
    g_error ("%s doesn't respond to #%s\n",
	     SYX_OBJECT_SYMBOL (SYX_CLASS_NAME(class)),
	     selector);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send message %s\n", selector);
#endif

  context = syx_method_context_new (es->context, method, es->message_receiver, es->message_arguments);
  return syx_interp_enter_context (es, context);
}

SYX_FUNC_INTERPRETER (syx_interp_send_super)
{
  syx_symbol selector;
  SyxObject *class, *method, *context;

  selector = SYX_OBJECT_SYMBOL (es->literals[argument]);
  class = SYX_CLASS_SUPERCLASS (syx_object_get_class (es->message_receiver));
  method = syx_class_lookup_method (class, selector);

  if (SYX_IS_NIL (method))
    g_error ("%s doesn't respond to #%s\n",
	     SYX_OBJECT_SYMBOL (SYX_CLASS_NAME (class)),
	     selector);

#ifdef SYX_DEBUG_BYTECODE
  g_debug ("BYTECODE - Send message %s\n", selector);
#endif

  context = syx_method_context_new (es->context, method, es->message_receiver, es->message_arguments);
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
  SyxObject *returned_object, *return_context=SYX_NIL;
  syx_bool requested_return = FALSE;
  SyxObject *condition;
  syx_uint8 jump;

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
      if (syx_object_get_class (es->context) == syx_block_context_class)
	returned_object = syx_interp_stack_pop (es);
      else
	returned_object = es->receiver;

      return syx_interp_leave_context_and_answer (es, returned_object, FALSE, SYX_NIL);
    case SYX_BYTECODE_STACK_RETURN:
#ifdef SYX_DEBUG_BYTECODE
      g_debug ("BYTECODE - Stack return\n");
#endif
      returned_object = syx_interp_stack_pop (es);
      if (syx_object_get_class (es->context) == syx_block_context_class)
	{
	  return_context = SYX_BLOCK_CONTEXT_RETURN_CONTEXT (es->context);
	  requested_return = TRUE;
	}
      return syx_interp_leave_context_and_answer (es, returned_object, requested_return, return_context);
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

static syx_uint8
_syx_interp_get_next_byte (SyxExecState *es)
{
#ifdef SYX_DEBUG_TRACE_IP
  g_debug ("TRACE IP - Context %p fetch at ip %d bytecode: %d\n", es->context.addr, es->ip, es->bytecodes[es->ip++]);
#endif

  return SYX_SMALL_INTEGER (es->bytecodes[es->ip++]);
}

static syx_bool
_syx_interp_execute_byte (SyxExecState *es, syx_uint8 byte)
{
  syx_uint8 command, argument;
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

      syx_interp_do_primitive,
      syx_interp_do_special
    };
  SyxInterpreterFunc handler;
  syx_bool res;

  command = byte >> 4;
  argument = byte & 0x0F;

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
syx_exec_state_fetch (SyxExecState *es, SyxObject *process)
{
  SyxObject *method;
  es->process = process;
  es->context = SYX_PROCESS_CONTEXT (process);
  method = SYX_METHOD_CONTEXT_METHOD (es->context);

  es->receiver = SYX_METHOD_CONTEXT_RECEIVER (es->context);
  es->arguments = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_ARGUMENTS (es->context));
  es->temporaries = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_TEMPORARIES (es->context));
  es->stack = SYX_OBJECT_DATA (SYX_METHOD_CONTEXT_STACK (es->context));
  es->literals = SYX_OBJECT_DATA (SYX_METHOD_LITERALS (method));
  es->bytecodes = SYX_OBJECT_DATA (SYX_METHOD_BYTECODES (method));
  es->bytecodes_count = SYX_OBJECT_SIZE (SYX_METHOD_BYTECODES (method));
  es->byteslice = SYX_SMALL_INTEGER (syx_processor_byteslice);
  es->ip = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_IP (es->context));
  es->sp = SYX_SMALL_INTEGER (SYX_METHOD_CONTEXT_SP (es->context));
}

void
syx_exec_state_save (SyxExecState *es)
{
}

void
syx_process_execute_scheduled (SyxObject *process)
{
  syx_uint8 byte;
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
}

void
syx_process_execute_blocking (SyxObject *process)
{
  syx_uint8 byte;
  SyxExecState *es;

  es = syx_exec_state_new ();
  syx_exec_state_fetch (es, process);

  while (es->ip < es->bytecodes_count)
    {
      byte = _syx_interp_get_next_byte (es);
      if (!_syx_interp_execute_byte (es, byte))
	{
	  syx_exec_state_save (es);
	  return;
	}
    }
}
