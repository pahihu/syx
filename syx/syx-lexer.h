#ifndef SYX_LEXER_H
#define SYX_LEXER_H

#include "syx-types.h"
#include "syx-enums.h"

/* Token */

typedef struct SyxToken SyxToken;

struct SyxToken {
  SyxTokenType type;
  union
  {
    syx_int32 integer;
    syx_double floating;
    syx_char character;
    syx_string string;
  } value;
};

void syx_token_free (SyxToken token);

/* Lexer */

typedef struct SyxLexer SyxLexer;

struct SyxLexer {
  syx_symbol text;
  SyxToken last_token;
  syx_char last_char;

  syx_symbol _current_text;
  syx_char _pushed_back;
};

SyxLexer *syx_lexer_new (syx_symbol text);
void syx_lexer_free (SyxLexer *lexer, syx_bool free_text);

syx_char syx_lexer_forward (SyxLexer *lexer);
inline syx_char syx_lexer_push_back (SyxLexer *lexer);
SyxToken syx_lexer_next_token (SyxLexer *lexer);
syx_char *syx_lexer_next_chunk (SyxLexer *lexer);
SyxToken syx_lexer_get_last_token (SyxLexer *lexer);
syx_char syx_lexer_get_last_char (SyxLexer *lexer);

#endif
