#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  GError *error = NULL;
  SyxInstance *temp;
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();
  timer = g_timer_new ();

  g_timer_start (timer);

  lexer = syx_lexer_new ("undefined subclass: #Object!");
  g_assert (syx_cold_parse (lexer, &error) == FALSE);
  g_assert (error->code == SYX_PARSER_ERROR_LOOKUP);

  lexer = syx_lexer_new ("nil message: #Object!");
  g_assert (syx_cold_parse (lexer, &error) == FALSE);
  g_assert (error->code == SYX_PARSER_ERROR_SYNTAX);

  lexer = syx_lexer_new ("nil subclass: Object!");
  g_assert (syx_cold_parse (lexer, &error) == FALSE);
  g_assert (error->code == SYX_PARSER_ERROR_SYNTAX);

  lexer = syx_lexer_new ("nil subclass: #Object");
  g_assert (syx_cold_parse (lexer, &error) == FALSE);
  g_assert (error->code == SYX_PARSER_ERROR_SYNTAX);
  
  temp = syx_globals_lookup ("Object");
  lexer = syx_lexer_new ("nil subclass: #Object instanceVariableNames: ''!");
  g_assert (syx_cold_parse (lexer, &error) == TRUE);
  g_assert (syx_globals_lookup ("Object") == temp);
  g_assert (SYX_CLASS(temp)->factory_type != SYX_OBJECT_TYPE_COLLECTION);

  lexer = syx_lexer_new ("Object variableSubclass: #Indexable instanceVariableNames: ''!");
  g_assert (syx_cold_parse (lexer, &error) == TRUE);
  g_assert (SYX_CLASS (syx_globals_lookup ("Indexable"))->factory_type == SYX_OBJECT_TYPE_COLLECTION);

  g_timer_stop (timer);
  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));
  g_timer_destroy (timer);

  return 0;
}
