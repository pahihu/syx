#include "../../syx/syx.h"

int main (int argc, char *argv[])
{
  /* initialize Syx */
  syx_init (argc, argv, NULL);
  
  /* load the default image */
  syx_memory_load_image (NULL);
  
  /* now file in our file in blocking mode, .i.e without scheduling the Process */
  syx_file_in_blocking ("do-me.st");

  /* cleanup Syx */
  syx_quit ();
  
  return 0;
}
