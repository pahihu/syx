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

#ifdef WINDOWS
  #ifndef WIN32_LEAN_AND_MEAN
  #define WIN32_LEAN_AND_MEAN
  #endif
  #include <windows.h>
  #include <winsock2.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-utils.h"
#include "syx-error.h"
#include "syx-interp.h"
#include "syx-memory.h"
#include "syx-init.h"

#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#include <sys/types.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#ifdef SYX_DEBUG_FULL
#define SYX_DEBUG_PROCESS_SWITCH
#endif

SyxOop syx_processor;
SyxOop *_syx_processor_first_process;
SyxOop *_syx_processor_active_process;
SyxOop *_syx_processor_byteslice;

static SyxSchedulerPoll *_syx_scheduler_poll_read = NULL;
static SyxSchedulerPoll *_syx_scheduler_poll_write = NULL;
static fd_set _syx_scheduler_poll_rfds;
static fd_set _syx_scheduler_poll_wfds;
static syx_int32 _syx_scheduler_poll_nfds = -1;
static void _syx_scheduler_poll_wait (void);
static SyxOop _syx_scheduler_find_next_process ();

static SyxOop 
_syx_scheduler_find_next_process ()
{
  SyxOop process;

  /* no processes have been scheduled */
  if (SYX_IS_NIL (syx_processor_first_process))
    return syx_nil;

  if (SYX_IS_NIL (syx_processor_active_process))
    syx_processor_active_process = syx_processor_first_process;

  for (process=SYX_PROCESS_NEXT (syx_processor_active_process); ; process = SYX_PROCESS_NEXT (process))
    {
      if (SYX_IS_NIL (process))
	{
	  process = syx_processor_first_process;
	  if (SYX_IS_NIL (process))
	    return syx_nil;
	}

      if (_syx_scheduler_poll_nfds != -1)
	_syx_scheduler_poll_wait ();

      if (SYX_IS_FALSE (SYX_PROCESS_SUSPENDED (process)))
	return process;
    }
}

static void
_syx_scheduler_poll_wait (void)
{
  static struct timeval tv = {0, 1};
  syx_int32 res, nfds;
  SyxSchedulerPoll *p, *oldp, *fp;
  fd_set r = _syx_scheduler_poll_rfds;
  fd_set w = _syx_scheduler_poll_wfds;

  res = select (_syx_scheduler_poll_nfds + 1, &r, &w, NULL, &tv);
  if (res == -1)
    {
      syx_perror ("SCHEDULER: ");
    }

  nfds = -1;

  for (oldp=NULL,p=_syx_scheduler_poll_read; p;)
    {
      if (FD_ISSET (p->fd, &r))
	{
	  if (oldp)
	    oldp->next = p->next;
	  else
	    _syx_scheduler_poll_read = p->next;
	  syx_semaphore_signal (p->semaphore);
	  fp = p;
	  p = p->next;
	  syx_free (fp);
	}
      else
	{
	  nfds = (nfds < p->fd ? p->fd : nfds);
	  oldp = p;
	  p = p->next;
	}
    }

  for (oldp=NULL,p=_syx_scheduler_poll_write; p;)
    {
      if (FD_ISSET (p->fd, &w))
	{
	  if (oldp)
	    oldp->next = p->next;
	  else
	    _syx_scheduler_poll_write = p->next;
	  syx_semaphore_signal (p->semaphore);
	  fp = p;
	  p = p->next;
	  syx_free (fp);
	}
      else
	{
	  nfds = (nfds < p->fd ? p->fd : nfds);
	  oldp = p;
	  p = p->next;
	}
    }

  _syx_scheduler_poll_nfds = nfds;
}

void
_syx_scheduler_save (FILE *image)
{
  syx_int32 index, data;
  SyxSchedulerPoll *p = _syx_scheduler_poll_read;
  
  while (p)
    {
      fputc (1, image);
      index = SYX_MEMORY_INDEX_OF (p->semaphore);
      data = p->fd;
      data = SYX_COMPAT_SWAP_32 (data);
      fwrite (&data, sizeof (syx_int32), 1, image);
      data = SYX_COMPAT_SWAP_32 (index);
      fwrite (&data, sizeof (syx_int32), 1, image);
      p = p->next;
    }
  fputc (0, image);
      
  p = _syx_scheduler_poll_write;
  while (p)
    {
      fputc (1, image);
      index = SYX_MEMORY_INDEX_OF (p->semaphore);
      data = p->fd;
      data = SYX_COMPAT_SWAP_32 (data);
      fwrite (&data, sizeof (syx_int32), 1, image);
      data = SYX_COMPAT_SWAP_32 (index);
      fwrite (&data, sizeof (syx_int32), 1, image);
      p = p->next;
    }
  fputc (0, image);
}

void
_syx_scheduler_load (FILE *image)
{
  syx_int32 index, data;
  SyxSchedulerPoll *p = NULL;

  _syx_scheduler_poll_read = NULL;
  while (fgetc (image))
    {
      if (p)
	{
	  p->next = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));
	  p = p->next;
	}
      else
	p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

      fread (&data, sizeof (syx_int32), 1, image);
      p->fd = SYX_COMPAT_SWAP_32 (data);
      fread (&data, sizeof (syx_int32), 1, image);
      index = SYX_COMPAT_SWAP_32 (data);
      p->semaphore = (SyxOop)(syx_memory + index);
      p->next = NULL;

      if (!_syx_scheduler_poll_read)
	_syx_scheduler_poll_read = p;
    }

  _syx_scheduler_poll_write = NULL;
  while (fgetc (image))
    {
      if (p)
	{
	  p->next = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));
	  p = p->next;
	}
      else
	p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

      fread (&data, sizeof (syx_int32), 1, image);
      p->fd = SYX_COMPAT_SWAP_32 (data);
      fread (&data, sizeof (syx_int32), 1, image);
      index = SYX_COMPAT_SWAP_32 (data);
      p->semaphore = (SyxOop)(syx_memory + index);
      p->next = NULL;

      if (!_syx_scheduler_poll_write)
	_syx_scheduler_poll_write = p;
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
      SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor) = syx_small_integer_new (20);
      syx_globals_at_put (syx_symbol_new ("Processor"), syx_processor);

      FD_ZERO(&_syx_scheduler_poll_rfds);
      FD_ZERO(&_syx_scheduler_poll_wfds);
    }

  _syx_processor_active_process = &SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(syx_processor);
  _syx_processor_first_process = &SYX_PROCESSOR_SCHEDULER_FIRST_PROCESS(syx_processor);
  _syx_processor_byteslice = &SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor);
}

/*! Run the scheduler in blocking mode. Exits once no Process is scheduled */
void
syx_scheduler_run (void)
{
  static syx_bool running = FALSE;

  if (running)
    return;


  running = TRUE;

  syx_processor_active_process = _syx_scheduler_find_next_process ();
  while (!SYX_IS_NIL (syx_processor_first_process))
    {  
#ifdef SYX_DEBUG_PROCESS_SWITCH
      syx_debug ("SCHEDULER - Switch process with %p\n", SYX_OBJECT(syx_processor_active_process));
#endif

      syx_process_execute_scheduled (syx_processor_active_process);
      syx_processor_active_process = _syx_scheduler_find_next_process ();
    }

  running = FALSE;
}

/*!
  Watch a file descriptor for reading

  \param fd the file descriptor
  \param semaphore called when fd is ready for reading
*/
void
syx_scheduler_poll_read_register (syx_int32 fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));
  p->fd = fd;
  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_read;
  _syx_scheduler_poll_read = p;

  if (fd > _syx_scheduler_poll_nfds)
    _syx_scheduler_poll_nfds = fd;

  FD_SET(fd, &_syx_scheduler_poll_rfds);
}

/*!
  Watch a file descriptor for writing

  \param fd the file descriptor
  \param semaphore called when fd is ready for writing
*/
void
syx_scheduler_poll_write_register (syx_int32 fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));
  p->fd = fd;
  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_write;
  _syx_scheduler_poll_write = p;

  if (fd > _syx_scheduler_poll_nfds)
    _syx_scheduler_poll_nfds = fd;

  FD_SET(fd, &_syx_scheduler_poll_wfds);
}

/*! Stop the scheduler */
void
syx_scheduler_quit (void)
{
  SyxSchedulerPoll *p, *pp;

  for (p=_syx_scheduler_poll_read; p;)
    {
      pp = p;
      p = p->next;
      syx_free (pp);
    }
  _syx_scheduler_poll_read = NULL;

  for (p=_syx_scheduler_poll_write; p;)
    {
      pp = p;
      p = p->next;
      syx_free (pp);
    }
  _syx_scheduler_poll_write = NULL;
}

/*! Add a Process to be scheduled */
void
syx_scheduler_add_process (SyxOop process)
{
  if (!SYX_IS_OBJECT (process))
    return;

  if (SYX_IS_FALSE (SYX_PROCESS_SCHEDULED(process)))
    {
      if (SYX_IS_NIL (syx_processor_first_process))
	syx_processor_first_process = syx_processor_active_process = process;
      else
	{
	  SYX_PROCESS_NEXT(process) = SYX_PROCESS_NEXT(syx_processor_first_process);
	  SYX_PROCESS_NEXT(syx_processor_first_process) = process;
	}
      SYX_PROCESS_SCHEDULED(process) = syx_true;
    }
}

/*! Remove a Process from being scheduled */
void
syx_scheduler_remove_process (SyxOop process)
{
  SyxOop inter_process, prev_process;

  if (SYX_OOP_EQ (process, syx_processor_first_process))
    {
      SYX_PROCESS_SCHEDULED(process) = syx_false;
      syx_processor_first_process = SYX_PROCESS_NEXT(process);
      return;
    }

  for (prev_process=syx_processor_first_process; !SYX_IS_NIL(prev_process); prev_process=inter_process)
    {
      inter_process = SYX_PROCESS_NEXT(prev_process);
      if (SYX_OOP_EQ (inter_process, process))
	{
	  SYX_PROCESS_NEXT(prev_process) = SYX_PROCESS_NEXT(process);
	  SYX_PROCESS_SCHEDULED(process) = syx_false;
	  break;
	}
    }

  if (SYX_OOP_EQ (process, syx_processor_active_process))
    syx_processor_active_process = syx_processor_first_process;
}

