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

SyxOop
_interpret (syx_symbol text)
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxOop method, context, process;
  struct timeval start, end;

  lexer = syx_lexer_new (text);						
  method = syx_method_new ();						
  parser = syx_parser_new (lexer, method, syx_undefined_object_class);
  assert (syx_parser_parse (parser) == TRUE);
  syx_parser_free (parser, FALSE);
  syx_lexer_free (lexer, FALSE);
  context = syx_method_context_new (syx_nil, method, syx_nil, syx_nil);
  process = syx_process_new (context);

  gettimeofday (&start, NULL);
  syx_process_execute_blocking (process);
  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n\n", end.tv_usec - start.tv_usec);

  return SYX_PROCESS_RETURNED_OBJECT(process);
}

int
main (int argc, char *argv[])
{
  SyxOop ret_obj;
  SyxLexer *lexer;

  syx_init (".");
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

  puts ("- Test assignment");
  ret_obj = _interpret ("method | a | ^a := -123 + 16r2AE + -2r100");
  assert (SYX_SMALL_INTEGER(ret_obj) == -123 + 0x2AE + -4);

  puts ("- Test floats");
  ret_obj = _interpret ("method | a | a := 123.321. ^a + 2.2");
  assert (SYX_OBJECT_FLOAT(ret_obj) == 125.521);

  puts ("- Test class variables");
  lexer = syx_lexer_new ("Object subclass: #TestClass instanceVariableNames: '' classVariableNames: 'TestVar'!"
			 "!TestClass class methodsFor: 'testing'!"
			 "initialize TestVar := 123! testVar ^TestVar ! !"
			 "!TestClass methodsFor: 'testing'!"
			 "testVar ^TestVar ! !");
  assert (syx_cold_parse (lexer) == TRUE);
  syx_lexer_free (lexer, FALSE);

  ret_obj = _interpret ("method TestClass initialize. ^TestClass testVar + TestClass new testVar");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123 + 123);

  puts ("- Test evaluating a simple block");
  ret_obj = _interpret ("method ^[321] value");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test block stack return");
  ret_obj = _interpret ("method [^321] value");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test a block with a single argument");
  ret_obj = _interpret ("method [:s | ^s] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test temporary scope in blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ | tmp | tmp := 321 ] value. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Another test for temporary scope in blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ tmp := 321 ] value. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test nested blocks with arguments");
  ret_obj = _interpret ("method ^[ :s | [ :s | s ] value: 321] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);
  
  puts ("- Another text for nested blocks and arguments");
  ret_obj = _interpret ("method ^[ :s | [ s] value] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test ifTrue:");
  ret_obj = _interpret ("method | var | var := 123. var = 321 ifTrue: [^false]. var = 123 ifTrue: [^true]");
  assert (SYX_IS_TRUE (ret_obj));

  puts ("- Test ifTrue:ifFalse:");
  ret_obj = _interpret ("method ^false ifTrue: [ 123 ] ifFalse: [ 321 ]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test ifTrue:ifFalse: again");
  ret_obj = _interpret ("method ^true ifTrue: [ 123 ] ifFalse: [ 321 ]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test ifFalse:ifTrue:");
  ret_obj = _interpret ("method ^true ifTrue: [ 123 = 321 ifFalse: [^333] ifTrue: [^222] ] ifFalse: [^false]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 333);

  puts ("- Test temporaries in optimized blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. true ifTrue: [ | tmp | tmp := 321 ]. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test exception handling");
  ret_obj = _interpret ("method ^[Signal signal] on: Signal do: [:ex | true]");
  assert (SYX_IS_TRUE (ret_obj));

  puts ("- Test resuming");
  ret_obj = _interpret ("method ^[Signal signal. 123] on: Signal do: [ :ex | ex resume. 321]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test pass");
  ret_obj = _interpret ("method ^[[Error signal. 123] on: Error do: [ :ex | ex pass. 213]] on: Exception do: [:ex | 321]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test ensuring");
  ret_obj = _interpret ("method [Signal signal. 123] ensure: [^321]. 213");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test loops");
  ret_obj = _interpret ("method | var | 1 to: 1000 do: [:i | var := i. 'test' print]. ^var");
  assert (SYX_SMALL_INTEGER(ret_obj) == 1000);

  syx_quit ();

  return 0;
}
