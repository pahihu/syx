#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-bytecode.h"
#include "syx-memory.h"

SyxBytecode *
syx_bytecode_new (void)
{
  SyxBytecode *bytecode;

  bytecode = syx_malloc (sizeof (SyxBytecode));

  bytecode->code = g_byte_array_new ();
  bytecode->literals = g_ptr_array_new ();
  bytecode->stack_size = 0;

  return bytecode;
}

void
syx_bytecode_free (SyxBytecode *bytecode, syx_bool free_segment)
{
  g_byte_array_free (bytecode->code, free_segment);
  g_ptr_array_free (bytecode->literals, free_segment);
  syx_free (bytecode);
}

void
syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint8 low)
{
  if (low >= 16)
    {
      syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_EXTENDED, high);
      syx_bytecode_gen_code (bytecode, low);
    }
  else
    syx_bytecode_gen_code (bytecode, high * 16 + low);
}

void
syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, SyxObject *selector)
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
syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxObject *literal)
{
  syx_uint32 i;
  for (i=0; i < bytecode->literals->len; i++)
    {
      if (bytecode->literals->pdata[i] == literal)
	return i;
    }

  g_ptr_array_add (bytecode->literals, literal);
  return bytecode->literals->len - 1;
}

SYX_FUNC_BYTECODE (gen_code, syx_uint8 value)
{
  g_byte_array_append (bytecode->code, &value, 1);
}

SYX_FUNC_BYTECODE (do_special, SyxBytecodeSpecial special)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_DO_SPECIAL, special);
}

SYX_FUNC_BYTECODE (push_array, syx_uint8 num_elements)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARRAY, num_elements);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_argument, syx_uint8 argument_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARGUMENT, argument_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_temporary, syx_uint8 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_TEMPORARY, temporary_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_literal, SyxObject *instance)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_LITERAL,
				syx_bytecode_gen_literal (bytecode, instance));
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_block_closure, SyxObject *closure)
{
  syx_bytecode_push_literal (bytecode, closure);
  syx_bytecode_do_special (bytecode, SYX_BYTECODE_SET_DEFINED_CONTEXT);
}

SYX_FUNC_BYTECODE (push_instance, syx_uint8 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_INSTANCE, instance_index);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_constant, SyxBytecodeConstant constant)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_CONSTANT, constant);
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (push_global, SyxObject *symbol)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_GLOBAL,
				syx_bytecode_gen_literal (bytecode, symbol));
  bytecode->stack_size++;
}

SYX_FUNC_BYTECODE (assign_temporary, syx_uint8 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_TEMPORARY, temporary_index);
}

SYX_FUNC_BYTECODE (assign_instance, syx_uint8 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_INSTANCE, instance_index);
}

SYX_FUNC_BYTECODE (duplicate_at, syx_int32 index)
{
  syx_uint8 instruction = SYX_BYTECODE_DO_SPECIAL * 16 + SYX_BYTECODE_DUPLICATE;
  g_array_insert_val ((GArray *)bytecode->code, index, instruction);
}

inline void
syx_bytecode_pop_top (SyxBytecode *bytecode)
{
  syx_bytecode_do_special (bytecode, SYX_BYTECODE_POP_TOP);
}
