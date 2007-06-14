#include <assert.h>
#include <stdio.h>
#include <time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxOop temp;
  clock_t start, end;

  syx_init (".");
  syx_memory_load_image ("test.sim");

  start = clock ();

  /*  lexer = syx_lexer_new ("undefined subclass: #Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil message: #Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil subclass: Object!");
  assert (syx_cold_parse (lexer, &error) == FALSE);

  lexer = syx_lexer_new ("nil subclass: #Object");
  assert (syx_cold_parse (lexer, &error) == FALSE);*/
  
  temp = syx_globals_at ("Object");
  lexer = syx_lexer_new ("nil subclass: #Object instanceVariableNames: ''!");
  assert (syx_cold_parse (lexer) == TRUE);
  assert (SYX_OOP_EQ (syx_globals_at ("Object"), temp));
  syx_lexer_free (lexer, FALSE);

  lexer = syx_lexer_new ("!Object methodsFor: 'test'! testMethod ^nil! !");
  assert (syx_cold_parse (lexer) == TRUE);
  syx_lexer_free (lexer, FALSE);

  end = clock ();
  printf ("Time elapsed: %f\n", ((double) (start - end)));

  syx_quit ();

  return 0;
}
