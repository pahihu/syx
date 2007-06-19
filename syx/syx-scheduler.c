#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-error.h"
#include "syx-interp.h"
#include "syx-memory.h"
#include "syx-init.h"

#ifdef SYX_DEBUG_FULL
#define SYX_DEBUG_PROCESS_SWITCH
#endif

SyxOop syx_processor;
SyxOop *_syx_processor_first_process;
SyxOop *_syx_processor_active_process;
SyxOop *_syx_processor_byteslice;

static SyxOop 
_syx_scheduler_find_next_process ()
{
  SyxOop process;

  // no processes have been scheduled
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

      if (SYX_IS_FALSE (SYX_PROCESS_SUSPENDED (process)))
	return process;
    }
}

//! Initialize the scheduler
/*!
  If absent, create a ProcessorScheduler instance named Processor and insert it into the Smalltalk dictionary.
*/
void
syx_scheduler_init (void)
{
  static syx_bool initialized = FALSE;
  if (initialized)
    return;

  syx_processor = syx_globals_at_if_absent ("Processor", syx_nil);
  if (SYX_IS_NIL (syx_processor))
    {
      syx_processor = syx_object_new (syx_processor_scheduler_class, TRUE);
      SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor) = syx_small_integer_new (20);
      syx_globals_at_put (syx_symbol_new ("Processor"), syx_processor);
    }

  _syx_processor_active_process = &SYX_PROCESSOR_SCHEDULER_ACTIVE_PROCESS(syx_processor);
  _syx_processor_first_process = &SYX_PROCESSOR_SCHEDULER_FIRST_PROCESS(syx_processor);
  _syx_processor_byteslice = &SYX_PROCESSOR_SCHEDULER_BYTESLICE(syx_processor);

  initialized = TRUE;
}

//! Run the scheduler in blocking mode. Exits once no Process is scheduled
void
syx_scheduler_run (void)
{
  syx_bool running = FALSE;

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

//! Stop the scheduler
void
syx_scheduler_quit (void)
{
  syx_processor_first_process = syx_nil;
  syx_processor_active_process = syx_nil;
}

//! Adds a Process to be scheduled
void
syx_scheduler_add_process (SyxOop process)
{
  SyxOop inter_process;
  if (!SYX_IS_POINTER (process))
    return;

  if (SYX_IS_FALSE (SYX_PROCESS_SCHEDULED(process)))
    {
      if (SYX_IS_NIL (syx_processor_first_process))
	syx_processor_first_process = syx_processor_active_process = process;
      else
	{
	  inter_process = SYX_PROCESS_NEXT(syx_processor_active_process);
	  SYX_PROCESS_NEXT(process) = SYX_PROCESS_NEXT(syx_processor_active_process);
	  SYX_PROCESS_NEXT(syx_processor_active_process) = process;
	}
      SYX_PROCESS_SCHEDULED(process) = syx_true;
    }
}

//! Remove a Process from being scheduled
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

  for (prev_process=inter_process=syx_processor_first_process; !SYX_IS_NIL(prev_process); prev_process=inter_process)
    {
      inter_process = SYX_PROCESS_NEXT(prev_process);
      if (SYX_OOP_EQ (inter_process, process))
	{
	  SYX_PROCESS_NEXT(prev_process) = SYX_PROCESS_NEXT(process);
	  SYX_PROCESS_SCHEDULED(process) = syx_false;
	  return;
	}
    }
}

