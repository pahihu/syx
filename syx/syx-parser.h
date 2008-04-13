/* 
   Copyright (c) 2007-2008 Luca Bruno

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

#ifndef SYX_PARSER_H
#define SYX_PARSER_H

#include "syx-types.h"
#include "syx-object.h"
#include "syx-lexer.h"
#include "syx-bytecode.h"

SYX_BEGIN_DECLS

#define SYX_PARSER_MAX_NAMES 0xFF
#define SYX_PARSER_MAX_SCOPES 0xFF
#define SYX_PARSER_MAX_CASCADES 0xFF

typedef struct SyxParserScope SyxParserScope;
struct SyxParserScope
{
  syx_string stack[SYX_PARSER_MAX_NAMES];
  syx_int8 top;
};

typedef struct SyxParser SyxParser;

/*! Parses the grammar of Smalltalk code into bytecode-commands for creating CompiledMethods */
struct SyxParser
{
  SyxLexer *lexer;
  SyxOop method;
  SyxOop klass;
  SyxBytecode *bytecode;
  syx_symbol *instance_names;

  /* private */

  syx_bool _in_block;

  syx_int16 _duplicate_indexes[SYX_PARSER_MAX_CASCADES];
  syx_int8 _duplicate_indexes_top;

  SyxParserScope _temporary_scopes[SYX_PARSER_MAX_SCOPES];
  syx_int8 _temporary_scopes_top;

  SyxParserScope _argument_scopes[SYX_PARSER_MAX_SCOPES];
  syx_int8 _argument_scopes_top;
};

EXPORT extern SyxParser *syx_parser_new (SyxLexer *lexer, SyxOop method, SyxOop klass);
EXPORT extern void syx_parser_free (SyxParser *parser, syx_bool free_segment);
EXPORT extern syx_bool syx_parser_parse (SyxParser *parser, syx_bool skip_message_pattern);

SYX_END_DECLS

#endif /* SYX_PARSER_H */
