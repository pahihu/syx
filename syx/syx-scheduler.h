#ifndef _SYX_SCHEDULER_H
#define _SYX_SCHEDULER_H

#include <glib.h>
#include "syx-types.h"
#include "syx-object.h"

G_BEGIN_DECLS

extern SyxObject *syx_processor;
extern SyxObject **_syx_processor_active_process;
extern SyxObject **_syx_processor_byteslice;

void syx_scheduler_init (void);
void syx_scheduler_run (void);
void syx_scheduler_quit (void);

void syx_scheduler_add_process (SyxObject *process);
void syx_scheduler_remove_process (SyxObject *process);
syx_uint32 syx_scheduler_add_source (GSource *source);

#define syx_processor_byteslice (*_syx_processor_byteslice)
#define syx_processor_active_process (*_syx_processor_active_process)

G_END_DECLS

#endif
