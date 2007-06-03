#ifndef SYX_UTILS_H
#define SYX_UTILS_H

#include "syx-types.h"
#include "syx-lexer.h"

syx_bool syx_cold_parse (SyxLexer *lexer);
syx_bool syx_cold_file_in (syx_symbol filename);

syx_bool syx_semaphore_signal (SyxObject *semaphore);
void syx_semaphore_wait (SyxObject *semaphore);

#ifdef WINDOWS
        #define SYX_PATH_SEPARATOR '\\'
#else
        #define SYX_PATH_SEPARATOR '/'
#endif

syx_string syx_path_join (syx_symbol path1, syx_symbol path2);

#endif /* SYX_UTILS_H */
