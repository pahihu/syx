#ifndef SYX_UTILS_H
#define SYX_UTILS_H

#include "syx-types.h"
#include "syx-lexer.h"

syx_bool syx_cold_parse (SyxLexer *lexer);
syx_bool syx_cold_file_in (syx_symbol filename);

syx_bool syx_semaphore_signal (SyxOop semaphore);
void syx_semaphore_wait (SyxOop semaphore);

#ifdef WINDOWS
        #define SYX_PATH_SEPARATOR '\\'
#else
        #define SYX_PATH_SEPARATOR '/'
#endif

/* Utilities to interact with Smalltalk */

inline SyxOop syx_send_unary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector);
inline SyxOop syx_send_binary_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, SyxOop argument);
SyxOop syx_send_message (SyxOop parent_context, SyxOop receiver, syx_symbol selector, syx_varsize num_args, ...);

#endif /* SYX_UTILS_H */
