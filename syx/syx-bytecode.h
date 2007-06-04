#ifndef _SYX_BYTECODE_H
#define _SYX_BYTECODE_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"

#define SYX_FUNC_BYTECODE(name,arg)		\
  inline void syx_bytecode_ ## name (SyxBytecode *bytecode, arg)

typedef struct SyxBytecode SyxBytecode;

struct SyxBytecode {
  syx_uint8 code[256];
  syx_uint8 code_top;
  SyxOop literals[256];
  syx_uint8 literals_top;
  syx_int32 stack_size;
};

inline SyxBytecode *syx_bytecode_new (void);
inline void syx_bytecode_free (SyxBytecode *bytecode, syx_bool free_segment);

void syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint8 low);
void syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, SyxOop selector);
syx_uint32 syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxOop literal);

SYX_FUNC_BYTECODE (gen_code, syx_uint8 value);
SYX_FUNC_BYTECODE (do_special, SyxBytecodeSpecial special);
SYX_FUNC_BYTECODE (push_array, syx_uint8 num_elements);
SYX_FUNC_BYTECODE (push_argument, syx_uint8 argument_index);
SYX_FUNC_BYTECODE (push_temporary, syx_uint8 temporary_index);
SYX_FUNC_BYTECODE (push_literal, SyxOop instance);
SYX_FUNC_BYTECODE (push_block_closure, SyxOop closure);
SYX_FUNC_BYTECODE (push_instance, syx_uint8 instance_index);
SYX_FUNC_BYTECODE (push_constant, SyxBytecodeConstant constant);
SYX_FUNC_BYTECODE (push_global, SyxOop symbol);
SYX_FUNC_BYTECODE (assign_temporary, syx_uint8 temporary_index);
SYX_FUNC_BYTECODE (assign_instance, syx_uint8 instance_index);
SYX_FUNC_BYTECODE (duplicate_at, syx_int32 index);
inline void syx_bytecode_pop_top (SyxBytecode *bytecode);

#endif /* _SYX_BYTECODE_H */
