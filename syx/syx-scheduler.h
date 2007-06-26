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
