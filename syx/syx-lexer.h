#ifndef SYX_LEXER_H
#define SYX_LEXER_H

#include <glib.h>
#include <glib-object.h>
#include "syx-enums.h"

G_BEGIN_DECLS

#define SYX_TOKEN_INIT { -1, NULL }

typedef struct _SyxToken SyxToken;

struct _SyxToken {
  SyxTokenType type;
  GValue *value;
};

typedef struct _SyxLexer SyxLexer;
typedef struct _SyxLexerClass SyxLexerClass;

struct _SyxLexer {
  const gchar *text;
  SyxToken last_token;
  gchar last_char;

  /* <private> */
  const gchar *current_text;
  gchar pushed_back;
};

SyxLexer *syx_lexer_new (const gchar *text);

gchar syx_lexer_forward (SyxLexer *lexer);
gchar syx_lexer_push_back (SyxLexer *lexer);
void syx_lexer_next_token (SyxLexer *lexer, SyxToken *token);
gchar *syx_lexer_next_chunk (SyxLexer *lexer);
SyxToken syx_lexer_get_last_token (SyxLexer *lexer);
gchar syx_lexer_get_last_char (SyxLexer *lexer);

G_END_DECLS

#endif
