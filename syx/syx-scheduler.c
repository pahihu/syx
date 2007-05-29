#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-types.h"
#include "syx-object.h"
#include "syx-enums.h"
#include "syx-scheduler.h"
#include "syx-interp.h"

G_BEGIN_DECLS

static SyxObject *first_process;
static GMainLoop *main_loop = NULL;

SyxObject *syx_processor;
SyxObject **_syx_processor_active_process;
SyxObject **_syx_processor_byteslice;

static SyxObject *
_syx_scheduler_find_next_process ()
{
  SyxObject *process;

  // no processes have been scheduled
  if (SYX_IS_NIL (first_process))
    {
      g_error ("no processes have been scheduled");
    }

  if (SYX_IS_NIL (syx_processor_active_process))
    syx_processor_active_process = first_process;

  for (process=SYX_PROCESS_NEXT (syx_processor_active_process); ; process = SYX_PROCESS_NEXT (process))
    {
      if (SYX_IS_NIL (process))
	process = first_process;
      
      if (SYX_IS_FALSE (SYX_PROCESS_SUSPENDED (process)))
	return process;
    }
}

static gboolean
_syx_scheduler_loop (syx_pointer data)
{
  if (SYX_IS_NIL (first_process))
    {
      syx_scheduler_quit ();
      return FALSE;
    }
  
  syx_processor_active_process = _syx_scheduler_find_next_process ();
  syx_process_execute_scheduled (syx_processor_active_process);

  return TRUE;
}

void
syx_scheduler_init (void)
{
  syx_processor = syx_object_new (syx_process_scheduler_class);
  _syx_processor_active_process = &SYX_PROCESS_SCHEDULER_ACTIVE_PROCESS(syx_processor);
  _syx_processor_byteslice = &SYX_PROCESS_SCHEDULER_BYTESLICE(syx_processor);
}

void
syx_scheduler_run (void)
{
  GSource *idle;
  GMainContext *context;
  g_return_if_fail (main_loop == NULL || !g_main_loop_is_running (main_loop));
 
  context = g_main_context_new ();
  main_loop = g_main_loop_new (context, FALSE);

  idle = g_idle_source_new ();
  g_source_set_callback (idle, _syx_scheduler_loop, NULL, NULL);
  g_source_set_priority (idle, G_PRIORITY_HIGH_IDLE);
  g_source_attach (idle, context);

  g_main_loop_run (main_loop);
}

void
syx_scheduler_quit (void)
{
  g_return_if_fail (g_main_loop_is_running (main_loop));

  g_main_loop_quit (main_loop);
}

void
syx_scheduler_add_process (SyxObject *process)
{
  SyxObject *inter_process;
  g_return_if_fail (SYX_IS_POINTER (process));

  if (SYX_IS_FALSE (SYX_PROCESS_SCHEDULED(process)))
    {
      if (SYX_IS_NIL (first_process))
	first_process = syx_processor_active_process = process;
      else
	{
	  inter_process = SYX_PROCESS_NEXT(syx_processor_active_process);
	  SYX_PROCESS_NEXT(syx_processor_active_process) = process;
	  SYX_PROCESS_NEXT(process) = inter_process;
	}
      SYX_PROCESS_SCHEDULED(process) = SYX_TRUE;
    }
}

void
syx_scheduler_remove_process (SyxObject *process)
{
  SyxObject *inter_process;

  if (process == first_process)
    {
      first_process = SYX_PROCESS_NEXT(process);
      return;
    }

  inter_process=first_process;
  while (!SYX_IS_NIL(inter_process) && (inter_process=SYX_PROCESS_NEXT(inter_process)) != process);

  // process has not been scheduled
  if (SYX_IS_NIL (inter_process))
    return;

  SYX_PROCESS_NEXT(inter_process) = SYX_PROCESS_NEXT (process);
}

guint
syx_scheduler_add_source (GSource *source)
{
  GMainContext *context = g_main_loop_get_context (main_loop);
  return g_source_attach (source, context);
}


G_END_DECLS
