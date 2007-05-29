#include <glib.h>
#include "syx/syx.h"

SyxInstance *
syxvm_new (GSList *arguments, GError **error)
{
  SyxInstance *class = arguments->data;
  SyxInstance *instance;
  g_return_val_if_fail (SYX_IS_CLASS (class), NULL);

  instance = syx_instance_new_class (class);
  return instance;
}
