%module Gtk
%include glib.i
%include gdk.i

%{
#include <gtk/gtk.h>
%}

%include gtk/gtkenums.h
%include gtk/gtkwidget.h
%include gtk/gtkcontainer.h
%include gtk/gtklabel.h
%include gtk/gtkwindow.h