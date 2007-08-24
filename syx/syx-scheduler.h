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

#ifndef SYX_SCHEDULER_H
#define SYX_SCHEDULER_H

#include "syx-platform.h"
#include "syx-types.h"
#include "syx-object.h"

#include <stdio.h>

SYX_BEGIN_DECLS

EXPORT extern SyxOop syx_processor;
EXPORT extern SyxOop *_syx_processor_first_process;
EXPORT extern SyxOop *_syx_processor_active_process;
EXPORT extern SyxOop *_syx_processor_byteslice;

typedef struct SyxSchedulerPoll SyxSchedulerPoll;

/*! Each scheduler poll is a linked list which nodes contain a file descriptor and a Semaphore. */
struct SyxSchedulerPoll
{
  /*! File descriptor to wait for reading or writing */
  syx_int32 fd;
  /*! Semaphore to signal once ready to read or write */
  SyxOop semaphore;
  SyxSchedulerPoll *next;
};

EXPORT extern void syx_scheduler_init (void);
EXPORT extern void syx_scheduler_run (void);
EXPORT extern void syx_scheduler_quit (void);

EXPORT extern void syx_scheduler_add_process (SyxOop process);
EXPORT extern void syx_scheduler_remove_process (SyxOop process);

EXPORT extern void syx_scheduler_poll_read_register (syx_int32 fd, SyxOop semaphore);
EXPORT extern void syx_scheduler_poll_write_register (syx_int32 fd, SyxOop semaphore);

/*! Get the first process in the process linked list */
#define syx_processor_first_process (*_syx_processor_first_process)

/*! Get the byteslice */
#define syx_processor_byteslice (*_syx_processor_byteslice)

/*! Get the active process running on */
#define syx_processor_active_process (*_syx_processor_active_process)


/*! This is used internally */
EXPORT extern void _syx_scheduler_save (FILE *image);
EXPORT extern void _syx_scheduler_load (FILE *image);

SYX_END_DECLS

#endif /* SYX_SCHEDULER_H */
