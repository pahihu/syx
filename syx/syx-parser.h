#ifndef SYX_PARSER_H
#define SYX_PARSER_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-lexer.h"
#include "syx-bytecode.h"

typedef struct SyxParserScope SyxParserScope;
struct SyxParserScope
{
  syx_int8 start;
  syx_int8 end;
};

typedef struct SyxParserScopeStack SyxParserScopeStack;
struct SyxParserScopeStack
{
  SyxParserScope stack[256];
  syx_int8 top;
};

typedef struct SyxParser SyxParser;
struct SyxParser
{
  SyxLexer *lexer;
  SyxOop method;
  GPtrArray *temporary_names;
  GPtrArray *argument_names;
  syx_symbol *instance_names;

  /* <private> */
  GTrashStack *duplicate_indexes;
  SyxParserScopeStack temporary_scopes;
  SyxParserScopeStack argument_scopes;
  SyxBytecode *bytecode;
  syx_bool in_block;
};

SyxParser *syx_parser_new (SyxLexer *lexer, SyxOop method, syx_symbol *instance_names);
void syx_parser_free (SyxParser *parser, syx_bool free_segment);
syx_bool syx_parser_parse (SyxParser *parser, GError **error);

#endif /* SYX_PARSER_H */
