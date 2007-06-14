#include <assert.h>
#include <stdio.h>
#include <time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxOop method, context, process;
  GError *error = NULL;
  clock_t start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

#define INTERPRET(text)							\
  lexer = syx_lexer_new (text);						\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, NULL);			\
  assert (syx_parser_parse (parser, &error) == TRUE);			\
  syx_lexer_free (lexer, FALSE);					\
  syx_parser_free (parser, FALSE);					\
  context = syx_method_context_new (syx_nil, method, syx_nil, syx_nil); \
  process = syx_process_new (context)

  INTERPRET ("method"\
	     "['Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl.'Process 1' printNl] fork."\
	     "['Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl.'Process 2' printNl] fork."\
	     "['Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl.'Process 3' printNl] fork");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  start = clock ();
  syx_scheduler_run ();
  end = clock ();
  printf ("Time elapsed: %f\n", ((double) (start - end)) / CLOCKS_PER_SEC);

  syx_quit ();

  return 0;
}
