#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxToken token = SYX_TOKEN_INIT;

  syx_init ("..");

  lexer = syx_lexer_new ("nameconst 123 $c $  #symbol #(aaa) \"comment\" 'string' + := -> !!");

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_NAME_CONST);
  g_assert (!g_strcasecmp (g_value_get_string (token.value), "nameconst"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_INT_CONST);
  g_assert (g_value_get_long (token.value) == 123);

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_CHAR_CONST);
  g_assert (g_value_get_char (token.value) == 'c');

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_CHAR_CONST);
  g_assert (g_value_get_char (token.value) == ' ');

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_SYM_CONST);
  g_assert (!g_strcasecmp (g_value_get_string (token.value), "symbol"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_ARRAY_BEGIN);

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_NAME_CONST);
  g_assert (!g_strcasecmp (g_value_get_string (token.value), "aaa"));
  
  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_CLOSING);
  g_assert (g_value_get_char (token.value) == ')');

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_STR_CONST);
  g_assert (!g_strcasecmp (g_value_get_string (token.value), "string"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_BINARY);
  g_assert (!G_VALUE_STRCMP (token.value, "+"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_BINARY);
  g_assert (!G_VALUE_STRCMP (token.value, ":="));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_BINARY);
  g_assert (!G_VALUE_STRCMP (token.value, "->"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_BINARY);
  g_assert (!G_VALUE_STRCMP (token.value, "!"));

  syx_lexer_next_token (lexer, &token);
  g_assert (token.type == SYX_TOKEN_BINARY);
  g_assert (!G_VALUE_STRCMP (token.value, "!"));

  return 0;
}
