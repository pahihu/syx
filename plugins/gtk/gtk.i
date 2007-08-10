%module Gtk

%include glib.i
%include pango.i
%include gdk.i  

%{
#include <gtk/gtk.h>
%}

%define NOFS(t)
%typemap(in,firstself=0) t "SWIG_FIRST_SELF($1, $ltype, $input)"
%enddef

NOFS(GtkAdjustment *hadjustment);


%include gtk/gtkenums.h
%include gtk/gtkwidget.h
%include gtk/gtkcontainer.h
%include gtk/gtklabel.h
%include gtk/gtkbutton.h
%include gtk/gtkwindow.h
%include gtk/gtkbox.h
%include gtk/gtkhbox.h
%include gtk/gtkvbox.h
%include gtk/gtkadjustment.h
%include gtk/gtkscrolledwindow.h