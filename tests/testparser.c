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
#include <stdio.h>
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#include "../syx/syx.h"

int SYX_CDECL
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxOop method;
  SyxParser *parser;
  syx_uint64 start, end;
  
  syx_init (0, NULL, ".");
  syx_memory_load_image ("test.sim");

#define PARSE(text) lexer = syx_lexer_new (text);			\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, syx_undefined_object_class);	\
  syx_parser_parse (parser, FALSE);					\
  syx_parser_free (parser, FALSE);					\
  syx_lexer_free (lexer, FALSE);

#define SELECTOR_EQ(expected) (!strcmp (SYX_OBJECT_SYMBOL(SYX_METHOD_SELECTOR(method)), expected))
#define NUM_ARGS (SYX_SMALL_INTEGER(SYX_METHOD_ARGUMENT_STACK_SIZE (method)))
#define NUM_TEMPS (SYX_SMALL_INTEGER(SYX_METHOD_TEMPORARY_STACK_SIZE (method)))

  start = syx_nanotime ();

  PARSE ("unary");
  assert (SELECTOR_EQ ("unary"));
  assert (NUM_ARGS == 0);

  PARSE ("+ argument");
  assert (SELECTOR_EQ ("+"));
  assert (NUM_ARGS == 1);

  PARSE ("keyword: argument message: other");
  assert (SELECTOR_EQ ("keyword:message:"));
  assert (NUM_ARGS == 2);

  PARSE ("meth | a b c | a := 'asd'");
  assert (SELECTOR_EQ ("meth"));
  assert (NUM_ARGS == 0);
  assert (NUM_TEMPS == 3);

  PARSE ("meth: anObject self literal: #(a). self array: {anObject}");

  PARSE ("meth {[self expr: (self sub method: 16r012 + 2.3e6)]}");

  PARSE ("meth 1, 2, 3 test. (1, 2, 3) test");

  end = syx_nanotime ();
  printf ("Time elapsed: %ld nanoseconds\n", end - start);

  syx_quit ();
  
  return 0;
}
