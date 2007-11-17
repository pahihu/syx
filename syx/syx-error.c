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

#include "syx-memory.h"
#include "syx-platform.h"
#include "syx-config.h"
#include "syx-error.h"
#include "syx-interp.h"
#include "syx-types.h"
#include "syx-object.h"

#include <assert.h>

static SyxErrorEntry **_syx_error_entries = NULL;
static SyxErrorType _syx_error_entries_top = 0;

#ifndef HAVE_ERRNO_H
int errno=0;
#endif

/*!
  Initialize the error reporting system.

  This function must be called after the image has been loaded or a new image is built.
  Usually, user programs don't need to call this directly.
*/
void
syx_error_init (void)
{
  _syx_error_entries_top = 0;
  assert (syx_error_register ("Interpreter internal fail", syx_globals_at ("VMError")) == SYX_ERROR_INTERP);
  assert (syx_error_register ("Not found", syx_globals_at ("NotFound")) == SYX_ERROR_NOT_FOUND);
  assert (syx_error_register ("Wrong number of arguments",
			      syx_globals_at ("WrongArgumentCount")) == SYX_ERROR_WRONG_ARGUMENT_COUNT);
}

/*!
  Clear all memory allocated to by the error reporting system.

  This function must be called after all other memory has been released and we're really ready to quit,
  so that any other call won't report errors.
  Usually, user programs don't need to call this directly.
*/
void
syx_error_clear (void)
{
  SyxErrorType i;
  for (i=0; i < _syx_error_entries_top; i++)
    syx_free (_syx_error_entries[i]);

  syx_free (_syx_error_entries);
}

/*!
  Register a kind of error.

  Create a new hook for reporting errors from C to the Smalltalk environment.

  \return a number identifying the king of error for future lookups
*/
SyxErrorType
syx_error_register (syx_symbol name, SyxOop klass)
{
  SyxErrorEntry *entry = (SyxErrorEntry *)syx_malloc (sizeof (SyxErrorEntry));
  if (!_syx_error_entries)
    _syx_error_entries = (SyxErrorEntry **)syx_calloc (++_syx_error_entries_top, sizeof (SyxErrorEntry *));
  else
    _syx_error_entries = (SyxErrorEntry **)syx_realloc (_syx_error_entries,
							(++_syx_error_entries_top) * sizeof (SyxErrorEntry *));

  entry->name = name;
  entry->klass = klass;

  _syx_error_entries[_syx_error_entries_top - 1] = entry;
  return _syx_error_entries_top - 1;
}

/*!
  Lookup for an error.

  \param type the type return from syx_error_register
  \return the entry of the error
*/
SyxErrorEntry *
syx_error_lookup (SyxErrorType type)
{
  if (type >= _syx_error_entries_top)
    return NULL;

  return _syx_error_entries[type];
}

/*!
  Signal an error in the Smalltalk environment, sending #signal to he requested class.

  \param type the type returned by syx_error_register
  \return TRUE if signal succeeded, otherwise FALSE
*/
syx_bool
syx_signal (SyxErrorType type, SyxOop message)
{
  SyxOop context;
  SyxErrorEntry *entry;
  
  entry = syx_error_lookup (type);
  if (!entry)
    return FALSE;

  if (!syx_system_initialized)
    {
      if (SYX_OBJECT_IS_STRING (message) || SYX_OBJECT_IS_SYMBOL (message))
	syx_error ("%s %s\n", entry->name, SYX_OBJECT_SYMBOL (message));
      else
	syx_error (entry->name);
    }

  if (SYX_IS_NIL (message))
    context = syx_send_unary_message (_syx_exec_state->process, syx_interp_get_current_context (),       
				      entry->klass, "signal");
  else
    context = syx_send_binary_message (_syx_exec_state->process, syx_interp_get_current_context (),
				       entry->klass, "signal:", message);

  syx_interp_enter_context (context);

  return TRUE;
}

/*!
  Create an error Context in the Smalltalk environment ready to enter a Process.

  \param type the type returned by syx_error_register
*/
SyxOop
syx_signal_create_context (SyxErrorType type, SyxOop message)
{
  SyxOop context;
  SyxErrorEntry *entry;
  
  entry = syx_error_lookup (type);
  if (!entry)
    return syx_nil;

  if (SYX_IS_NIL (message))
    context = syx_send_unary_message (_syx_exec_state->process, syx_interp_get_current_context (),       
				      entry->klass, "signal");
  else
    context = syx_send_binary_message (_syx_exec_state->process, syx_interp_get_current_context (),
				       entry->klass, "signal:", message);

  return context;
}

/*!
  Display an error then exits.

  This function will show an error MessageBox on Windows CE
*/
#ifndef WINCE
void
syx_error (syx_symbol fmt, ...)
{
  va_list ap;
  fprintf (stderr, "ERROR: ");
  va_start (ap, fmt);
  vfprintf (stderr, fmt, ap);
  va_end (ap);
  fprintf (stderr, "\n");
  exit (EXIT_FAILURE);
}
#else /* WINCE */
void
syx_error (syx_symbol fmt, ...)
{
  MessageBox (0, SYX_IFDEF_UNICODE (message), "Error", 0);
  exit (EXIT_FAILURE);
}
#endif /* WINCE */

/*! Display a warning message */
void
syx_warning (syx_symbol fmt, ...)
{
  va_list ap;
  fprintf (stderr, "WARNING: ");	       
  va_start (ap, fmt);
  vfprintf (stderr, fmt, ap);
  va_end (ap);
}

/*! Display perror message and exit */
void
syx_perror (syx_symbol message)
{
#ifdef HAVE_PERROR
  perror (message);
#else
  fputs (message, stderr);
#endif

  exit (EXIT_FAILURE);
}
