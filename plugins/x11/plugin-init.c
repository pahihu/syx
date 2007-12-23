/* 
   Copyright (c) 2007 Rahul, Luca Bruno

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


#include <syx/syx.h>
#include <X11/Xlib.h>
#include <unistd.h>

#include <plugins/x11/Xlib_wrap.c>

syx_bool
syx_plugin_initialize (void)
{
    static syx_bool _syx_x11_initialized = FALSE;
    syx_symbol *array_it;
    syx_string filename;
    static syx_symbol x11_filenames[] = {
      "Xlib.st",
      "Display.st",
      "XEvent.st",
      "Wm.st",
      NULL
    };
    static syx_symbol x11_initialize_request_classes[] = {
      "XlibGC",
      "XlibDisplay",
      "Display",
      "XlibXWindowAttributes",
      "XlibXButtonEvent",
      "XlibXKeyEvent",
      "XlibXMotionEvent",
      "XlibXEvent",
      "XEvent",
      "Wm",
      NULL
    };

    if (_syx_x11_initialized)
      return TRUE;
    
    for (array_it = x11_filenames; *array_it; array_it++) 
      {
        filename = syx_find_file ("st", "x11", *array_it);
        syx_cold_file_in (filename);
        syx_free (filename);
      }
    
    for (array_it = x11_initialize_request_classes; *array_it; array_it++)
      syx_object_initialize (syx_globals_at (*array_it));
    _syx_x11_initialized = TRUE;
    return TRUE;
}

void
syx_plugin_finalize (void)
{
}
