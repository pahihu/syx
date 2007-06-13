#ifndef SYX_SCHEDULER_H
#define SYX_SCHEDULER_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"

extern SyxOop syx_processor;
extern SyxOop *_syx_processor_first_process;
extern SyxOop *_syx_processor_active_process;
extern SyxOop *_syx_processor_byteslice;

void syx_scheduler_init (void);
void syx_scheduler_run (void);
void syx_scheduler_quit (void);

void syx_scheduler_add_process (SyxOop process);
void syx_scheduler_remove_process (SyxOop process);

//! Get the first process in the process linked list
#define syx_processor_first_process (*_syx_processor_first_process)

//! Get the byteslice
#define syx_processor_byteslice (*_syx_processor_byteslice)

//! Get the active process running on
#define syx_processor_active_process (*_syx_processor_active_process)

#endif /* SYX_SCHEDULER_H */
