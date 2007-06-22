#include "syx/syx.h"

static syx_pointer _syx_gtk_main_thread = NULL;

static void
_syx_gtk_main (void)
{
   gtk_main ();
}

SYX_FUNC_PRIMITIVE(GtkWindow_new)
{
  syx_pointer w = (syx_pointer)gtk_window_new (0);
  SYX_PRIM_RETURN((SyxOop)w);
}

SYX_FUNC_PRIMITIVE(GtkWidget_showAll)
{
  syx_pointer w = SYX_OOP_CAST_POINTER(SYX_OBJECT_DATA(es->message_receiver)[0]);
  gtk_widget_show_all(w);
  SYX_PRIM_RETURN(es->message_receiver);
}

SYX_FUNC_PRIMITIVE(Gtk_main)
{
  if (!_syx_gtk_main_thread)
    _syx_gtk_main_thread = g_thread_create_full (_syx_gtk_main, NULL, 0, FALSE, FALSE,
						 1, NULL);

  SYX_PRIM_RETURN(es->message_receiver);
}

SYX_FUNC_PRIMITIVE(Gtk_mainQuit)
{
  if (_syx_gtk_main_thread)
    {
      gtk_main_quit ();
      _syx_gtk_main_thread = NULL;
    }

  SYX_PRIM_RETURN(es->message_receiver);
}

syx_bool
syx_plugin_initialize (void)
{
  static syx_bool _syx_gtk_initialized = FALSE;

  if (!_syx_gtk_initialized)
    {
      g_thread_init (NULL);
      gtk_init (NULL, NULL);
      _syx_gtk_initialized = TRUE;
    }  
}

void
syx_plugin_finalize (void)
{
}
