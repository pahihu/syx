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

#ifndef SYX_LEXER_H
#define SYX_LEXER_H

#include "syx-types.h"
#include "syx-enums.h"

/* Token */

typedef struct SyxToken SyxToken;

struct SyxToken {
  SyxTokenType type;
  union
  {
    syx_int32 integer;
    syx_uint64 large_integer;
    syx_double floating;
    syx_char character;
    syx_string string;
  } value;
};

void syx_token_free (SyxToken token);

/* Lexer */

typedef struct SyxLexer SyxLexer;

struct SyxLexer {
  syx_symbol text;
  SyxToken last_token;
  syx_char last_char;

  syx_symbol _current_text;
  syx_char _pushed_back;
};

SyxLexer *syx_lexer_new (syx_symbol text);
void syx_lexer_free (SyxLexer *lexer, syx_bool free_text);

syx_char syx_lexer_forward (SyxLexer *lexer);
inline syx_char syx_lexer_push_back (SyxLexer *lexer);
SyxToken syx_lexer_next_token (SyxLexer *lexer);
syx_char *syx_lexer_next_chunk (SyxLexer *lexer);
SyxToken syx_lexer_get_last_token (SyxLexer *lexer);
syx_char syx_lexer_get_last_char (SyxLexer *lexer);

#endif
