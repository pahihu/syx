#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-interp.h"
#include "syx-memory.h"
#include "syx-init.h"

//#define DEBUG_PROCESS_SWITCH

static GMainLoop *main_loop = NULL;

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
    return SYX_NIL;

  if (SYX_IS_NIL (syx_processor_active_process))
    syx_processor_active_process = syx_processor_first_process;

  for (process=SYX_PROCESS_NEXT (syx_processor_active_process); ; process = SYX_PROCESS_NEXT (process))
    {
      if (SYX_IS_NIL (process))
	{
	  process = syx_processor_first_process;
	  if (SYX_IS_NIL (process))
	    return SYX_NIL;
	}

      if (SYX_IS_FALSE (SYX_PROCESS_SUSPENDED (process)))
	return process;
    }
}

void
syx_scheduler_init (void)
{
  static syx_bool initialized = FALSE;
  if (initialized)
    return;

  syx_processor = syx_globals_at ("Processor");
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

void
syx_scheduler_run (void)
{
  syx_bool running = FALSE;
  /*  GSource *idle;
  GMainContext *context;
  g_return_if_fail (main_loop == NULL || !g_main_loop_is_running (main_loop));*/

  if (running)
    return;
 
  /*  context = g_main_context_new ();
  main_loop = g_main_loop_new (context, FALSE);

  idle = g_idle_source_new ();
  g_source_set_callback (idle, _syx_scheduler_loop, NULL, NULL);
  g_source_set_priority (idle, G_PRIORITY_HIGH_IDLE);
  g_source_attach (idle, context);

  g_main_loop_run (main_loop);*/

  running = TRUE;

  syx_processor_active_process = _syx_scheduler_find_next_process ();
  while (!SYX_IS_NIL (syx_processor_first_process))
    {  
#ifdef DEBUG_PROCESS_SWITCH
      printf("SCHEDULER - Switch process with %p\n", syx_processor_active_process);
#endif

      syx_process_execute_scheduled (syx_processor_active_process);
      syx_processor_active_process = _syx_scheduler_find_next_process ();
    }

  running = FALSE;
}

void
syx_scheduler_quit (void)
{
  g_return_if_fail (g_main_loop_is_running (main_loop));

  g_main_loop_quit (main_loop);
}

void
syx_scheduler_add_process (SyxOop process)
{
  SyxOop inter_process;
  if (!SYX_IS_OBJECT (process))
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
      SYX_PROCESS_SCHEDULED(process) = SYX_TRUE;
    }
}

void
syx_scheduler_remove_process (SyxOop process)
{
  SyxOop inter_process, prev_process;

  if (SYX_OOP_EQ (process, syx_processor_first_process))
    {
      SYX_PROCESS_SCHEDULED(process) = SYX_FALSE;
      syx_processor_first_process = SYX_PROCESS_NEXT(process);
      return;
    }

  for (prev_process=inter_process=syx_processor_first_process; !SYX_IS_NIL(prev_process); prev_process=inter_process)
    {
      inter_process = SYX_PROCESS_NEXT(prev_process);
      if (SYX_OOP_EQ (inter_process, process))
	{
	  SYX_PROCESS_NEXT(prev_process) = SYX_PROCESS_NEXT(process);
	  SYX_PROCESS_SCHEDULED(process) = SYX_FALSE;
	  return;
	}
    }
}

guint
syx_scheduler_add_source (GSource *source)
{
  GMainContext *context = g_main_loop_get_context (main_loop);
  return g_source_attach (source, context);
}
