#ifndef SYX_UTILS_H
#define SYX_UTILS_H

#include "syx-types.h"
#include "syx-lexer.h"

syx_bool syx_cold_parse (SyxLexer *lexer);
syx_bool syx_cold_file_in (syx_symbol filename);

syx_bool syx_semaphore_signal (SyxObject *semaphore);
void syx_semaphore_wait (SyxObject *semaphore);

#endif /* SYX_UTILS_H */
