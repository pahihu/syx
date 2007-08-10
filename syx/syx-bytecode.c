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

#include "syx-memory.h"
#include "syx-platform.h"
#include "syx-types.h"
#include "syx-object.h"
#include "syx-bytecode.h"

//! Creates a new bytecode holder
/*!
  \return A SyxBytecode instance
*/
EXPORT SyxBytecode *
syx_bytecode_new (void)
{
  SyxBytecode *bytecode;

  bytecode = (SyxBytecode *)syx_malloc (sizeof (SyxBytecode));
  bytecode->code_top = 0;
  bytecode->literals_top = 0;
  bytecode->stack_size = 0;

  return bytecode;
}

/*!
  Contains common unary messages avoiding them to be inserted into method literals.
*/
syx_symbol syx_bytecode_unary_messages[] = {"isNil", "notNil", "value", "new", "class", "superclass",
					    "print", "printNl", "printString", "unity", NULL};

/*!
  Same as syx_bytecode_unary_messages but contains binary messages and keyword messages with a single argument
*/
syx_symbol syx_bytecode_binary_messages[] = {"+", "-", "<", ">", "<=", ">=", "=", "~=", "at:",
					     "do:", "value:", "valueWithArguments:",
					     "new:", "to:", "basicAt:", NULL};

//! Manually generate an instruction
/*!
  This function creates an instruction and insert it into the code array.
  If the low argument is higher than the max value, then generate a SYX_BYTECODE_EXTENDED instruction
  with the command as argument. The low argument is put to the next code slot.

  Look at SYX_BYTECODE_ARGUMENT_BITS and SYX_BYTECODE_ARGUMENT_MAX for more informations.

  \param high a SyxBytecodeCommand value
  \param low an arbitrary number identifying an argument
*/
EXPORT void
syx_bytecode_gen_instruction (SyxBytecode *bytecode, syx_uint8 high, syx_uint16 low)
{
  if (low > SYX_BYTECODE_ARGUMENT_MAX)
    {
      syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_EXTENDED, high);
      syx_bytecode_gen_code (bytecode, low);
    }
  else
    syx_bytecode_gen_code (bytecode, (high << SYX_BYTECODE_ARGUMENT_BITS) + low);
}

//! Generate a message instruction
/*!
  If the message shouldn't be sent to super and the selector is known to be a common unary or binary message,
  send SYX_BYTECODE_SEND_UNARY or SYX_BYTECODE_SEND_BINARY with its relative index into syx_bytecode_unary_messages or syx_bytecode_binary_messages.

  If it's a non-specific message, then specify the number of arguments with the SYX_BYTECODE_MARK_ARGUMENTS instruction and generate a SYX_BYTECODE_SEND_MESSAGE or SYX_BYTECODE_SEND_SUPER instruction.

  \param to_super TRUE if the message must be sent to the superclass
  \param argument_count the number of arguments the message requires
  \param selector a message pattern
*/
EXPORT void
syx_bytecode_gen_message (SyxBytecode *bytecode, syx_bool to_super, syx_uint32 argument_count, syx_symbol selector)
{
  SyxOop binding;
  /*
  syx_int16 i;
  SyxOop selbinding;
  if (!to_super)
    {
      for (i=0; syx_bytecode_unary_messages[i]; i++)
	{
	  if (!strcmp (syx_bytecode_unary_messages[i], selector))
	    {
	      binding = syx_variable_binding_new (syx_symbol_new (selector), 0, syx_nil);
	      selbinding = syx_object_new (syx_globals_at ("Association"));
	      SYX_ASSOCIATION_KEY (selbinding) = syx_small_integer_new (i);
	      SYX_ASSOCIATION_VALUE (selbinding) = binding;
	      syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_UNARY,
					    syx_bytecode_gen_literal (bytecode, selbinding));
	      return;
	    }
	}
      
      for (i=0; syx_bytecode_binary_messages[i]; i++)
	{
	  if (!strcmp (syx_bytecode_binary_messages[i], selector))
	    {
	      binding = syx_variable_binding_new (syx_symbol_new (selector), 0, syx_nil);
	      selbinding = syx_object_new (syx_globals_at ("Association"));
	      SYX_ASSOCIATION_KEY (selbinding) = syx_small_integer_new (i);
	      SYX_ASSOCIATION_VALUE (selbinding) = binding;
	      syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_BINARY,
					    syx_bytecode_gen_literal (bytecode, selbinding));
	      return;
	    }
	} 
    }
  */
  binding = syx_variable_binding_new (syx_symbol_new (selector), 0, syx_nil);
  syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_MARK_ARGUMENTS, argument_count);
  if (to_super)
    syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_SUPER,
				  syx_bytecode_gen_literal (bytecode, binding));
  else
    syx_bytecode_gen_instruction (bytecode, SYX_BYTECODE_SEND_MESSAGE,
				  syx_bytecode_gen_literal (bytecode, binding));
}

//! Generate a literal
/*!
  Insert the given literal into the literals array if it's not already there.

  \param literal an object
  \return The position of literal into the literals array
*/
EXPORT syx_uint32
syx_bytecode_gen_literal (SyxBytecode *bytecode, SyxOop literal)
{
  syx_uint16 i;
  for (i=0; i < bytecode->literals_top; i++)
    {
      if (SYX_OOP_EQ (bytecode->literals[i], literal))
	return i;
    }

  if (SYX_IS_OBJECT (literal))
    SYX_OBJECT_IS_CONSTANT(literal) = TRUE;

  bytecode->literals[bytecode->literals_top++] = literal;
  return bytecode->literals_top - 1;
}
