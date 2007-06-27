#include "syx-memory.h"
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include "syx-error.h"
#include "syx-types.h"
#include "syx-lexer.h"

static void _syx_lexer_token_identifier (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_number (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_character (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_symbol (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_string (SyxLexer *self, SyxToken *token, syx_char lastChar);
static syx_bool _syx_char_is_closing (syx_char c);
static syx_bool _syx_char_is_single_binary (syx_char c);

/*! \page syx_lexer Syx Lexer

  Tokenize all the given code into SyxToken structures.
  Take look at syx-lexer.c for more detailed informations.
*/

//! Creates a new lexer to parse the code
/*!
  \param text the code
  \return A new SyxLexer
*/
SyxLexer *
syx_lexer_new (syx_symbol text)
{
  SyxLexer *self;
  if (!text)
    return NULL;

  self = syx_malloc (sizeof (SyxLexer));

  self->text = self->_current_text = text;
  self->_pushed_back = -1;
  self->last_char = -1;

  return self;
}

//! Frees the memory allocated by syx_lexer_new
/*!
  \param free_text TRUE frees the text
*/
void
syx_lexer_free (SyxLexer *lexer, syx_bool free_text)
{
  if (free_text)
    syx_free ((syx_pointer) lexer->text);

  syx_free (lexer);
}

//! Frees the memory allocated for a SyxToken
/*!
  The only way the token can be freed is only when it holds a string.
  In that case, the string is freed
*/
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
  syx_char s[256] = {0};
  syx_int32 stop = 0;
  syx_nint radix = 10;
  syx_bool sign = FALSE;

  do
    s[stop++] = lastChar;
  while ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar));

  errno = 0;
  token->value.integer = strtol (s, (char **)NULL, 10);
  if (errno)
    syx_perror ("lexer: strtol");

  token->type = SYX_TOKEN_INT_CONST;

  // a radix?
  if (tolower (lastChar) == 'r')
    {
      radix = token->value.integer;
      stop = 0;
      while ((lastChar = syx_lexer_forward (self)) && isxdigit (lastChar))
	s[stop++] = lastChar;

      if (stop == 0)
	{
	  syx_lexer_push_back (self);
	  return;
	}

      s[stop] = '\0';

      errno = 0;
      token->value.integer = strtol (s, (char **)NULL, radix);
      if (errno)
	syx_perror ("lexer: strtol radix");
      
      token->type = SYX_TOKEN_INT_CONST;
    }

  // a float?
  if (lastChar == '.')
    {
      if ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar))
	{
	  s[stop++] = '.';
	  do
	    s[stop++] = lastChar;
	  while ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar));

	  token->type = SYX_TOKEN_FLOAT_CONST;
	  token->value.floating = strtod (s, (char **)NULL);
	}
      else
	{
	  self->_pushed_back = -1;
	  self->_current_text -= 2;
	}
    }

  // float e?
  if (lastChar == 'e')
    {
      if ((lastChar = syx_lexer_forward (self)) == '-')
	{
	  sign = TRUE;
	  lastChar = syx_lexer_forward (self);
	}

      if (lastChar && isdigit (lastChar))
	{
	  s[stop++] = 'e';
	  if (sign) s[stop++] = '-';
	  do
	    s[stop++] = lastChar;
	  while ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar));

	  syx_lexer_push_back (self);
	  token->type = SYX_TOKEN_FLOAT_CONST;
	  token->value.floating = strtod (s, (char **)NULL);
	}
      else
	{
	  self->_pushed_back = -1;
	  self->_current_text--;
	  if (sign) self->_current_text--;
	  self->_current_text--;
	}
    }
  else
    syx_lexer_push_back (self);
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
  syx_char sstr[256] = {0};
  syx_string str = sstr;

  while ((lastChar = syx_lexer_forward (self)) && (isalnum (lastChar) || lastChar == ':'))
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

//! Get the next character or 0
syx_char
syx_lexer_forward (SyxLexer *lexer)
{
  syx_char cc;

  if (lexer->_pushed_back != -1)
    {
      cc = lexer->_pushed_back;
      lexer->_pushed_back = -1;
    }
  else if (*(lexer->_current_text))
    cc = *(lexer->_current_text++);
  else
    cc = '\0';

  lexer->last_char = cc;
  return cc;
}

//! Move backward the text pointer
inline syx_char
syx_lexer_push_back (SyxLexer *lexer)
{
  lexer->_pushed_back = syx_lexer_get_last_char (lexer);
  return lexer->_pushed_back;
}

//! Returns the next token parsed by the lexer
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

//! Get the next chunk of code separated ending with an exlamation mark (!)
/*!
  \return A string containing the chunk without the exlamation mark. It must be freed once it's not needed anymore
*/
syx_string
syx_lexer_next_chunk (SyxLexer *lexer)
{
  SyxToken token;
  syx_symbol start_text;
  syx_string chunk;
  syx_uint32 length;

  start_text = lexer->_current_text;
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

  length = lexer->_current_text - start_text;
  chunk = strndup (start_text, length - 1);
  return chunk;
}

//! Returns the last token returned by syx_lexer_next_token
SyxToken
syx_lexer_get_last_token (SyxLexer *lexer)
{
  return lexer->last_token;
}

//! Returns the last character returned by syx_lexer_forward
syx_char
syx_lexer_get_last_char (SyxLexer *lexer)
{
  return lexer->last_char;
}
