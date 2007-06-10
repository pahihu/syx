#include <assert.h>
#include <stdio.h>
#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  GTimer *timer;

  syx_init ("..");
  syx_build_basic ();

  timer = g_timer_new ();

  puts ("- Test saving image");
  g_timer_start (timer);
  assert (syx_memory_save_image ("test.sim") == TRUE);
  g_timer_stop (timer);
  printf ("Time elapsed: %f\n\n", g_timer_elapsed (timer, NULL));

  puts ("- Test loading image");
  g_timer_start (timer);
  assert (syx_memory_load_image ("test.sim") == TRUE);
  g_timer_stop (timer);
  printf ("Time elapsed: %f\n\n", g_timer_elapsed (timer, NULL));

  g_timer_destroy (timer);
}
