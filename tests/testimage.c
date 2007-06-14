#include <assert.h>
#include <stdio.h>
#include <time.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  clock_t start, end;

  syx_init (".");
  syx_build_basic ();

  puts ("- Test saving image");
  start = clock ();
  assert (syx_memory_save_image ("test.sim") == TRUE);
  end = clock ();
  printf ("Time elapsed: %f\n\n", ((double) (start - end)) / CLOCKS_PER_SEC);

  puts ("- Test loading image");
  start = clock ();
  assert (syx_memory_load_image ("test.sim") == TRUE);
  end = clock ();
  printf ("Time elapsed: %f\n\n", ((double) (start - end)) / CLOCKS_PER_SEC);

  syx_quit ();

  return 0;
}
