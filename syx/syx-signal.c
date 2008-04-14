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

#include "syx-object.h"
#include "syx-types.h"
#include "syx-utils.h"
#include "syx-interp.h"
#include "syx-memory.h"
#include "syx-signal.h"
#include "syx-init.h"

#include <stdio.h>

#ifdef HAVE_SIGNAL
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
  
  context = syx_send_unary_message (klass, "signal");
  syx_interp_enter_context (syx_processor_active_process, context);
}

static void
_syx_save_recovered_image (void)
{
  SyxOop process = syx_processor_active_process;
  syx_string image_path;
  syx_symbol cur_image_path = SYX_OBJECT_SYMBOL (syx_globals_at ("ImageFileName"));
  
  image_path = (syx_string) syx_calloc (strlen (cur_image_path) + 9, sizeof (syx_char));
  sprintf(image_path, "%s.recover", cur_image_path);

  if (SYX_IS_NIL (process))
    {
      printf("\nCan't save a recovered copy of the image at %s.\n", image_path);
      return;
    }

  SYX_PROCESS_STACK(process) = syx_nil;
  SYX_PROCESS_SUSPENDED(process) = syx_true;
  SYX_PROCESS_SCHEDULED(process) = syx_false;
  syx_scheduler_remove_process (process);

  if (!syx_memory_save_image (image_path))
    printf("\nCan't save a recovered copy of the image at %s.\n", image_path);
  else
    printf("\nRecovered copy of the image has been created at %s.\n", image_path);
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
  _syx_save_recovered_image ();
  puts ("\nPlease send the above bug report to \"lethalman88@gmail.com\".");
  exit (EXIT_FAILURE);
}
#endif /* HAVE_SIGNAL */

/*!
  Initialize the system signal handling system.

  This function is called internally by Syx and should not be used by applications.

  Register SIGINT, SIGFPE, SIGTERM and SIGABRT to be signaled in the Smalltalk environment
  respectively with UserInterrupt, FloatingPointException, TerminationSignal and AbornmalTermination.

  SIGILL and SIGSEGV, are handled internally and control shouldn't be given to the Smalltalk environment
*/
void
syx_signal_init (void)
{
#ifdef HAVE_SIGNAL
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
#endif /* HAVE_SIGNAL */
}
