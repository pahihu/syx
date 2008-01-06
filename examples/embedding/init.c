#include "../../syx/syx.h"

int main (int argc, char *argv[])
{
  /* initialize Syx */
  syx_init (argc, argv, NULL);
  
  /* load the default image */
  syx_memory_load_image (NULL);
  
  /* cleanup Syx */
  syx_quit ();
  
  return 0;
}
