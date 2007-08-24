/* 
   Copyright (c) 2007 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#ifndef _SYX_BYTECODE_H
#define _SYX_BYTECODE_H

#include "syx-types.h"
#include "syx-object.h"
#include "syx-memory.h"

SYX_BEGIN_DECLS

/*!
  \page syx_bytecode Syx Bytecode
  Binary representation of a bytecode. Command is b while the argument is k.
  
  bbbbbkkk kkkkkkkk
*/

/*! Number of bits used for a bytecode */
#define SYX_BYTECODE_BITS 16

/*! The total length of an instruction */
#define SYX_BYTECODE_MAX ((1 << SYX_BYTECODE_BITS) - 1)

/*! Bits used to represent a command into a bytecode */
#define SYX_BYTECODE_COMMAND_BITS 5
/*! Max number of commands */
#define SYX_BYTECODE_COMMAND_MAX ((1 << SYX_BYTECODE_COMMAND_BITS) - 1)
/*! A mask to be used with bit-wise AND to retrieve the command from a bytecode */
#define SYX_BYTECODE_COMMAND_MASK (SYX_BYTECODE_COMMAND_MAX << (SYX_BYTECODE_BITS - SYX_BYTECODE_COMMAND_BITS))

/*! Bits used to represent an argument into a bytecode */
#define SYX_BYTECODE_ARGUMENT_BITS (SYX_BYTECODE_BITS - SYX_BYTECODE_COMMAND_BITS)
/*! Max value of an argument */
#define SYX_BYTECODE_ARGUMENT_MAX ((1 << SYX_BYTECODE_ARGUMENT_BITS) - 1)
/*! A mask to be used with bit-wise AND to retrieve the command from a bytecode */
#define SYX_BYTECODE_ARGUMENT_MASK (SYX_BYTECODE_ARGUMENT_MAX)

extern syx_symbol syx_bytecode_unary_messages[];
extern syx_symbol syx_bytecode_binary_messages[];

#define SYX_FUNC_BYTECODE(name,arg)		\
  INLINE void syx_bytecode_ ## name (SyxBytecode *bytecode, arg)

typedef struct SyxBytecode SyxBytecode;

/*! A struct containing method bytecodes and literals */
struct SyxBytecode {
  /*! Hold 16-bit wide bytecodes */
  syx_uint16 code[SYX_BYTECODE_MAX + 1];
  syx_uint16 code_top;
  /*! An Array of literals */
  SyxOop literals[SYX_BYTECODE_MAX + 1];
  syx_uint16 literals_top;

  /*! Total number of objects that the method can push into the stack */
  syx_int32 stack_size;
};

EXPORT extern SyxBytecode *syx_bytecode_new (void);

/*!
  Frees the memory allocated for a SyxBytecode by syx_bytecode_new.

  \param bytecode the SyxBytecode to be freed
*/
INLINE void
syx_bytecode_free (SyxBytecode *bytecode)
{
  syx_free (bytecode);
}

EXPORT extern void syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint16 low);
EXPORT extern void syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, syx_symbol selector);
EXPORT extern syx_uint32 syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxOop literal);

/*! Puts the bytecode into the code array and increment the code top. It's automatically called from syx_bytecode_gen_instruction */
SYX_FUNC_BYTECODE (gen_code, syx_uint16 value)
{
  bytecode->code[bytecode->code_top++] = SYX_COMPAT_SWAP_16 (value);
}

/*! Does a special operation. The command of the instruction is SYX_BYTECODE_DO_SPECIAL and its argument is the operation to be performed */
SYX_FUNC_BYTECODE (do_special, SyxBytecodeSpecial special)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_DO_SPECIAL, special);
}

/*! Does SYX_BYTECODE_PUSH_ARRAY specifying the number of elements to be obtained
  from the stack at runtime */
SYX_FUNC_BYTECODE (push_array, syx_uint16 num_elements)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARRAY, num_elements);
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_ARGUMENT specifying the index of the argument in the runtime context */
SYX_FUNC_BYTECODE (push_argument, syx_uint16 argument_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_ARGUMENT, argument_index);
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_TEMPORARY specifying the index of the temporary in the runtime context */
SYX_FUNC_BYTECODE (push_temporary, syx_uint16 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_TEMPORARY, temporary_index);
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_LITERAL by directly specifying the oop */
SYX_FUNC_BYTECODE (push_literal, SyxOop instance)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_LITERAL,
				syx_bytecode_gen_literal (bytecode, instance));
  bytecode->stack_size++;
}

/*! Push the closure literal and does special SYX_BYTECODE_SET_DEFINED_CONTEXT */
SYX_FUNC_BYTECODE (push_block_closure, SyxOop closure)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_BLOCK_CLOSURE,
				syx_bytecode_gen_literal (bytecode, closure));
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_INSTANCE to push an instance variable of the receiver at a given index */
SYX_FUNC_BYTECODE (push_instance, syx_uint16 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_INSTANCE, instance_index);
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_CONSTANT */
SYX_FUNC_BYTECODE (push_constant, SyxBytecodeConstant constant)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_CONSTANT, constant);
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_PUSH_BINDING_VARIABLE by specifying a VariableBinding instance of a Dictionary */
SYX_FUNC_BYTECODE (push_binding_variable, SyxOop assoc)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_PUSH_BINDING_VARIABLE,
				syx_bytecode_gen_literal (bytecode, assoc));
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_ASSIGN_TEMPORARY */
SYX_FUNC_BYTECODE (assign_temporary, syx_uint16 temporary_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_TEMPORARY, temporary_index);
}

/*! Does SYX_BYTECODE_ASSIGN_INSTANCE */
SYX_FUNC_BYTECODE (assign_instance, syx_uint16 instance_index)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_INSTANCE, instance_index);
}

/*! Does SYX_BYTECODE_ASSIGN_BINDING_VARIABLE */
SYX_FUNC_BYTECODE (assign_binding_variable, SyxOop link)
{
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_ASSIGN_BINDING_VARIABLE,
				syx_bytecode_gen_literal (bytecode, link));
}

/*!
  Does SYX_BYTECODE_DUPLICATE at a given code array position.

  This operation moves the code by 1 entry on the right, increases the code_top and the stack_size
*/
SYX_FUNC_BYTECODE (duplicate_at, syx_int32 index)
{
  syx_uint16 instruction = (SYX_BYTECODE_DO_SPECIAL << SYX_BYTECODE_ARGUMENT_BITS) + SYX_BYTECODE_DUPLICATE;
  memmove (bytecode->code + index + 1, bytecode->code + index, SYX_BYTECODE_MAX - index);
  bytecode->code[index] = SYX_COMPAT_SWAP_16 (instruction);
  bytecode->code_top++;
  bytecode->stack_size++;
}

/*! Does SYX_BYTECODE_POP_TOP */
INLINE void
syx_bytecode_pop_top (SyxBytecode *bytecode)
{
  syx_bytecode_do_special (bytecode, SYX_BYTECODE_POP_TOP);
}

SYX_END_DECLS

#endif /* _SYX_BYTECODE_H */
