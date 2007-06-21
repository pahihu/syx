#include <assert.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxLexer *lexer;
  SyxToken token;

  syx_init (".");

  lexer = syx_lexer_new ("nameconst 123 16r123 123.321 $c $  #symbol #(aaa) \"comment\" 'string' + := -> !!");

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_NAME_CONST);
  assert (!strcmp (token.value.string, "nameconst"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_INT_CONST);
  assert (token.value.integer == 123);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_INT_CONST);
  assert (token.value.integer == 0x123);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_FLOAT_CONST);
  assert (token.value.floating == 123.321);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CHAR_CONST);
  assert (token.value.character == 'c');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CHAR_CONST);
  assert (token.value.character == ' ');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_SYM_CONST);
  assert (!strcmp (token.value.string, "symbol"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_ARRAY_BEGIN);
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_NAME_CONST);
  assert (!strcmp (token.value.string, "aaa"));
  syx_token_free (token);
  
  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_CLOSING);
  assert (token.value.character == ')');
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_STR_CONST);
  assert (!strcmp (token.value.string, "string"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "+"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, ":="));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "->"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "!"));
  syx_token_free (token);

  token = syx_lexer_next_token (lexer);
  assert (token.type == SYX_TOKEN_BINARY);
  assert (!strcmp (token.value.string, "!"));
  syx_token_free (token);

  syx_lexer_free (lexer, FALSE);

  return 0;
}
