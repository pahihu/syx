#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxMethod *method;
  SyxParser *parser;
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();
  timer = g_timer_new ();

#define PARSE(text, block) lexer = syx_lexer_new (text);		\
  method = (block == TRUE ? syx_block_new () : syx_method_new ());	\
  parser = syx_parser_new (lexer, method, NULL, block, NULL);		\
  syx_parser_parse (parser, NULL)

#define SELECTOR_EQ(expected) (!g_strcasecmp (SYX_SYMBOL(syx_instance_get_variable (method, "selector"))->string, expected))
#define NUM_ARGS (method->arguments_count)
#define NUM_TEMPS (method->temporaries_count)

  g_timer_start (timer);

  PARSE ("unary", FALSE);
  g_assert (SELECTOR_EQ ("unary"));
  g_assert (NUM_ARGS == 0);

  PARSE ("+ argument", FALSE);
  g_assert (SELECTOR_EQ ("+"));
  g_assert (NUM_ARGS == 1);

  PARSE ("keyword: argument message: other", FALSE);
  g_assert (SELECTOR_EQ ("keyword:message:"));
  g_assert (NUM_ARGS == 2);

  PARSE (":a :b :c | ]", TRUE);
  g_assert (NUM_ARGS == 3);

  PARSE ("meth | a b c | a := 'asd'", FALSE);
  g_assert (SELECTOR_EQ ("meth"));
  g_assert (NUM_ARGS == 0);
  g_assert (NUM_TEMPS == 3);

  PARSE ("meth: anObject self literal: #(a). self array: {anObject}", FALSE);

  PARSE ("meth {[self expr: (sub method: expression)]}", FALSE);

  PARSE ("meth 1, 2, 3 test. (1, 2, 3) test", FALSE);

  g_timer_stop (timer);
  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);
  
  return 0;
}
