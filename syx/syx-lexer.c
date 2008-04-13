/* 
   Copyright (c) 2007 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#include "syx-memory.h"
#include "syx-platform.h"
#include "syx-error.h"
#include "syx-types.h"
#include "syx-lexer.h"

#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#ifdef HAVE_ERRNO_H
#include <errno.h>
#endif

#ifdef HAVE_LIBGMP
#include <gmp.h>
#endif

static void _syx_lexer_token_identifier (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_number (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_character (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_symbol (SyxLexer *self, SyxToken *token, syx_char lastChar);
static void _syx_lexer_token_string (SyxLexer *self, SyxToken *token, syx_char lastChar);
static syx_bool _syx_char_is_closing (syx_char c);
static syx_bool _syx_char_is_single_binary (syx_char c);
static syx_bool _syx_char_is_binary_second (syx_char c);

/*! \page syx_lexer Syx Lexer

  Tokenize all the given code into SyxToken structures.
  Take look at syx-lexer.c for more detailed informations.
*/

/*!
  Creates a new lexer to parse the code.

  \param text the code
  \return A new SyxLexer
*/
SyxLexer *
syx_lexer_new (syx_symbol text)
{
  SyxLexer *self;
  if (!text)
    return NULL;

  self = (SyxLexer *) syx_malloc (sizeof (SyxLexer));

  self->text = self->_current_text = text;
  self->_pushed_back = 0;
  self->last_char = 0;

  return self;
}

/*!
  Frees the memory allocated by syx_lexer_new.

  \param free_text TRUE frees the text
*/
void
syx_lexer_free (SyxLexer *lexer, syx_bool free_text)
{
  if (free_text)
    syx_free ((syx_pointer) lexer->text);

  syx_free (lexer);
}

/*!
  Frees the memory allocated for a SyxToken.

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
  syx_uint32 length = 200;
  syx_string str = syx_malloc(length+2);
  syx_uint32 i = 1;

  *str = lastChar;

  while ((lastChar = syx_lexer_forward (self)) && isalnum (lastChar))
    {
      *(str+i) = lastChar;
      i++;
    }

  if (lastChar == ':')
    {
      lastChar = syx_lexer_forward (self);
      if (lastChar == '=')
        {
          self->_pushed_back = 0;
          self->_current_text -= 2;
          token->type = SYX_TOKEN_NAME_CONST;
        }
      else
        {
          syx_lexer_push_back (self);
          *(str+i) = ':';
          i++;
          token->type = SYX_TOKEN_NAME_COLON;
        }
    }
  else
    {
      syx_lexer_push_back (self);
      token->type = SYX_TOKEN_NAME_CONST;
    }

  str[i] = '\0';
  token->value.string = syx_strdup (str);
  syx_free (str);
}

static void
_syx_lexer_token_number (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_char s[256] = {0};
  syx_int32 stop = 0;
  syx_nint radix = 10;
  syx_bool sign = FALSE;
  syx_bool no_float = FALSE;
  syx_nint tol;

  do
    s[stop++] = lastChar;
  while ((lastChar = syx_lexer_forward (self)) && isdigit (lastChar));

  errno = 0;
  tol = strtol (s, (char **)NULL, 10);
  if (errno == ERANGE || tol < 0 || !SYX_SMALL_INTEGER_CAN_EMBED (tol))
    {
#ifdef HAVE_LIBGMP
      token->value.large_integer = syx_calloc (1, sizeof (mpz_t));
      mpz_init_set_str (*token->value.large_integer, s, 10);
      token->type = SYX_TOKEN_LARGE_INT_CONST;
#else
      syx_error ("Integer too large\n");
#endif /* HAVE_LIBGMP */
    }
  else if (errno != 0)
    {
      syx_perror ("LEXER");
    }
  else
    {
      token->value.integer = tol;
      token->type = SYX_TOKEN_INT_CONST;
    }

  /* a radix? */
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
      tol = strtol (s, (char **)NULL, radix);
      if (errno == ERANGE || tol < 0 || !SYX_SMALL_INTEGER_CAN_EMBED (tol))
        {
#ifdef HAVE_LIBGMP
          token->value.large_integer = syx_calloc (1, sizeof (mpz_t));
          mpz_init_set_str (*token->value.large_integer, s, radix);
          token->type = SYX_TOKEN_LARGE_INT_CONST;
#else
          syx_error ("Integer too large\n");
#endif /* HAVE_LIBGMP */
        }
      else if (errno != 0)
        {
          syx_perror ("LEXER");
        }
      else
        {
          token->value.integer = tol;
          token->type = SYX_TOKEN_INT_CONST;
        }
    }

  /* a float? */
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
          self->_pushed_back = 0;
          self->_current_text -= 2;
          no_float = TRUE;
        }
    }

  /* float e? */
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
          self->_pushed_back = 0;
          self->_current_text--;
          if (sign) self->_current_text--;
          self->_current_text--;
        }
    }
  else if (!no_float)
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
  syx_uint32 length = 200;
  syx_string str = syx_malloc(length+2);
  syx_uint32 i = 0;

  /* if it's not an alpha numeric symbol,
     be sure to return a symbol of length 2 as the ANSI defines */
  lastChar = syx_lexer_forward (self);
  if (lastChar == '\'')
    {
      _syx_lexer_token_string (self, token, lastChar);
      token->type = SYX_TOKEN_SYM_CONST;
      return;
    }

  if (lastChar == '-' || _syx_char_is_binary_second (lastChar))
    {
      *(str+i) = lastChar;
      i++;

      lastChar = syx_lexer_forward (self);
      if (lastChar == '-' || _syx_char_is_binary_second (lastChar))
        {
          *(str+i) = lastChar;
          i++;
        }
      else
        syx_lexer_push_back (self);
    }
  else
    {
      while (lastChar && (isalnum (lastChar) || lastChar == ':'))
        {
          *(str+i) = lastChar;
          i++;

          lastChar = syx_lexer_forward (self);
        }
      syx_lexer_push_back (self);
    }
  
  str[i] = '\0';
  token->type = SYX_TOKEN_SYM_CONST;
  token->value.string = syx_strdup (str);
  syx_free(str);
}

static void
_syx_lexer_token_string (SyxLexer *self, SyxToken *token, syx_char lastChar)
{
  syx_uint32 length = 200;
  syx_string str = syx_malloc(length+2);
  syx_uint32 i = 0;

  while (TRUE)
    {
      while ((lastChar = syx_lexer_forward (self)) && lastChar != '\'')
        {
          if (i == length)
            {
              length += 200;
              str = syx_realloc (str, length+2);
            }
          *(str+i) = lastChar;
          i++;
        }
      
      lastChar = syx_lexer_forward (self);
      if (lastChar == '\'')
        {
          *(str+i) = '\'';
          i++;
        }
      else
        {
          syx_lexer_push_back (self);
          break;
        }
    }

  str[i] = '\0';
  token->type = SYX_TOKEN_STR_CONST;
  token->value.string = syx_strdup (str);
  syx_free (str);
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
  return !(isalnum (c) || isspace (c) || c == '-' || _syx_char_is_closing (c) || _syx_char_is_single_binary (c));
}

/*! Get the next character or 0 */
syx_char
syx_lexer_forward (SyxLexer *lexer)
{
  syx_char cc;

  if (lexer->_pushed_back)
    {
      cc = lexer->_pushed_back;
      lexer->_pushed_back = 0;
    }
  else if (*(lexer->_current_text))
    cc = *(lexer->_current_text++);
  else
    cc = '\0';

  lexer->last_char = cc;
  return cc;
}

/*! Returns the next token parsed by the lexer */
SyxToken
syx_lexer_next_token (SyxLexer *lexer)
{
  syx_char lastChar, secondChar;
  syx_string str;
  SyxToken token = {0};

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
      str = (syx_string) syx_calloc (2, sizeof (syx_char));
      *str = lastChar;
      token.type = SYX_TOKEN_BINARY;
      token.value.string = str;
    }
  else
    {
      str = (syx_string) syx_calloc (3, sizeof (syx_char));
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

/*!
  Get the next chunk of code separated ending with an exlamation mark (!).

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
  if (token.type != SYX_TOKEN_END)
    length--;

  chunk = syx_strndup (start_text, length);
  return chunk;
}

/*! Returns the last token returned by syx_lexer_next_token */
SyxToken
syx_lexer_get_last_token (SyxLexer *lexer)
{
  return lexer->last_token;
}

/*! Returns the last character returned by syx_lexer_forward */
syx_char
syx_lexer_get_last_char (SyxLexer *lexer)
{
  return lexer->last_char;
}
