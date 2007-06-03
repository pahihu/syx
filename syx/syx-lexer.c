#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#define _GNU_SOURCE
#include <ctype.h>
#include <string.h>
#include "syx-types.h"
#include "syx-lexer.h"
#include "syx-memory.h"

static void _syx_lexer_token_identifier (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_number (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_character (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_symbol (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_string (SyxLexer *self, SyxToken *token, syx_char lastChar);
static syx_bool _syx_char_is_closing (syx_char c);
static syx_bool _syx_char_is_single_binary (syx_char c);

/*!
  \page syx_lexer Syx Lexer

  syx_lexer_new
  @text: a string
 
  \section sec Description

  This function parses a Glade XML interface file to a GladeInterface
  object (which is libglade's internal representation of the
  interface data).

  Generally, user code won't need to call this function.  Instead, it
  should go through the GladeXML interfaces.
 
  \b Returns: a SyxLexer to be used for parsing code
*/

SyxLexer *
syx_lexer_new (syx_symbol text)
{
  SyxLexer *self;
  if (!text)
    return NULL;

  self = syx_malloc (sizeof (SyxLexer));

  self->text = self->current_text = text;
  self->pushed_back = -1;
  self->last_char = -1;

  return self;
}

void
syx_lexer_free (SyxLexer *lexer, syx_bool free_text)
{
  if (free_text)
    syx_free ((syx_pointer) lexer->text);

  syx_free (lexer);
}

void
syx_token_free (SyxToken token)
{
  if (token.type > SYX_TOKEN_STRING_ENTRY)
    syx_free (token.value.string);
}

static void
_syx_lexer_token_identifier (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_char sstr[256] = {0};
  syx_string str = sstr;

  *str++ = lastChar;

  while ((lastChar = syx_lexer_forward (self)) && isalnum (lastChar))
    *str++ = lastChar;

  if (lastChar == ':')
    {
      *str++ = ':';
      token->type = SYX_TOKEN_NAME_COLON;
    }
  else
    {
      syx_lexer_push_back (self);
      token->type = SYX_TOKEN_NAME_CONST;
    }

  token->value.string = strdup (sstr);
}

static void
_syx_lexer_token_number (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_int32 intres = lastChar - '0';
  while ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar))
    intres = (intres * 10) + (lastChar - '0');
  syx_lexer_push_back (self);

  token->value.integer = intres;
  token->type = SYX_TOKEN_INT_CONST;
}

static void
_syx_lexer_token_character (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  lastChar = syx_lexer_forward (self);
  token->type = SYX_TOKEN_CHAR_CONST;
  token->value.character = lastChar;
}

static void
_syx_lexer_token_symbol (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_char sstr[256] = {0};;
  syx_string str = sstr;

  while ((lastChar = syx_lexer_forward (self)) && isalnum (lastChar))
    *str++ = lastChar;
  syx_lexer_push_back (self);
  
  token->type = SYX_TOKEN_SYM_CONST;
  token->value.string = strdup (sstr);
}

static void
_syx_lexer_token_string (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_char sstr[256] = {0};
  syx_string str = sstr;

  while ((lastChar = syx_lexer_forward (self)) && lastChar != '\'')
    *str++ = lastChar;

  token->type = SYX_TOKEN_STR_CONST;
  token->value.string = strdup (sstr);
}

static syx_bool
_syx_char_is_closing (syx_char c)
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

static syx_bool
_syx_char_is_single_binary (syx_char c)
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

static syx_bool
_syx_char_is_binary_second (syx_char c)
{
  return !(isalnum (c) || isspace (c) || _syx_char_is_closing (c) || _syx_char_is_single_binary (c));
}

syx_char
syx_lexer_forward (SyxLexer *lexer)
{
  syx_char cc;

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

inline syx_char
syx_lexer_push_back (SyxLexer *lexer)
{
  lexer->pushed_back = syx_lexer_get_last_char (lexer);
  return lexer->pushed_back;
}

SyxToken
syx_lexer_next_token (SyxLexer *lexer)
{
  syx_char lastChar, secondChar;
  syx_string str;
  SyxToken token;

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
  while (lastChar && (isspace (lastChar) || lastChar == '"'));

  if (!lastChar)
    token.type = SYX_TOKEN_END;
  else if (isalpha (lastChar))
    _syx_lexer_token_identifier (lexer, &token, lastChar);
  else if (isdigit (lastChar))
    _syx_lexer_token_number (lexer, &token, lastChar);
  else if (lastChar == '$')
    _syx_lexer_token_character (lexer, &token, lastChar);
  else if (lastChar == '#')
    {
      if (syx_lexer_forward (lexer) == '(')
	token.type = SYX_TOKEN_ARRAY_BEGIN;
      else
	{
	  syx_lexer_push_back (lexer);
	  _syx_lexer_token_symbol (lexer, &token, lastChar);
	}
    }
  else if (lastChar == '\'')
    _syx_lexer_token_string (lexer, &token, lastChar);
  else if (_syx_char_is_closing (lastChar))
    {
      token.value.character = lastChar;
      token.type = SYX_TOKEN_CLOSING;
    }
  else if (_syx_char_is_single_binary (lastChar))
    {
      str = syx_calloc (2, sizeof (syx_char));
      *str = lastChar;
      token.type = SYX_TOKEN_BINARY;
      token.value.string = str;
    }
  else
    {
      str = syx_calloc (3, sizeof (syx_char));
      *str = lastChar;
      
      if (_syx_char_is_binary_second ((secondChar = syx_lexer_forward (lexer))))
	*(str+1) = secondChar;
      else
	syx_lexer_push_back (lexer);

      token.type = SYX_TOKEN_BINARY;
      token.value.string = str;
    }

  lexer->last_token = token;
  return token;
}

syx_string
syx_lexer_next_chunk (SyxLexer *lexer)
{
  SyxToken token;
  syx_symbol start_text;
  syx_string chunk;

  start_text = lexer->current_text;
  token = syx_lexer_next_token (lexer);

  if ((token.type == SYX_TOKEN_BINARY && !strcmp (token.value.string, "!")) || token.type == SYX_TOKEN_END)
    {
      syx_token_free (token);
      return NULL;
    }

  while (! (token.type == SYX_TOKEN_END || (token.type == SYX_TOKEN_BINARY
					    && !strcmp (token.value.string, "!"))))
    {
      syx_token_free (token);
      token = syx_lexer_next_token (lexer);
    }

  syx_token_free (token);

  chunk = strndup (start_text, lexer->current_text - start_text - 1);
  return chunk;
}

SyxToken
syx_lexer_get_last_token (SyxLexer *lexer)
{
  return lexer->last_token;
}

syx_char
syx_lexer_get_last_char (SyxLexer *lexer)
{
  return lexer->last_char;
}
