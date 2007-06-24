#ifndef SYX_PLUGINS_H
#define SYX_PLUGINS_H

#include "syx-interp.h"

typedef struct SyxPluginEntry SyxPluginEntry;

struct SyxPluginEntry
{
  syx_string name;
  syx_pointer handle;
};

/* Dealing with dynamic libraries */

syx_pointer syx_library_open (syx_symbol location);
syx_pointer syx_library_symbol (syx_pointer handle, syx_symbol name);
syx_bool syx_library_close (syx_pointer handle);

/* Managing plugins */

typedef syx_bool (* SyxPluginInitializeFunc) (void);
typedef void (* SyxPluginFinalizeFunc) (void);

void syx_plugin_finalize (void);
syx_pointer syx_plugin_load (syx_symbol name);
syx_bool syx_plugin_unload (syx_symbol name);
syx_bool syx_plugin_call (SyxExecState *es, SyxOop method);

#endif /* SYX_PLUGINS_H */
