#include <assert.h>
#include <stdio.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxOop method, context, process;
  GError *error = NULL;
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();

#define INTERPRET(text)							\
  lexer = syx_lexer_new (text);						\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, NULL);			\
  assert (syx_parser_parse (parser, &error) == TRUE);			\
  context = syx_method_context_new (SYX_NIL, method, SYX_NIL, syx_array_new (0, NULL)); \
  process = syx_process_new (context)

  timer = g_timer_new ();

  /*  INTERPRET ("method 'Process 1' print. 'Process 1' print.'Process 1' print.'Process 1' print.'Process 1' print. 'Process 1' print");
  INTERPRET ("method 'Process 2' print. 'Process 2' print.'Process 2' print.'Process 2' print.'Process 2' print. 'Process 2' print");
  INTERPRET ("method 'Process 3' print. 'Process 3' print.'Process 3' print.'Process 3' print.'Process 3' print. 'Process 3' print");*/
  INTERPRET ("method"\
	     "['Process 1' print. 'Process 1' print.'Process 1' print.'Process 1' print.'Process 1' print. 'Process 1' print] fork."\
	     "['Process 2' print. 'Process 2' print.'Process 2' print.'Process 2' print.'Process 2' print. 'Process 2' print] fork."\
	     "['Process 3' print. 'Process 3' print.'Process 3' print.'Process 3' print.'Process 3' print. 'Process 3' print] fork");

  SYX_PROCESS_SUSPENDED(process) = SYX_FALSE;

  g_timer_start (timer);
  syx_scheduler_run ();
  g_timer_stop (timer);

  printf ("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);

  return 0;
}
