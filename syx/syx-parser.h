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
  SyxBytecode *bytecode;
  syx_bool in_block;

  syx_int16 duplicate_indexes[256];
  syx_int32 duplicate_indexes_top;

  syx_string temporary_names[256];
  syx_int32 temporary_names_top;
  SyxParserScopeStack temporary_scopes;

  syx_string argument_names[256];
  SyxParserScopeStack argument_scopes;
  syx_int32 argument_names_top;

  syx_symbol *instance_names;
};

SyxParser *syx_parser_new (SyxLexer *lexer, SyxOop method, syx_symbol *instance_names);
void syx_parser_free (SyxParser *parser, syx_bool free_segment);
syx_bool syx_parser_parse (SyxParser *parser, GError **error);

#endif /* SYX_PARSER_H */
