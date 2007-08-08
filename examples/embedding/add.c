#include <syx/syx.h>

int main (int argc, char *argv[])
{
  SyxOop instance;
  SyxOop context;
  SyxOop process;
  SyxOop result;

  /* initialize Syx */
  syx_init (argc, argv, NULL);
  
  /* load the default image */
  syx_memory_load_image (NULL);
  
  /* now file in class and method declarations from our ST file */
  syx_cold_file_in ("add.st");

  /* create a Sum instance */
  instance = syx_object_new (syx_globals_at ("Sum"));
  
  /* create a MethodContext which sends the #with:and: message */
  context = syx_send_message (syx_nil,                     // the parent context
			      instance,                    // the receiver
			      "with:and:",                 // the selector
			      2,                           // the number of arguments
			      syx_small_integer_new (41),   // first argument
			      syx_small_integer_new (22));

  /* now create a Process with that context */
  process = syx_process_new (context);

  /* execute the process in blocking mode */
  syx_process_execute_blocking (process);

  /* fetch the last returned object (an instance variable of Process) */
  result = SYX_PROCESS_RETURNED_OBJECT (process);

  printf ("The result is %d\n", SYX_SMALL_INTEGER (result));

  /* cleanup Syx */
  syx_quit ();
  
  return 0;
}
