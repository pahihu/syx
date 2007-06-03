#ifndef SYX_JIT_H
#define SYX_JIT_H

#include "syx-class.h"
#include "syx-basic-types.h"

#include <jit/jit.h>

#ifdef HAVE_JIT

typedef gboolean (* SyxJitFunc) (SyxMethod *method, jit_function_t func, guint8 argument);
#define SYX_FUNC_JIT(name)						\
  gboolean								\
  name (SyxMethod *method, jit_function_t func, guint8 argument)

#define SYX_JIT_NINT_CONST(name, constant)				\
  jit_value_t name = jit_value_create_nint_constant (func, jit_type_nint, (jit_nint) constant)

#define SYX_JIT_USE_PROCESS jit_value_t process = jit_value_get_param (func, 0);
#define SYX_JIT_USE_CONTEXT jit_value_t context = jit_value_get_param (func, 1);
#define SYX_JIT_USE_RECEIVER jit_value_t receiver = jit_value_get_param (func, 2);
#define SYX_JIT_USE_CLASS jit_value_t class = jit_value_get_param (func, 3);

#endif /* HAVE_JIT */

void syx_jit_init ();
void syx_jit_free ();
gboolean syx_jit_compile (SyxMethod *method);
long int syx_jit_execute (SyxMethod *method, SyxProcess *process);

#endif /* SYX_JIT_H */
