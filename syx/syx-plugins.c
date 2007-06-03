
#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include "syx-init.h"
#include "syx-plugins.h"

static GSList *plugins = NULL;

SyxPlugin *
syx_plugin_copy (const SyxPlugin *plugin)
{
  return (SyxPlugin *)plugin;
}

void
syx_plugin_free (SyxPlugin *plugin)
{
  g_module_close (plugin->module);
  g_free (plugin);
}  

SyxPlugin *
syx_plugin_new (const gchar *name, gboolean is_permanent, gpointer *plugin_data)
{
  SyxPlugin *plugin = g_new0 (SyxPlugin, 1);
  plugin->module = NULL;
  plugin->name = name;
  plugin->filename = NULL;
  plugin->is_permanent = is_permanent;
  plugin->plugin_data = plugin_data;
  return plugin;
}

SyxPlugin *
syx_plugin_load (const gchar *name, GError **error)
{
  /*  GModule *module;
  SyxPlugin *plugin;
  PluginInitFunc plugin_init_func;
  gchar *filename;
  g_return_val_if_fail (g_module_supported (), NULL);
  g_return_val_if_fail (name != NULL, NULL);

  filename = g_build_filename (syx_get_root_path (), "plugins", name, g_strconcat (name, ".la", NULL), NULL);

  module = g_module_open (filename, G_MODULE_BIND_MASK);
  if (!module)
    g_error (g_module_error ());

  g_free (filename);

  if (!g_module_symbol (module, "plugin_init", (gpointer)&plugin_init_func))
    g_error (g_module_error ());

  plugin = plugin_init_func ();
  g_return_val_if_fail (plugin != NULL, NULL);
  if (plugin->is_permanent)
    g_module_make_resident (module);

  plugin->module = module;
  plugin->filename = filename;

  plugins = g_slist_append (plugins, plugin);

  return plugin;*/
}

GSList *
syx_get_loaded_plugins (void)
{
  return plugins;
}
