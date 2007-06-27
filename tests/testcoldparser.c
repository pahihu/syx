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
