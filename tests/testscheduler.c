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
  SyxParser *parser;
  SyxLexer *lexer;
  SyxOop method, context, process;
  syx_uint64 start, end;
  syx_bool ok;

  syx_init (0, NULL, ".");
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

#define INTERPRET(text)							\
  lexer = syx_lexer_new (text);						\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, syx_undefined_object_class);	\
  ok = syx_parser_parse (parser, FALSE);				\
  assert (ok == TRUE);							\
  syx_lexer_free (lexer, FALSE);					\
  syx_parser_free (parser, FALSE);					\
  process = syx_process_new ();						\
  context = syx_method_context_new (process, syx_nil, method, syx_nil, syx_nil); \

  syx_processor_first_process = syx_nil;

  puts ("- Test processes");
  INTERPRET ("method"\
	     "['Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl] fork."\
	     "['Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl] fork."\
	     "['Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl] fork");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  start = syx_nanotime ();
  syx_scheduler_run ();
  end = syx_nanotime ();
  printf ("Time elapsed: %ld nanoseconds\n", end - start);

  puts ("- Test semaphores and number coercing too");
  INTERPRET ("method"\
	     "| s |"\
	     "s := Semaphore new."\
	     "[ 1.0 to: 5 do: [ :i | s wait. 'Process 1' printNl. s signal ] ] fork."\
	     "[ 1 to: 5.0 do: [ :i | s wait. 'Process 2' printNl. s signal ] ] fork."\
	     "[ 1.3 to: 5.6 do: [ :i | s wait. 'Process 3' printNl. s signal ] ] fork."\
	     "s signal");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  start = syx_nanotime ();
  syx_scheduler_run ();
  end = syx_nanotime ();
  printf ("Time elapsed: %ld nanoseconds\n", end - start);

  syx_quit ();

  return 0;
}
