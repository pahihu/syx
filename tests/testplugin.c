#include "../syx/syx.h"

int
main (int argc, char *argv[])
{
  SyxPlugin *plugin;
  syx_init ("..");
  
  plugin = syx_plugin_load ("kernel", NULL);

  return 0;
}
