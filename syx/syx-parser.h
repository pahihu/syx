#ifndef SYX_PARSER_H
#define SYX_PARSER_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-lexer.h"
#include "syx-bytecode.h"

typedef struct SyxParser SyxParser;

struct SyxParser {
  SyxLexer *lexer;
  SyxObject *method;
  SyxParser *parent_parser;
  GPtrArray *temporary_names;
  GPtrArray *argument_names;
  syx_symbol *instance_names;

  /* <private> */
  GTrashStack *duplicate_indexes;
  GQueue *temporary_scopes;
  SyxBytecode *bytecode;
  syx_bool in_block;
};

SyxParser *syx_parser_new (SyxLexer *lexer, SyxObject *method, syx_symbol *instance_names, syx_bool in_block, SyxParser *parent_parser);
void syx_parser_free (SyxParser *parser, syx_bool free_segment);
syx_bool syx_parser_parse (SyxParser *parser, GError **error);

#endif /* SYX_PARSER_H */
