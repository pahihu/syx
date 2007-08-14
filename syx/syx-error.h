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

#ifdef WINCE
#include <windows.h>
#endif

typedef syx_uint32 SyxErrorType;

typedef struct SyxErrorEntry SyxErrorEntry;

struct SyxErrorEntry
{
  syx_symbol name;
  SyxOop klass;
};

EXPORT extern void syx_error_init (void);
EXPORT extern void syx_error_clear (void);
EXPORT extern SyxErrorType syx_error_register (syx_symbol name, SyxOop klass);
EXPORT extern SyxErrorEntry *syx_error_lookup (SyxErrorType type);

//! Signal an error in the Smalltalk environment
/*!
  \param type the type returned by syx_error_register
*/
#define syx_signal(type, ...)						\
  (syx_interp_enter_context (syx_send_message (syx_interp_get_current_context (), \
					       syx_error_lookup (type)->klass, \
					       "signal",		\
					       __VA_ARGS__)))
//! Create an error Context in the Smalltalk environment ready to enter a Process
/*!
  \param type the type returned by syx_error_register
*/
#define syx_signal_create_context(type, ...)				\
  (syx_send_message (syx_interp_get_current_context (),			\
		     syx_error_lookup (type)->klass,			\
		     "signal",						\
		     __VA_ARGS__))

//! Send receiver>>#doesNotUnderstand: with selector
#define syx_signal_does_not_understand(receiver, selector)		\
  (syx_interp_enter_context (syx_send_binary_message (syx_interp_get_current_context (), \
						      receiver,		\
						      "doesNotUnderstand:", \
						      selector)))

//! Display an error then exits
/*!
  This function will show an error MessageBox on Windows CE
*/
#ifndef WINCE
#define syx_error(...)				\
  {						\
    fprintf (stderr, "ERROR: ");		\
    fprintf (stderr, __VA_ARGS__);		\
    exit (EXIT_FAILURE);			\
  }
#else /* WINCE */
#ifndef UNICODE
#define syx_error(message, ...)						\
  {									\
    MessageBox (0, message, "Error", 0);				\
    exit(EXIT_FAILURE);							\
  }
#else /* UNICODE */
#define syx_error(message, ...)						\
  {									\
    MessageBox (0, syx_to_wstring (message), L"Error", 0);		\
    exit(EXIT_FAILURE);							\
  }
#endif /* UNICODE */

#endif /* WINCE */


//! Display a warning message
#define syx_warning(...)			\
  {						\
    fprintf (stderr, "WARNING: ");		\
    fprintf (stderr, __VA_ARGS__);		\
  }

//! Display perror message and exit
#ifdef HAVE_PERROR
#define syx_perror(...)				\
  {						\
    perror (__VA_ARGS__);			\
    exit (EXIT_FAILURE);			\
  }
#else
#define syx_perror syx_error
#endif

//! Display debugging messages
#define syx_debug printf
    

#endif /* SYX_ERROR_H */
