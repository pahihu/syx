#ifndef _SYX_BYTECODE_H
#define _SYX_BYTECODE_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"

/*!
  \page syx_bytecode Syx Bytecode
  Binary representation of a bytecode. Command is b while the argument is k.
  
  bbbbbkkk kkkkkkkk
*/

//! Number of bits used for a bytecode
#define SYX_BYTECODE_BITS 16

//! The total length of an instruction
#define SYX_BYTECODE_MAX ((1 << SYX_BYTECODE_BITS) - 1)

//! Bits used to represent a command into a bytecode
#define SYX_BYTECODE_COMMAND_BITS 5
//! Max number of commands
#define SYX_BYTECODE_COMMAND_MAX ((1 << SYX_BYTECODE_COMMAND_BITS) - 1)
//! A mask to be used with bit-wise AND to retrieve the command from a bytecode
#define SYX_BYTECODE_COMMAND_MASK (SYX_BYTECODE_COMMAND_MAX << (SYX_BYTECODE_BITS - SYX_BYTECODE_COMMAND_BITS))

//! Bits used to represent an argument into a bytecode
#define SYX_BYTECODE_ARGUMENT_BITS (SYX_BYTECODE_BITS - SYX_BYTECODE_COMMAND_BITS)
//! Max value of an argument
#define SYX_BYTECODE_ARGUMENT_MAX ((1 << SYX_BYTECODE_ARGUMENT_BITS) - 1)
//! A mask to be used with bit-wise AND to retrieve the command from a bytecode
#define SYX_BYTECODE_ARGUMENT_MASK (SYX_BYTECODE_ARGUMENT_MAX)

extern syx_symbol syx_bytecode_unary_messages[];
extern syx_symbol syx_bytecode_binary_messages[];

#define SYX_FUNC_BYTECODE(name,arg)		\
  inline void syx_bytecode_ ## name (SyxBytecode *bytecode, arg)

typedef struct SyxBytecode SyxBytecode;

//! A struct containing method bytecodes and literals
struct SyxBytecode {
  syx_uint16 code[SYX_BYTECODE_MAX + 1];
  syx_uint16 code_top;
  SyxOop literals[SYX_BYTECODE_MAX + 1];
  syx_uint16 literals_top;

  //! Total number of objects that the method can push into the stack
  syx_int32 stack_size;
};

inline SyxBytecode *syx_bytecode_new (void);
inline void syx_bytecode_free (SyxBytecode *bytecode);

void syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint16 low);
void syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, syx_symbol selector);
syx_uint32 syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxOop literal);

//! Puts the bytecode into the code array and increment the code top. It's automatically called from syx_bytecode_gen_instruction
SYX_FUNC_BYTECODE (gen_code, syx_uint16 value);

//! Does a special operation. The command of the instruction is SYX_BYTECODE_DO_SPECIAL and its argument is the operation to be performed
SYX_FUNC_BYTECODE (do_special, SyxBytecodeSpecial special);

//! Does SYX_BYTECODE_PUSH_ARRAY specifying the number of elements to be obtained from the stack at runtime
SYX_FUNC_BYTECODE (push_array, syx_uint16 num_elements);

//! Does SYX_BYTECODE_PUSH_ARGUMENT specifying the index of the argument in the runtime context
SYX_FUNC_BYTECODE (push_argument, syx_uint16 argument_index);

//! Does SYX_BYTECODE_PUSH_TEMPORARY specifying the index of the temporary in the runtime context
SYX_FUNC_BYTECODE (push_temporary, syx_uint16 temporary_index);

//! Does SYX_BYTECODE_PUSH_LITERAL by directly specifying the oop
SYX_FUNC_BYTECODE (push_literal, SyxOop instance);

//! Push the closure literal and does special SYX_BYTECODE_SET_DEFINED_CONTEXT
SYX_FUNC_BYTECODE (push_block_closure, SyxOop closure);

//! Does SYX_BYTECODE_PUSH_INSTANCE to push an instance variable of the receiver at a given index
SYX_FUNC_BYTECODE (push_instance, syx_uint16 instance_index);

//! Does SYX_BYTECODE_PUSH_CONSTANT
SYX_FUNC_BYTECODE (push_constant, SyxBytecodeConstant constant);

//! Does SYX_BYTECODE_PUSH_GLOBAL by specifying the symbol to be resolved at runtime
SYX_FUNC_BYTECODE (push_global, SyxOop symbol);

//! Does SYX_BYTECODE_ASSIGN_TEMPORARY
SYX_FUNC_BYTECODE (assign_temporary, syx_uint16 temporary_index);

//! Does SYX_BYTECODE_ASSIGN_INSTANCE
SYX_FUNC_BYTECODE (assign_instance, syx_uint16 instance_index);

//! Does SYX_BYTECODE_DUPLICATE at a given code array position
/*!
  Take care this operation moves the code by 1 entry on the right and increases the code_top
*/
SYX_FUNC_BYTECODE (duplicate_at, syx_int32 index);

//! Does SYX_BYTECODE_POP_TOP
inline void syx_bytecode_pop_top (SyxBytecode *bytecode);

#endif /* _SYX_BYTECODE_H */
