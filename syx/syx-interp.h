#ifndef SYX_INTERP_H
#define SYX_INTERP_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"

G_BEGIN_DECLS

/* Execution state of a Process */

typedef struct SyxExecState SyxExecState;

struct SyxExecState
{
  SyxObject *process;
  SyxObject *context;
  SyxObject *receiver;
  SyxObject **arguments;
  SyxObject **temporaries;
  SyxObject **stack;
  SyxObject **literals;
  SyxObject **bytecodes;
  syx_int32 bytecodes_count;
  syx_int32 byteslice;
  syx_int32 ip, sp;

  SyxObject *message_receiver;
  SyxObject *message_arguments;
};

/* Primitives */

typedef syx_bool (* SyxPrimitiveFunc) (SyxExecState *es);
#define SYX_FUNC_PRIMITIVE(name)					\
  syx_bool								\
  name (SyxExecState *es)

typedef struct _SyxPrimitiveEntry SyxPrimitiveEntry;

struct _SyxPrimitiveEntry {
  syx_symbol name;
  SyxPrimitiveFunc func;
};

SyxPrimitiveEntry *syx_primitive_get_entry (syx_int32 index);
syx_int32 syx_primitive_get_index (syx_symbol name);

/* Interpreter */

typedef syx_bool (* SyxInterpreterFunc) (SyxExecState *es, syx_uint8 argument);
#define SYX_FUNC_INTERPRETER(name)		\
  syx_bool					\
  name (SyxExecState *es, syx_uint8 argument)

#define syx_exec_state_new() ((SyxExecState *)syx_malloc (sizeof (SyxExecState)))
void syx_exec_state_fetch (SyxExecState *es, SyxObject *process);
void syx_exec_state_save (SyxExecState *es);

syx_bool syx_interp_swap_context (SyxExecState *es, SyxObject *context);
syx_bool syx_interp_enter_context (SyxExecState *es, SyxObject *context);
syx_bool syx_interp_leave_context_and_answer (SyxExecState *es, SyxObject *return_object,
					      syx_bool requested_return, SyxObject *requested_return_context);

void syx_interp_stack_push (SyxObject *context, SyxObject *instance);

/* Process execution */

void syx_process_execute_scheduled (SyxObject *process);
void syx_process_execute_blocking (SyxObject *process);

/* Interpreter functions */

SYX_FUNC_INTERPRETER (syx_interp_push_instance);
SYX_FUNC_INTERPRETER (syx_interp_push_argument);
SYX_FUNC_INTERPRETER (syx_interp_push_temporary);
SYX_FUNC_INTERPRETER (syx_interp_push_literal);
SYX_FUNC_INTERPRETER (syx_interp_push_constant);
SYX_FUNC_INTERPRETER (syx_interp_push_global);
SYX_FUNC_INTERPRETER (syx_interp_push_array);
SYX_FUNC_INTERPRETER (syx_interp_assign_instance);
SYX_FUNC_INTERPRETER (syx_interp_assign_temporary);
SYX_FUNC_INTERPRETER (syx_interp_mark_arguments);
SYX_FUNC_INTERPRETER (syx_interp_send_message);
SYX_FUNC_INTERPRETER (syx_interp_send_super);
SYX_FUNC_INTERPRETER (syx_interp_do_primitive);
SYX_FUNC_INTERPRETER (syx_interp_do_special);

G_END_DECLS

#endif
