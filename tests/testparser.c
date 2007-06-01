#include <assert.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxObject *method;
  SyxParser *parser;
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();
  timer = g_timer_new ();

#define PARSE(text, block) lexer = syx_lexer_new (text);		\
  method = (block == TRUE ? syx_block_new () : syx_method_new ());	\
  parser = syx_parser_new (lexer, method, NULL, block, NULL);		\
  syx_parser_parse (parser, NULL)

#define SELECTOR_EQ(expected) (!strcmp (SYX_OBJECT_SYMBOL(SYX_METHOD_SELECTOR(method)), expected))
#define NUM_ARGS (SYX_SMALL_INTEGER(SYX_METHOD_ARGUMENTS_COUNT (method)))
#define NUM_TEMPS (SYX_SMALL_INTEGER(SYX_METHOD_TEMPORARIES_COUNT (method)))

  g_timer_start (timer);

  PARSE ("unary", FALSE);
  assert (SELECTOR_EQ ("unary"));
  assert (NUM_ARGS == 0);

  PARSE ("+ argument", FALSE);
  assert (SELECTOR_EQ ("+"));
  assert (NUM_ARGS == 1);

  PARSE ("keyword: argument message: other", FALSE);
  assert (SELECTOR_EQ ("keyword:message:"));
  assert (NUM_ARGS == 2);

  PARSE (":a :b :c | ]", TRUE);
  assert (NUM_ARGS == 3);

  PARSE ("meth | a b c | a := 'asd'", FALSE);
  assert (SELECTOR_EQ ("meth"));
  assert (NUM_ARGS == 0);
  assert (NUM_TEMPS == 3);

  PARSE ("meth: anObject self literal: #(a). self array: {anObject}", FALSE);

  PARSE ("meth {[self expr: (sub method: expression)]}", FALSE);

  PARSE ("meth 1, 2, 3 test. (1, 2, 3) test", FALSE);

  g_timer_stop (timer);
  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);
  
  return 0;
}
