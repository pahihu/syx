%{
#include <glib-object.h>
%}

%inline %{
void syx_gtk_callback (GObject *bla, SyxOop callback)
{
        SyxOop context;
        SyxOop process;
        context = syx_send_unary_message (syx_nil, callback, "invoke");
        process = syx_process_new (context);
        SYX_PROCESS_SUSPENDED(process) = syx_false;
}
%}

%include gobject/gtype.h
%include gobject/gclosure.h
%include gobject/gsignal.h
%include gobject/gobject.h