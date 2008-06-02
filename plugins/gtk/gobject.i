%{
#include <glib-object.h>
#include "syx-gobject.h"
%}

%ignore g_signal_init;
%ignore g_value_transforms_init;
%ignore g_param_spec_types_init;
%ignore g_type_init;
%ignore g_type_init_with_debug_flags;
%ignore g_value_c_init;
%ignore g_value_types_init;
%ignore g_enum_types_init;
%ignore g_param_type_init;
%ignore g_boxed_type_init;
%ignore g_object_type_init;

%include gobject/gtype.h
%include gobject/gclosure.h
%include gobject/gsignal.h
%include gobject/gobject.h