%{
#include <glib.h>
%}

typedef syx_bool gboolean;
typedef char gchar;
// force first self on gpointer
typedef GObject * gpointer;

%typemap(in) GCallback c_handler "$1 = syx_gtk_callback;";

%include typemaps.i

%include glib/gmacros.h
%include glibconfig.h
%include glib/gtypes.h
%include glib/gquark.h
%include glib/gunicode.h

%include gobject.i
