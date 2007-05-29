#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#ifdef HAVE_JIT

#include <string.h>

#include "syx-object.h"
#include "syx-init.h"
#include "syx-bytecode.h"
#include "syx-instance.h"
#include "syx-class.h"
#include "syx-primitives.h"
#include "syx-basic-types.h"
#include "syx-utils.h"
#include "syx-interp.h"
#include "syx-jit.h"

#include <jit/jit.h>

#define CHECK_SIZE(jt, rt) (jit_type_get_size (jt) == sizeof (rt))

static jit_context_t syx_jit_context;
static jit_type_t syx_jit_method_signature;
static jit_type_t syx_jit_interp_stack_push_signature;
static jit_type_t syx_jit_interp_leave_context_and_answer_signature;
static jit_type_t syx_jit_instance_get_variable_signature;

static jit_type_t syx_jit_type_string;
static jit_type_t syx_jit_type_gtimeval;
static jit_type_t syx_jit_type_object;
static jit_type_t syx_jit_type_instance;
static jit_type_t syx_jit_type_process;

/* Common functions */

inline void
syx_jit_interp_stack_push (jit_function_t func, jit_value_t context, jit_value_t instance)
{
  jit_value_t params[2];
  params[0] = context;
  params[1] = instance;
  jit_insn_call_native (func, "syx_interp_stack_push", (void *)(long)syx_interp_stack_push,
			syx_jit_interp_stack_push_signature, params, 2, JIT_CALL_NOTHROW);
}

inline jit_value_t
syx_jit_instance_get_variable (jit_function_t func, jit_value_t instance, jit_value_t name)
{
  jit_value_t params[2];
  params[0] = instance;
  params[1] = name;
  return jit_insn_call_native (func, "syx_instance_get_variable", (void *)(long)syx_instance_get_variable,
			       syx_jit_instance_get_variable_signature, params, 2, JIT_CALL_NOTHROW);
}

inline jit_value_t
syx_jit_interp_leave_context_and_answer (jit_function_t func, jit_value_t process,
					 jit_value_t return_object, jit_value_t requested_return, jit_value_t requested_return_context)
{
  jit_value_t params[4];
  params[0] = process;
  params[1] = return_object;
  params[2] = requested_return;
  params[3] = requested_return_context;
  return jit_insn_call_native (func, "syx_interp_leave_context_and_answer", (void *)(long)syx_interp_leave_context_and_answer,
			       syx_jit_interp_leave_context_and_answer_signature, params, 4, JIT_CALL_NOTHROW);
}

inline jit_value_t
syx_jit_struct_field_at (jit_function_t func, jit_value_t value, char *name)
{
  jit_type_t value_type = jit_value_get_type (value);
  unsigned int index = jit_type_find_name (value_type, name);
  jit_nuint offset = jit_type_get_offset (value_type, index);
  jit_type_t field_type = jit_type_get_field (value_type, index);
  return jit_insn_load_relative (func, value, offset, field_type);
}

/* Bytecode to low-level code translators */

SYX_FUNC_JIT (syx_jit_push_instance)
{
  SYX_JIT_USE_CONTEXT;
  SYX_JIT_USE_RECEIVER;
  jit_value_t variable;

  const gchar *name = SYX_SYMBOL(method->literals->pdata[argument])->string;
  SYX_JIT_NINT_CONST (name_value, name);
  
  variable = syx_jit_instance_get_variable (func, receiver, name_value);
  syx_jit_interp_stack_push (func, context, variable);
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_argument)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_temporary)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_literal)
{
  SYX_JIT_USE_CONTEXT;

  GPtrArray *literals = method->literals;
  SyxInstance *literal;

  if (argument >= literals->len)
    g_error ("can't find literal at %d\n", argument);

  literal = literals->pdata[argument];
  SYX_JIT_NINT_CONST(literal_value, literal);

  jit_value_t params[2];
  params[0] = context;
  params[1] = literal_value;
  syx_jit_interp_stack_push (func, context, literal_value);
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_constant)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_global)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_push_array)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_assign_instance)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_assign_temporary)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_mark_arguments)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_send_message)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_send_super)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_do_primitive)
{
  return TRUE;
}

SYX_FUNC_JIT (syx_jit_do_special)
{
  switch (argument)
    {
    case SYX_BYTECODE_SELF_RETURN:
      {
	SYX_JIT_USE_PROCESS;
	SYX_JIT_USE_RECEIVER;
	SYX_JIT_NINT_CONST (false_value, FALSE);
	SYX_JIT_NINT_CONST (null_value, NULL);
	syx_jit_interp_leave_context_and_answer (func, process, receiver, false_value, null_value);
      }
      break;
    }
  return TRUE;
}




static guint8 get_byte (SyxMethod *method, long int ip)
{
  guint8 bytecode = method->bytecode->data[ip];
  return bytecode;
}

void
syx_jit_init ()
{
  jit_type_t params[10];

  syx_jit_context = jit_context_create ();

  /* FUNCTIONS */

  /* common method signature */
  params[0] = jit_type_void_ptr;
  params[1] = jit_type_void_ptr;
  params[2] = jit_type_void_ptr;
  params[3] = jit_type_void_ptr;
  syx_jit_method_signature = jit_type_create_signature
    (jit_abi_cdecl, jit_type_nint, params, 4, 1);

  /* syx_interp_stack_push() signature */
  params[0] = jit_type_void_ptr;
  params[1] = jit_type_void_ptr;
  syx_jit_interp_stack_push_signature = jit_type_create_signature
    (jit_abi_cdecl, jit_type_void, params, 2, 1);

  /* syx_interp_leave_context_and_answer() signature */
  params[0] = jit_type_void_ptr;
  params[1] = jit_type_void_ptr;
  params[2] = jit_type_int;
  params[3] = jit_type_void_ptr;
  syx_jit_interp_leave_context_and_answer_signature = jit_type_create_signature
    (jit_abi_cdecl, jit_type_int, params, 4, 1);

  /* syx_instance_get_variable() signature */
  params[0] = jit_type_void_ptr;
  params[1] = jit_type_void_ptr;
  syx_jit_instance_get_variable_signature = jit_type_create_signature
    (jit_abi_cdecl, jit_type_void_ptr, params, 2, 1);

  /* TYPES */

  /* char * */
  syx_jit_type_string = jit_type_create_pointer (jit_type_sys_char, 1);

  /* GTimeVal */
  params[0] = jit_type_nint;
  params[0] = jit_type_nint;
  syx_jit_type_gtimeval = jit_type_create_struct (params, 2, 1);

  /* SyxObject */
  params[0] = jit_type_nint;
  params[1] = jit_type_int;
  params[2] = jit_type_nint;
  params[3] = jit_type_void_ptr;
  syx_jit_type_object = jit_type_create_struct (params, 4, 1);

  /* SyxInstance */
  params[0] = syx_jit_type_object;
  params[1] = jit_type_void_ptr;
  params[2] = jit_type_void_ptr;
  syx_jit_type_instance = jit_type_create_struct (params, 3, 1);

  /* SyxProcess */
  params[0] = syx_jit_type_instance;
  params[1] = jit_type_void_ptr;
  params[2] = jit_type_int;
  params[3] = jit_type_int;
  params[4] = syx_jit_type_gtimeval;
  params[5] = jit_type_void_ptr;
  syx_jit_type_process = jit_type_create_struct (params, 6, 1);

  g_assert (CHECK_SIZE (syx_jit_type_gtimeval, GTimeVal));
  g_assert (CHECK_SIZE (syx_jit_type_object, SyxObject));
  g_assert (CHECK_SIZE (syx_jit_type_instance, SyxInstance));
  g_assert (CHECK_SIZE (syx_jit_type_process, SyxProcess));
}

gboolean
syx_jit_compile (SyxMethod *method)
{
  long int ip;
  guint8 byte, command, argument;
  static SyxJitFunc compilers[] =
    {
      syx_jit_push_instance,
      syx_jit_push_argument,
      syx_jit_push_temporary,
      syx_jit_push_literal,
      syx_jit_push_constant,
      syx_jit_push_global,
      syx_jit_push_array,

      syx_jit_assign_instance,
      syx_jit_assign_temporary,

      syx_jit_mark_arguments,
      syx_jit_send_message,
      syx_jit_send_super,

      syx_jit_do_primitive,
      syx_jit_do_special
    };
  SyxJitFunc compiler;
  jit_function_t func;

  jit_context_build_start (syx_jit_context);
  func = jit_function_create (syx_jit_context, syx_jit_method_signature);

  for (ip=0; ip < method->bytecode->len; ip++)
    {
      byte = get_byte (method, ip);
      command = byte >> 4;
      argument = byte & 0x0F;

      if (command == SYX_BYTECODE_EXTENDED)
	{
	  command = argument;
	  argument = get_byte (method, ++ip);
	}

      if (command > SYX_BYTECODE_EXTENDED)
	g_error ("(JIT) unsupported bytecode: %d\n", command);

      compiler = compilers[command];
      g_assert (compiler (method, func, argument) == TRUE);
    }

  SYX_JIT_NINT_CONST (ret_value, 0);
  jit_insn_return (func, ret_value);
  jit_function_compile (func);
  jit_context_build_end (syx_jit_context);

  method->jit_function = func;
  return TRUE;
}

long int
syx_jit_execute (SyxMethod *method, SyxProcess *process)
{
  g_return_val_if_fail (SYX_OBJECT_IS_METHOD (method) && method->jit_function, -1);
  void *args[4];
  jit_nint result;

  args[0] = &process;
  args[1] = &process->context;
  args[2] = &process->context->receiver;
  args[3] = &process->context->receiver->class;
  jit_function_apply (method->jit_function, args, &result);

  return result;
}

void
syx_jit_free ()
{
  jit_context_destroy (syx_jit_context);
}

#else

void
syx_jit_init ()
{
}

void syx_jit_free ()
{
}

#endif
