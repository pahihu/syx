/* Thanks to Dominic Letz for this example */

#include <stdlib.h>
#include <syx/syx.h>

int main (int argc, char *argv[])
{
   SyxOop context;
   SyxOop process;

   /* initialize Syx */
   syx_init (argc, argv, NULL);

   /* load the default image */
   syx_memory_load_image (NULL);

   /* now file in class and method declarations from our ST file */
   syx_cold_file_in ("browser.st");

   /* create a MethodContext which sends the #with:and: message */
   context = syx_send_binary_message(syx_nil, // the parent context
				     syx_globals_at("WebBrowser"), // the receiver
				     "run:", // the selector
				     syx_string_new(getenv("QUERY_STRING")));

   /* now create a Process with that context */
   process = syx_process_new (context);

   /* execute the process in blocking mode */
   syx_process_execute_blocking (process);

   /* cleanup Syx */
   syx_quit ();

   return 0;
} 
