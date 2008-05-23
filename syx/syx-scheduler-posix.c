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

#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#include <sys/types.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

static SyxSchedulerPoll *_syx_scheduler_poll_read = NULL;
static SyxSchedulerPoll *_syx_scheduler_poll_write = NULL;
static fd_set _syx_scheduler_poll_rfds;
static fd_set _syx_scheduler_poll_wfds;
static syx_int32 _syx_scheduler_poll_nfds = -1;

static int
_syx_scheduler_process_poll (int res, SyxSchedulerPoll *poll, fd_set *fds)
{
  SyxSchedulerPoll *p, *oldp, *tmp;
  for (oldp=NULL, p=poll; p && res > 0;)
    {
      if (FD_ISSET (p->fd, fds))
        {
          if (oldp)
            oldp->next = p->next;
          else
            _syx_scheduler_poll_read = p->next;
          syx_semaphore_signal (p->semaphore);

          /* Unset the fd from the original fd_set */
          FD_CLR (p->fd, fds);

          tmp = p;
          p = p->next;
          syx_free (tmp);

          /* Decrement res to stop the loop once we found all the ready descriptors */
          res--;
        }
      else
        {
          /* Save the maximum file descriptor number */
          if (p->fd > _syx_scheduler_poll_nfds)
            _syx_scheduler_poll_nfds = p->fd;
          oldp = p;
          p = p->next;
        }
    }
  return res;
}

void
_syx_scheduler_init_platform (void)
{
  FD_ZERO(&_syx_scheduler_poll_rfds);
  FD_ZERO(&_syx_scheduler_poll_wfds);
}

void
_syx_scheduler_poll_wait_platform (void)
{
  static struct timeval tv = {0, 1};
  syx_int32 res;
  /* we copy file descriptors because select will change them */
  fd_set r = _syx_scheduler_poll_rfds;
  fd_set w = _syx_scheduler_poll_wfds;

  res = select (_syx_scheduler_poll_nfds + 1, &r, &w, NULL, &tv);
  if (res == -1)
    return;

  if (res > 0)
    {
      _syx_scheduler_poll_nfds = -1;

      res = _syx_scheduler_process_poll (res, _syx_scheduler_poll_read, &_syx_scheduler_poll_rfds);
      (void) _syx_scheduler_process_poll (res, _syx_scheduler_poll_write, &_syx_scheduler_poll_wfds);
    }
}

void
_syx_scheduler_quit_platform (void)
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
  Watch a file descriptor for writing

  \param fd the file descriptor
  \param semaphore to signal when fd is ready for reading
*/
void
syx_scheduler_poll_read_register (syx_nint fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

  p->fd = fd;
  if (fd > _syx_scheduler_poll_nfds)
    _syx_scheduler_poll_nfds = fd;

  FD_SET(fd, &_syx_scheduler_poll_rfds);
  
  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_read;
  _syx_scheduler_poll_read = p;
}

/*!
  Watch a file descriptor for writing

  \param fd the file descriptor
  \param semaphore to signal when fd is ready for writing
*/
void
syx_scheduler_poll_write_register (syx_nint fd, SyxOop semaphore)
{
  SyxSchedulerPoll *p = (SyxSchedulerPoll *) syx_malloc (sizeof (SyxSchedulerPoll));

  p->fd = fd;
  if (fd > _syx_scheduler_poll_nfds)
    _syx_scheduler_poll_nfds = fd;

  FD_SET(fd, &_syx_scheduler_poll_wfds);

  p->semaphore = semaphore;
  p->next = _syx_scheduler_poll_write;
  _syx_scheduler_poll_write = p;
}
