#ifndef SYX_PLUGINS_H
#define SYX_PLUGINS_H

#include <glib.h>
#include <glib-object.h>
#include <gmodule.h>

G_BEGIN_DECLS

#define SYX_TYPE_PLUGIN (syx_plugin_get_type ())

typedef struct _SyxPlugin SyxPlugin;

struct _SyxPlugin {
  GModule *module;
  const gchar *name;
  const gchar *filename;
  gboolean is_permanent;

  gpointer *plugin_data;
};

typedef SyxPlugin* (* PluginInitFunc) (void);

SyxPlugin *syx_plugin_copy (const SyxPlugin *plugin);
void syx_plugin_free (SyxPlugin *plugin);
GType syx_plugin_get_type (void);
SyxPlugin *syx_plugin_new (const gchar *name, gboolean is_permanent, gpointer *plugin_data);
SyxPlugin *syx_plugin_load (const gchar *name, GError **error);
GSList *syx_get_loaded_plugins (void);

G_END_DECLS

#endif
