#ifndef SYX_UTILS_H
#define SYX_UTILS_H

#include <glib.h>
#include "syx-types.h"
#include "syx-lexer.h"

G_BEGIN_DECLS

#define G_VALUE_STRCMP(value, string) (g_strcasecmp (g_value_get_string (value), string))

#define SYX_PARSER_ERROR syx_parser_error_quark ()
GQuark syx_parser_error_quark (void);
syx_bool syx_cold_parse (SyxLexer *lexer, GError **error);
syx_bool syx_cold_file_in (syx_symbol filename, GError **error);

syx_bool syx_semaphore_signal (SyxObject *semaphore);
void syx_semaphore_wait (SyxObject *semaphore);

G_END_DECLS

#endif
