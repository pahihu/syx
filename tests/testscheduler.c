#include <assert.h>
#include <stdio.h>
#include <sys/time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxOop method, context, process;
  struct timeval start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

#define INTERPRET(text)							\
  lexer = syx_lexer_new (text);						\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, NULL);			\
  assert (syx_parser_parse (parser) == TRUE);				\
  syx_lexer_free (lexer, FALSE);					\
  syx_parser_free (parser, FALSE);					\
  context = syx_method_context_new (syx_nil, method, syx_nil, syx_nil); \
  process = syx_process_new (context)

  puts ("- Test processes");
  INTERPRET ("method"\
	     "['Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl] fork."\
	     "['Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl] fork."\
	     "['Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl] fork");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  gettimeofday (&start, NULL);
  syx_scheduler_run ();
  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n", end.tv_usec - start.tv_usec);

  puts ("- Test semaphores");
  INTERPRET ("method"\
	     "| s |"\
	     "s := Semaphore new."\
	     "[ 1 to: 5 do: [ s wait. 'Process 1' printNl. s signal ] ] fork."\
	     "[ 1 to: 5 do: [ s wait. 'Process 2' printNl. s signal ] ] fork."\
	     "[ 1 to: 5 do: [ s wait. 'Process 3' printNl. s signal ] ] fork."\
	     "s signal");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  gettimeofday (&start, NULL);
  syx_scheduler_run ();
  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n", end.tv_usec - start.tv_usec);

  syx_quit ();

  return 0;
}
