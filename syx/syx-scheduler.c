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
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-utils.h"
#include "syx-error.h"
#include "syx-interp.h"
#include "syx-memory.h"
#include "syx-init.h"
#include "syx-profile.h"

#ifdef SYX_DEBUG_FULL
#define SYX_DEBUG_PROCESS_SWITCH
#endif

SyxOop syx_processor;
SyxOop *_syx_processor_active_process;
SyxOop *_syx_processor_byteslice;

SyxSchedulerPoll *_syx_scheduler_poll_sources = NULL;

/* These are implemented in scheduler-posix or scheduler-win */
void _syx_scheduler_init_platform (void);
void _syx_scheduler_poll_wait_platform (void);
void _syx_scheduler_quit_platform (void);

static void
_syx_scheduler_poll_wait (void)
{
  SyxSchedulerPoll *source = _syx_scheduler_poll_sources;
  for (source=_syx_scheduler_poll_sources; source; source=source->next)
    {
      SyxSchedulerSourceFunc func = (SyxSchedulerSourceFunc)source->fd;
      if (func ())
        syx_semaphore_signal (source->semaphore);
    }

  _syx_scheduler_poll_wait_platform ();
}

static SyxOop 
_syx_scheduler_find_next_process ()
{
  SyxOop process;

  /* no processes have been scheduled */
  if (SYX_IS_NIL (syx_processor_active_process))
    return syx_nil;

  for (process=SYX_PROCESS_NEXT (syx_processor_active_process); ; process = SYX_PROCESS_NEXT (process))
    {
      /* This loop won't break until a resumed process is found, so we call the poll from here */
      _syx_scheduler_poll_wait ();

      if (SYX_IS_FALSE (SYX_PROCESS_SUSPENDED (process)))
        return process;
    }
}

/*!
  Initialize the scheduler.

  If absent, create a ProcessorScheduler instance named Processor and insert it into the Smalltalk dictionary.
*/
void
syx_scheduler_init (void)
{
  syx_processor = syx_globals_at_if_absent ("Processor", syx_nil);
  if (SYX_IS_NIL (syx_processor))
    {
      syx_processor = syx_object_new (syx_processor_scheduler_class);
      SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor) = syx_small_integer_new (100);
      syx_globals_at_put (syx_symbol_new ("Processor"), syx_processor);

      _syx_scheduler_init_platform ();
    }

  _syx_processor_active_process = &SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(syx_processor);
  _syx_processor_byteslice = &SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor);
}

/*!
  Do a single iteration of the scheduler.
  Returns FALSE when no pending processes are left.
*/
syx_bool
syx_scheduler_iterate (void)
{
  syx_processor_active_process = _syx_scheduler_find_next_process ();
  if (SYX_IS_NIL (syx_processor_active_process))
    return FALSE;

  syx_process_execute_scheduled (syx_processor_active_process);
  return TRUE;
}

/*! Run the scheduler in blocking mode. Exits once no Process is scheduled */
void
syx_scheduler_run (void)
{
  static syx_bool running = FALSE;

  SYX_START_PROFILE;

  if (running)
    return;


  running = TRUE;

  while (!SYX_IS_NIL (syx_processor_active_process = _syx_scheduler_find_next_process ()))
    {  
#ifdef SYX_DEBUG_PROCESS_SWITCH
      syx_debug ("SCHEDULER - Switch process with %p\n", SYX_OBJECT(syx_processor_active_process));
#endif

      syx_process_execute_scheduled (syx_processor_active_process);
    }

  running = FALSE;

  SYX_END_PROFILE(scheduler);
}

/*!
  The scheduler runs the callback to check whether the source is ready then signal the semaphore.
  To tell that the source is ready, return TRUE from the callback, otherwise FALSE.

  \param callback the callback to call for each scheduler iteration
  \param semaphore the semaphore to signal when the source is ready
*/
void
syx_scheduler_poll_register_source (SyxSchedulerSourceFunc callback, SyxOop semaphore)
{
  SyxSchedulerPoll *s = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));
  s->fd = (syx_nint) callback;
  s->semaphore = semaphore;
  s->next = _syx_scheduler_poll_sources;
  _syx_scheduler_poll_sources = s;
}

/*!
  Remove an idle source previously added with syx_scheduler_poll_register_source
*/
void
syx_scheduler_poll_unregister_source (SyxSchedulerSourceFunc callback, SyxOop semaphore)
{
  SyxSchedulerPoll *s, *pre;

  for (s=_syx_scheduler_poll_sources, pre=NULL; s; s=s->next)
    {
      if (s->fd == (syx_nint)callback && s->semaphore == semaphore)
        {
          if (!pre)
            _syx_scheduler_poll_sources = s->next;
          else
            pre->next = s->next;
          syx_free (s);
        }
    }
}

/*! Stop the scheduler */
void
syx_scheduler_quit (void)
{
  _syx_scheduler_quit_platform ();
}

/*! Add a Process to be scheduled.
  \param process a valid Process
  \return TRUE if the given Process has been scheduled successfully, FALSE otherwise */
syx_bool
syx_scheduler_add_process (SyxOop process)
{
  if (SYX_IS_TRUE (SYX_PROCESS_SCHEDULED (process)))
    return FALSE;

  if (SYX_IS_NIL (syx_processor_active_process))
    SYX_PROCESS_NEXT(process) = syx_processor_active_process = process;
  else
    {
      SYX_PROCESS_NEXT(process) = SYX_PROCESS_NEXT(syx_processor_active_process);
      SYX_PROCESS_NEXT(syx_processor_active_process) = process;
    }
  SYX_PROCESS_SCHEDULED(process) = syx_true;
  return TRUE;
}

/*! Remove a Process from being scheduled.
  \param process a valid Process
  \return TRUE if the given Process has been found and removed successfully, FALSE otherwise */
syx_bool
syx_scheduler_remove_process (SyxOop process)
{
  SyxOop cur_process, prev_process;

  if (SYX_IS_NIL (syx_processor_active_process))
    return FALSE;

  if (SYX_OOP_EQ (process, syx_processor_active_process) && SYX_OOP_EQ (SYX_PROCESS_NEXT (process), process))
    {
      /* The active process was the only being scheduled */
      SYX_PROCESS_SCHEDULED(process) = syx_false;
      syx_processor_active_process = syx_nil;
      return TRUE;
    }
  else
    {
      prev_process = syx_processor_active_process;
      cur_process = SYX_PROCESS_NEXT (prev_process);
      do
        {
          if (SYX_OOP_EQ (cur_process, process))
            {
              SYX_PROCESS_NEXT(prev_process) = SYX_PROCESS_NEXT (process);
              SYX_PROCESS_SCHEDULED(process) = syx_false;
              /* We can't remove the activeProcess without replacing it with another one.
                 We chose the previous so that the next one is executed. */
              if (SYX_OOP_EQ (process, syx_processor_active_process))
                syx_processor_active_process = prev_process;
              return TRUE;
            }
          prev_process=cur_process;
          cur_process = SYX_PROCESS_NEXT(prev_process);
        } while (SYX_OOP_NE (cur_process, SYX_PROCESS_NEXT (syx_processor_active_process)));
    }

  return FALSE;
}

