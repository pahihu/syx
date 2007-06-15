#include <stdio.h>
#include <syx/syx.h>

/*! \mainpage Smalltalk YX
    
    \b Smalltalk \b YX is an open source Smalltalk-80 implementation. 
    It's written in C and has these purposes:

        - Readable code 
        - Flexibility trough easy creations of plugins 
        - Portable to most important platforms 
        - Optimized 
        - Modern 
        - Embedding in C applications 
        - Easy to use, powerful and well-structured environment 
        - Small
*/

int main()
{
  SyxOop context;
  SyxOop process;

  syx_init ("..");
  if (!syx_memory_load_image ("default.sim"))
    {
      syx_build_basic ();

      context = syx_send_unary_message (syx_nil, syx_globals_at ("Console"), "run");
      process = syx_process_new (context);
      SYX_PROCESS_SUSPENDED(process) = syx_false;
      
      syx_scheduler_add_process (process);
    }

  syx_scheduler_run ();

  syx_memory_save_image ("default.sim");

  syx_quit ();

  return 0;
}
