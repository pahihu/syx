/* 
   Copyright (c) 2007 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

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
  syx_pointer w = SYX_OOP_CAST_POINTER(SYX_OBJECT_VARS(es->message_receiver)[0]);
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
