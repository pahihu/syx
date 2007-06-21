#include <assert.h>
#include <stdio.h>
#include <sys/time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  struct timeval start, end;

  syx_init (".");
  syx_build_basic ();

  puts ("- Test saving image");
  gettimeofday (&start, NULL);
  assert (syx_memory_save_image ("test.sim") == TRUE);
  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n\n", end.tv_usec - start.tv_usec);

  puts ("- Test loading image");
  gettimeofday (&start, NULL);
  assert (syx_memory_load_image ("test.sim") == TRUE);
  gettimeofday (&end, NULL);
  printf ("Time elapsed: %ld microseconds\n\n", end.tv_usec - start.tv_usec);

  syx_quit ();

  return 0;
}
