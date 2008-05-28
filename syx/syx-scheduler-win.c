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
#include "syx-scheduler.h"

#ifdef WINDOWS
  #ifndef WIN32_LEAN_AND_MEAN
  #define WIN32_LEAN_AND_MEAN
  #endif
  #include <windows.h>
  #include <winsock2.h>
#endif

#include "syx-platform.h"
#include "syx-object.h"

static SyxSchedulerPoll *_syx_scheduler_poll_windows = NULL;

void
_syx_scheduler_init_platform (void)
{
}

void
_syx_scheduler_poll_wait_platform (void)
{
  SyxSchedulerPoll *wpoll = _syx_scheduler_poll_windows;
  SyxSchedulerPoll *oldwpoll = NULL;
  SyxSchedulerPoll *tmp = NULL;
  DWORD res;

  while (wpoll)
    {
      res = WaitForSingleObject ((HANDLE)wpoll->fd, 0);
      switch (res)
	{
	case WAIT_OBJECT_0:
	  if (oldwpoll)
	    oldwpoll->next = wpoll->next;
	  else
	    _syx_scheduler_poll_windows = wpoll->next;
	  syx_semaphore_signal (wpoll->semaphore);
	case WAIT_ABANDONED:
	  tmp = wpoll;
	  wpoll = wpoll->next;
	  syx_free (wpoll);
	  break;
	default:
	  oldwpoll = wpoll;
	  wpoll = wpoll->next;
	  break;
	}
    }
}

void
_syx_scheduler_quit_platform (void)
{
  SyxSchedulerPoll *p, *pp;

  for (p=_syx_scheduler_poll_windows; p;)
    {
      pp = p;
      p = p->next;
      syx_free (pp);
    }

  _syx_scheduler_poll_windows = NULL;
}

void
_syx_scheduler_save (FILE *image)
{
  /* TODO: */
}

void
_syx_scheduler_load (FILE *image)
{
  /* TODO: */
}

/*!
  Watch a file descriptor for writing

  \param fd the HANDLE
  \param semaphore to signal when fd is ready for reading
*/
void
syx_scheduler_poll_read_register (syx_nint fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

  p->fd = fd;
  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_windows;
  _syx_scheduler_poll_windows = p;
}

/*!
  Watch a file descriptor for writing

  \param fd the HANDLE
  \param semaphore to signal when fd is ready for writing
*/
void
syx_scheduler_poll_write_register (syx_nint fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

  p->fd = fd;
  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_windows;
  _syx_scheduler_poll_windows = p;
}
