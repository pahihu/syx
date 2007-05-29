#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-lexer.h"

SyxLexer *
syx_lexer_new (syx_symbol text)
{
  SyxLexer *self;
  g_return_val_if_fail (text != NULL, NULL);

  self = g_new0 (SyxLexer, 1);

  self->text = self->current_text = text;
  self->pushed_back = -1;
  self->last_char = -1;

  return self;
}
static void
parse_identifier (SyxLexer *self, SyxToken *token, gchar lastChar)
{
  GString *str = g_string_new (NULL);
  g_string_append_c (str, lastChar);

  while ((lastChar = syx_lexer_forward (self)) && g_ascii_isalnum (lastChar))
    g_string_append_c (str, lastChar);

  if (lastChar == ':')
    {
      g_string_append_c (str, ':');
      token->type = SYX_TOKEN_NAME_COLON;
    }
  else
    {
      syx_lexer_push_back (self);
      token->type = SYX_TOKEN_NAME_CONST;
    }

  g_value_init (token->value, G_TYPE_STRING);
  g_value_set_string (token->value, str->str);
  g_string_free (str, FALSE);
}

static void
parse_number (SyxLexer *self, SyxToken *token, gchar lastChar)
{
  gint intres = lastChar - '0';
  while ((lastChar = syx_lexer_forward (self)) && g_ascii_isdigit (lastChar))
    intres = (intres * 10) + (lastChar - '0');
  syx_lexer_push_back (self);

  token->type = SYX_TOKEN_INT_CONST;
  g_value_init (token->value, G_TYPE_INT);
  g_value_set_int (token->value, intres);
}

static void
parse_character (SyxLexer *self, SyxToken *token, gchar lastChar)
{
  lastChar = syx_lexer_forward (self);
  token->type = SYX_TOKEN_CHAR_CONST;
  g_value_init (token->value, G_TYPE_CHAR);
  g_value_set_char (token->value, lastChar);
}

static void
parse_symbol (SyxLexer *self, SyxToken *token, gchar lastChar)
{
  GString *str = g_string_new (NULL);
  while ((lastChar = syx_lexer_forward (self)) && g_ascii_isalnum (lastChar))
    g_string_append_c (str, lastChar);
  syx_lexer_push_back (self);
  
  token->type = SYX_TOKEN_SYM_CONST;
  g_value_init (token->value, G_TYPE_STRING);
  g_value_set_string (token->value, str->str);
  g_string_free (str, FALSE);
}

static void
parse_string (SyxLexer *self, SyxToken *token, gchar lastChar)
{
  GString *str = g_string_new (NULL);
  while ((lastChar = syx_lexer_forward (self)) && lastChar != '\'')
    g_string_append_c (str, lastChar);

  token->type = SYX_TOKEN_STR_CONST;
  g_value_init (token->value, G_TYPE_STRING);
  g_value_set_string (token->value, str->str);
  g_string_free (str, FALSE);
}

static gboolean
is_closing (gchar c)
{
  switch (c)
    {
    case '.':
    case ']':
    case ')':
    case '}':
    case ';':
    case '"':
    case '\'':
      return TRUE;
    }
  return FALSE;
}

static gboolean
single_binary (gchar c)
{
  switch (c)
    {
    case '{':
    case '[':
    case '(':
    case ')':
    case ']':
    case '}':
    case '!':
    case '^':
      return TRUE;
    }
  return FALSE;
}

static gboolean
binary_second (gchar c)
{
  return !(g_ascii_isalnum (c) || g_ascii_isspace (c) || is_closing (c) || single_binary (c));
}

gchar
syx_lexer_forward (SyxLexer *lexer)
{
  gchar cc;

  if (lexer->pushed_back != -1)
    {
      cc = lexer->pushed_back;
      lexer->pushed_back = -1;
    }
  else if (*(lexer->current_text))
    cc = *(lexer->current_text++);
  else
    cc = '\0';

  lexer->last_char = cc;
  return cc;
}

gchar
syx_lexer_push_back (SyxLexer *lexer)
{
  lexer->pushed_back = syx_lexer_get_last_char (lexer);
  return lexer->pushed_back;
}

void
syx_lexer_next_token (SyxLexer *lexer, SyxToken *token)
{
  gchar lastChar, secondChar, *str;
  g_return_if_fail (token != NULL);

  if (G_IS_VALUE (token->value))
    g_value_unset (token->value);
  else
    token->value = g_new0 (GValue, 1);

  do
    {
      lastChar = syx_lexer_forward (lexer);
      if (lastChar == '"')
	{
	  lastChar = syx_lexer_forward (lexer);
	  while (lastChar && lastChar != '"')
	    lastChar = syx_lexer_forward (lexer);
	}
    }
  while (lastChar && (g_ascii_isspace (lastChar) || lastChar == '"'));

  if (!lastChar)
    token->type = SYX_TOKEN_END;
  else if (g_ascii_isalpha (lastChar))
    parse_identifier (lexer, token, lastChar);
  else if (g_ascii_isdigit (lastChar))
    parse_number (lexer, token, lastChar);
  else if (lastChar == '$')
    parse_character (lexer, token, lastChar);
  else if (lastChar == '#')
    {
      if (syx_lexer_forward (lexer) == '(')
	token->type = SYX_TOKEN_ARRAY_BEGIN;
      else
	{
	  syx_lexer_push_back (lexer);
	  parse_symbol (lexer, token, lastChar);
	}
    }
  else if (lastChar == '\'')
    parse_string (lexer, token, lastChar);
  else if (is_closing (lastChar))
    {
      g_value_init (token->value, G_TYPE_CHAR);
      g_value_set_char (token->value, lastChar);
      token->type = SYX_TOKEN_CLOSING;
    }
  else if (single_binary (lastChar))
    {
      str = g_new0 (gchar, 2);
      *str = lastChar;
      g_value_init (token->value, G_TYPE_STRING);
      g_value_set_string (token->value, str);
      token->type = SYX_TOKEN_BINARY;
    }
  else
    {
      str = g_new0 (gchar, 3);
      *str = lastChar;
      g_value_init (token->value, G_TYPE_STRING);
      if (binary_second ((secondChar = syx_lexer_forward (lexer))))
	*(str+1) = secondChar;
      else
	syx_lexer_push_back (lexer);
      g_value_set_string (token->value, str);
      token->type = SYX_TOKEN_BINARY;
    }

  lexer->last_token = *token;
}

gchar *
syx_lexer_next_chunk (SyxLexer *lexer)
{
  SyxToken token;
  syx_symbol start_text;
  gchar *chunk;

  token = lexer->last_token;
  start_text = lexer->current_text;

  syx_lexer_next_token (lexer, &token);
  if ((token.type == SYX_TOKEN_BINARY && !g_strcasecmp (g_value_get_string (token.value), "!")) || token.type == SYX_TOKEN_END)
    return NULL;

  while (! (token.type == SYX_TOKEN_END || 
	    (token.type == SYX_TOKEN_BINARY
	     && !g_strcasecmp (g_value_get_string (token.value), "!"))))
    syx_lexer_next_token (lexer, &token);

  chunk = g_strndup (start_text, lexer->current_text - start_text - 1);
  return chunk;
}

SyxToken
syx_lexer_get_last_token (SyxLexer *lexer)
{
  return lexer->last_token;
}

gchar
syx_lexer_get_last_char (SyxLexer *lexer)
{
  return lexer->last_char;
}
