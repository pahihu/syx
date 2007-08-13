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

#include "syx-types.h"
#include "syx-utils.h"
#include "syx-interp.h"
#include "syx-signal.h"
#include "syx-init.h"

#include <stdio.h>
#include <signal.h>

static SyxOop sigint_class,
  sigfpe_class,
  sigterm_class,
  sigabrt_class;

static void
_syx_smalltalk_sighandler (int signum)
{
  SyxOop klass;
  SyxOop context;

  switch (signum)
    {
    case SIGINT:
      klass = sigint_class;
      break;
    case SIGFPE:
      klass = sigfpe_class;
      break;
    case SIGTERM:
      klass = sigterm_class;
      break;
    case SIGABRT:
      klass = sigabrt_class;
      break;
    default:
      printf ("Unknown signal %d has been handled\n", signum);
      return;
    }
  
  context = syx_send_unary_message (syx_interp_get_current_context (), klass, "signal");
  syx_interp_enter_context (context);
}

static void
_syx_internal_sighandler (int signum)
{
  switch (signum)
    {
    case SIGILL:
      puts ("***** Illegal Instruction *****");
      break;
    case SIGSEGV:
      puts ("***** Segmentation Violation *****");
      break;
    default:
      printf ("***** Unknown signal %d *****\n", signum);
      break;
    }
  
  syx_show_traceback ();
  exit (EXIT_FAILURE);
}

void
syx_signal_init (void)
{
  sigint_class = syx_globals_at ("UserInterrupt");
  sigfpe_class = syx_globals_at ("FloatingPointException");
  sigterm_class = syx_globals_at ("TerminationSignal");
  sigabrt_class = syx_globals_at ("AbnormalTermination");
  
  /* Internal handled signals */
  signal (SIGILL, _syx_internal_sighandler);
  signal (SIGSEGV, _syx_internal_sighandler);

  /* Smalltalk handled signals */
  signal (SIGINT, _syx_smalltalk_sighandler);
  signal (SIGFPE, _syx_smalltalk_sighandler);
  signal (SIGTERM, _syx_smalltalk_sighandler);
  signal (SIGABRT, _syx_smalltalk_sighandler);
}
