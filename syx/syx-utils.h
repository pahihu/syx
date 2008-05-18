/* 
   Copyright (c) 2007-2008 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#ifndef SYX_UTILS_H
#define SYX_UTILS_H

#include "syx-platform.h"

#ifdef HAVE_STDARG_H
#define _ISOC99_SOURCE 1
#include <stdarg.h>
#endif

#include "syx-types.h"
#include "syx-lexer.h"

SYX_BEGIN_DECLS

extern EXPORT syx_bool syx_cold_parse (SyxLexer *lexer);
extern EXPORT syx_bool syx_cold_parse_methods (SyxLexer *lexer);
extern EXPORT syx_bool syx_cold_file_in (syx_symbol filename);

extern EXPORT void syx_semaphore_signal (SyxOop semaphore);
extern EXPORT void syx_semaphore_wait (SyxOop semaphore);

/* Utilities to interact with Smalltalk */

extern EXPORT SyxOop syx_send_unary_message (SyxOop receiver, syx_symbol selector);
extern EXPORT SyxOop syx_send_binary_message (SyxOop receiver, syx_symbol selector, SyxOop argument);
extern EXPORT SyxOop syx_send_message (SyxOop receiver, syx_symbol selector, syx_varsize num_args, ...);
extern EXPORT SyxOop syx_vsend_message (SyxOop receiver, syx_symbol selector, syx_varsize num_args, va_list ap);

extern EXPORT SyxOop syx_file_in_blocking (syx_symbol file);
extern EXPORT SyxOop syx_do_it_blocking (syx_symbol code);

extern EXPORT void syx_show_traceback (void);

/* Utilities for strings */

extern EXPORT syx_wstring syx_to_wstring (syx_symbol s);
extern EXPORT syx_string syx_to_string (syx_wsymbol ws);
extern EXPORT syx_uint32 syx_find_first_non_whitespace (syx_symbol string);


#ifdef UNICODE

/*! If UNICODE is defined, convert the given ANSI string (syx_char) to a wide string (syx_wchar) */
#define SYX_IFDEF_UNICODE(s) (syx_to_wstring (s))
/*! If UNICODE is defined, Convert the given wide string (syx_wchar) to an ANSI string (syx_char) */
#define SYX_IFDEF_ANSI(ws) (syx_to_string (ws))
/*! If UNICODE is defined, expand to syx_wchar, else syx_char */
#define SYX_IFDEF_CHAR_T syx_wchar

#else /* UNICODE */

/*! If UNICODE is defined, convert the given ANSI string (syx_char) to a wide string (syx_wchar) */
#define SYX_IFDEF_UNICODE(s) s
/*! If UNICODE is defined, convert the given wide string (syx_wchar) to an ANSI string (syx_char) */
#define SYX_IFDEF_ANSI(ws) ws
/*! If UNICODE is defined, expand to syx_wchar, else syx_char */
#define SYX_IFDEF_CHAR_T syx_char

#endif /* UNICODE */

#define SYX_VSPRINTF(fmt,var)                   \
  {                                             \
    syx_int32 n;                                \
    va_list ap;                                 \
    syx_int32 size;                             \
    syx_string s;                               \
                                                \
    var = NULL;                                 \
    if (fmt)                                    \
      {                                         \
        size = 100;                             \
        s = NULL;                               \
        while (TRUE)                            \
          {                                     \
            s = syx_realloc(s, size);           \
            va_start(ap, fmt);                  \
            n = vsnprintf (s, size, fmt, ap);   \
            va_end(ap);                         \
            if (n > -1 && n < size)             \
              {                                 \
                var = s;                        \
                break;                          \
              }                                 \
                                                \
            size *= 2;                          \
          }                                     \
      }                                         \
  }                                             \

SYX_END_DECLS

#endif /* SYX_UTILS_H */
