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

#include <assert.h>
#include "../syx/syx.h"

int SYX_CDECL
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxToken token;

  syx_init (0, NULL, "..");

#ifdef HAVE_LIBGMP
  lexer = syx_lexer_new ("nameconst 123 16r123 16rFFFFFFFF 123.321 1e2 1.3e-2 $c $  #symbol #(aaa) \"comment\" 'string' + := -> !!");
#else
  lexer = syx_lexer_new ("nameconst 123 16r123 123.321 1e2 1.3e-2 $c $  #symbol #(aaa) \"comment\" 'string' + := -> !!");
#endif

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_NAME_CONST);
  assert (!strcmp (token.value.string, "nameconst"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_INT_CONST);
  assert (token.value.integer == 123);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_INT_CONST);
  assert (token.value.integer == 0x123);

#ifdef HAVE_LIBGMP
  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_LARGE_INT_CONST);
  assert (mpz_cmp_si (*token.value.large_integer, 0xFFFFFFFF) == 0);
#endif

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_FLOAT_CONST);
  assert (token.value.floating == 123.321);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_FLOAT_CONST);
  assert (token.value.floating == 100.0);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_FLOAT_CONST);
  assert (token.value.floating == 0.013);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CHAR_CONST);
  assert (token.value.character == 'c');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CHAR_CONST);
  assert (token.value.character == ' ');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_SYM_CONST);
  assert (!strcmp (token.value.string, "symbol"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_ARRAY_BEGIN);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_NAME_CONST);
  assert (!strcmp (token.value.string, "aaa"));
  syx_token_free (token);
  
  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CLOSING);
  assert (token.value.character == ')');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_STR_CONST);
  assert (!strcmp (token.value.string, "string"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "+"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, ":="));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "->"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "!"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "!"));
  syx_token_free (token);

  syx_lexer_free (lexer, FALSE);

  return 0;
}
