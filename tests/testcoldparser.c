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
#include <sys/time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxOop temp;
  struct timeval start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");

  gettimeofday (&start, NULL);

  /*  lexer = syx_lexer_new ("undefined subclass: #Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil message: #Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil subclass: Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil subclass: #Object");
  assert (syx_cold_parse (lexer, &error) == FALSE);*/
  
  temp = syx_globals_at ("Object");
  lexer = syx_lexer_new ("nil subclass: #Object instanceVariableNames: 'a b' classVariableNames: 'C'!");
  assert (syx_cold_parse (lexer) == TRUE);
  assert (SYX_OOP_EQ (syx_globals_at ("Object"), temp));
  assert (SYX_SMALL_INTEGER(SYX_CLASS_INSTANCE_SIZE(syx_globals_at("Object"))) == 2);
  syx_lexer_free (lexer, FALSE);

  lexer = syx_lexer_new ("!Object methodsFor: 'test'! testMethod ^nil! !");
  assert (syx_cold_parse (lexer) == TRUE);
  syx_lexer_free (lexer, FALSE);

  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n", end.tv_usec - start.tv_usec);

  syx_quit ();

  return 0;
}
