#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-bytecode.h"
#include "syx-memory.h"

inline SyxBytecode *
syx_bytecode_new (void)
{
  SyxBytecode *bytecode;

  bytecode = syx_malloc (sizeof (SyxBytecode));
  bytecode->code_top = 0;
  bytecode->literals_top = 0;
  bytecode->stack_size = 0;

  return bytecode;
}

inline void
syx_bytecode_free (SyxBytecode *bytecode, syx_bool free_segment)
{
  syx_free (bytecode);
}

void
syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint16 low)
{
  if (low > 0xFF)
    {
      syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_EXTENDED, high);
      syx_bytecode_gen_code (bytecode, low);
    }
  else
    syx_bytecode_gen_code (bytecode, high * 256 + low);
}

void
syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, SyxOop selector)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_MARK_ARGUMENTS, argument_count);
  if (to_super)
    syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_SUPER,
				  syx_bytecode_gen_literal (bytecode, selector));
  else
    syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_MESSAGE,
				  syx_bytecode_gen_literal (bytecode, selector));
}

syx_uint32
syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxOop literal)
{
  syx_uint16 i;
  for (i=0; i < bytecode->literals_top; i++)
    {
      if (SYX_OOP_EQ (bytecode->literals[i], literal))
	return i;
    }

  bytecode->literals[bytecode->literals_top++] = literal;
  return bytecode->literals_top - 1;
}

SYX_FUNC_BYTECODE (gen_code, syx_uint16 value)
{
  bytecode->code[bytecode->code_top++] = value;
}

SYX_FUNC_BYTECODE (do_special, SyxBytecodeSpecial special)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_DO_SPECIAL, special);
}

SYX_FUNC_BYTECODE (push_array, syx_uint16 num_elements)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARRAY, num_elements);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_argument, syx_uint16 argument_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARGUMENT, argument_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_temporary, syx_uint16 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_TEMPORARY, temporary_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_literal, SyxOop instance)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_LITERAL,
				syx_bytecode_gen_literal (bytecode, instance));
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_block_closure, SyxOop closure)
{
  syx_bytecode_push_literal (bytecode, closure);
  syx_bytecode_do_special (bytecode, SYX_BYTECODE_SET_DEFINED_CONTEXT);
}

SYX_FUNC_BYTECODE (push_instance, syx_uint16 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_INSTANCE, instance_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_constant, SyxBytecodeConstant constant)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_CONSTANT, constant);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_global, SyxOop symbol)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_GLOBAL,
				syx_bytecode_gen_literal (bytecode, symbol));
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (assign_temporary, syx_uint16 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_TEMPORARY, temporary_index);
}

SYX_FUNC_BYTECODE (assign_instance, syx_uint16 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_INSTANCE, instance_index);
}

SYX_FUNC_BYTECODE (duplicate_at, syx_int32 index)
{
  syx_uint8 instruction = SYX_BYTECODE_DO_SPECIAL * 256 + SYX_BYTECODE_DUPLICATE;
  memmove (bytecode->code + index + 1, bytecode->code + index, 0xFFFF - index);
  bytecode->code[index] = instruction;
}

inline void
syx_bytecode_pop_top (SyxBytecode *bytecode)
{
  syx_bytecode_do_special (bytecode, SYX_BYTECODE_POP_TOP);
}
