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

#include "syx-types.h"
#include "syx-object.h"

#include <stdio.h>

extern SyxOop syx_processor;
extern SyxOop *_syx_processor_first_process;
extern SyxOop *_syx_processor_active_process;
extern SyxOop *_syx_processor_byteslice;

typedef struct SyxSchedulerPoll SyxSchedulerPoll;

struct SyxSchedulerPoll
{
  syx_int32 fd;
  SyxOop semaphore;
  SyxSchedulerPoll *next;
};

void syx_scheduler_init (void);
void syx_scheduler_run (void);
void syx_scheduler_quit (void);

void syx_scheduler_add_process (SyxOop process);
void syx_scheduler_remove_process (SyxOop process);

void syx_scheduler_poll_read_register (syx_int32 fd, SyxOop semaphore);
void syx_scheduler_poll_write_register (syx_int32 fd, SyxOop semaphore);

//! Get the first process in the process linked list
#define syx_processor_first_process (*_syx_processor_first_process)

//! Get the byteslice
#define syx_processor_byteslice (*_syx_processor_byteslice)

//! Get the active process running on
#define syx_processor_active_process (*_syx_processor_active_process)


//! This is used internally
void _syx_scheduler_save (FILE *image);
void _syx_scheduler_load (FILE *image);


#endif /* SYX_SCHEDULER_H */
