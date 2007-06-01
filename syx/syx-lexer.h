#ifndef SYX_LEXER_H
#define SYX_LEXER_H

#include "syx-types.h"
#include "syx-enums.h"

G_BEGIN_DECLS

/* Token */

typedef struct _SyxToken SyxToken;

struct _SyxToken {
  SyxTokenType type;
  union
  {
    syx_int32 integer;
    syx_char character;
    syx_string string;
  } value;
};

void syx_token_free (SyxToken token);

/* Lexer */

typedef struct _SyxLexer SyxLexer;

struct _SyxLexer {
  syx_symbol text;
  SyxToken last_token;
  syx_char last_char;

  /* <private> */
  syx_symbol current_text;
  syx_char pushed_back;
};

SyxLexer *syx_lexer_new (syx_symbol text);
void syx_lexer_free (SyxLexer *lexer, syx_bool free_text);

syx_char syx_lexer_forward (SyxLexer *lexer);
inline syx_char syx_lexer_push_back (SyxLexer *lexer);
SyxToken syx_lexer_next_token (SyxLexer *lexer);
syx_char *syx_lexer_next_chunk (SyxLexer *lexer);
SyxToken syx_lexer_get_last_token (SyxLexer *lexer);
syx_char syx_lexer_get_last_char (SyxLexer *lexer);

G_END_DECLS

#endif
