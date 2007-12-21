/* 
   Copyright (c) 2007 Luca Bruno

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

#ifndef SYX_ERROR_H
#define SYX_ERROR_H

#include <stdio.h>
#include "syx-types.h"
#include "syx-config.h"
#include "syx-utils.h"

#include <stdarg.h>

#ifdef WINCE
#include <windows.h>
#endif

SYX_BEGIN_DECLS

typedef syx_uint32 SyxErrorType;

typedef struct SyxErrorEntry SyxErrorEntry;

/*! Hold the name and the Error subclass to invoke in the Smalltalk environment */
struct SyxErrorEntry
{
  syx_symbol name;
  SyxOop klass;
};

EXPORT extern void syx_error_init (void);
EXPORT extern void syx_error_clear (void);
EXPORT extern SyxErrorType syx_error_register (syx_symbol name, SyxOop klass);
EXPORT extern SyxErrorEntry *syx_error_lookup (SyxErrorType type);
EXPORT extern syx_bool syx_signal (SyxErrorType type, SyxOop message);
EXPORT extern SyxOop syx_signal_create_context (SyxErrorType type, SyxOop message);
EXPORT extern void syx_warning (syx_symbol fmt, ...);
EXPORT extern void syx_error (syx_symbol fmt, ...);
EXPORT extern void syx_perror (syx_symbol message);

/*! Send receiver>>#doesNotUnderstand: with selector */
#define syx_signal_does_not_understand(receiver, selector)              \
  (syx_interp_enter_context (syx_send_binary_message (_syx_exec_state->process, syx_interp_get_current_context (), \
                                                      receiver,         \
                                                      "doesNotUnderstand:", \
                                                      selector)))

/*! Display debugging messages */
#define syx_debug printf

SYX_END_DECLS    

#endif /* SYX_ERROR_H */
