#include <assert.h>
#include <stdio.h>
#include <sys/time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxOop method;
  SyxParser *parser;
  struct timeval start, end;
  
  syx_init (".");
  syx_memory_load_image ("test.sim");

#define PARSE(text) lexer = syx_lexer_new (text);			\
  method = syx_method_new ();						\
  parser = syx_parser_new (lexer, method, NULL);			\
  syx_parser_parse (parser);						\
  syx_parser_free (parser, FALSE);					\
  syx_lexer_free (lexer, FALSE);

#define SELECTOR_EQ(expected) (!strcmp (SYX_OBJECT_SYMBOL(SYX_METHOD_SELECTOR(method)), expected))
#define NUM_ARGS (SYX_SMALL_INTEGER(SYX_METHOD_ARGUMENTS_COUNT (method)))
#define NUM_TEMPS (SYX_SMALL_INTEGER(SYX_METHOD_TEMPORARIES_COUNT (method)))

  gettimeofday (&start, NULL);

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

  PARSE ("meth {[self expr: (sub method: expression)]}");

  PARSE ("meth 1, 2, 3 test. (1, 2, 3) test");

  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n", end.tv_usec - start.tv_usec);

  syx_quit ();
  
  return 0;
}
