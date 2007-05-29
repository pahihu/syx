#include <glib.h>
#include "syx/syx.h"

SyxPlugin *
plugin_init (void)
{
  return syx_plugin_new ("Kernel", TRUE, NULL);
}
