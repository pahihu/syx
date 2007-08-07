%module Gtk

%include glib.i
%include pango.i
%include gdk.i  

%{
#include <gtk/gtk.h>
%}

%include gtk/gtkenums.h
%include gtk/gtkwidget.h
%include gtk/gtkcontainer.h
%include gtk/gtklabel.h
%include gtk/gtkbutton.h
%include gtk/gtkwindow.h
%include gtk/gtkbox.h
%include gtk/gtkhbox.h
%include gtk/gtkvbox.h