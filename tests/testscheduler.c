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
  syx_memory_load_image ("test.sim");
  syx_scheduler_init ();

#define INTERPRET(text)							\
  lexer = syx_lexer_new (text);						\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, NULL);			\
  assert (syx_parser_parse (parser, &error) == TRUE);			\
  syx_lexer_free (lexer, FALSE);					\
  syx_parser_free (parser, FALSE);					\
  context = syx_method_context_new (syx_nil, method, syx_nil, syx_array_new (0, NULL)); \
  process = syx_process_new (context)

  timer = g_timer_new ();

  INTERPRET ("method"\
	     "['Process 1' print. 'Process 1' print.'Process 1' print.'Process 1' print.'Process 1' print. 'Process 1' print] fork."\
	     "['Process 2' print. 'Process 2' print.'Process 2' print.'Process 2' print.'Process 2' print. 'Process 2' print] fork."\
	     "['Process 3' print. 'Process 3' print.'Process 3' print.'Process 3' print.'Process 3' print. 'Process 3' print] fork");

  SYX_PROCESS_SUSPENDED(process) = syx_false;

  g_timer_start (timer);
  syx_scheduler_run ();
  g_timer_stop (timer);

  printf ("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);

  syx_quit ();

  return 0;
}
