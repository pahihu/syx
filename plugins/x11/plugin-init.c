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
#include <stdio.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

SYX_FUNC_PRIMITIVE(Xlib_XOpenDisplay)
{
    SyxOop oop;
    syx_string string;
    SYX_PRIM_ARGS(1);
    oop = es->message_arguments[0];
    if (SYX_IS_NIL (oop))
        string = NULL;
    else
        string = SYX_OBJECT_STRING(oop);
    SYX_PRIM_RETURN(SYX_POINTER_CAST_OOP (XOpenDisplay(string)));
}

SYX_FUNC_PRIMITIVE(Xlib_DefaultRootWindow)
{
    Display *dpy;
    Window root;
    SYX_PRIM_ARGS(1);
    dpy = (Display*)es->message_arguments[0];
    root = DefaultRootWindow(dpy);
    SYX_PRIM_RETURN(syx_small_integer_new(root));
}

SYX_FUNC_PRIMITIVE(Xlib_XGrabKey)
{
    Display *dpy;
    Window root;
    syx_string key;
    SYX_PRIM_ARGS(3);
    dpy = (Display*)es->message_arguments[0];
    root = SYX_SMALL_INTEGER(es->message_arguments[1]);
    key = SYX_OBJECT_STRING(es->message_arguments[2]);
    XGrabKey(dpy, XKeysymToKeycode(dpy, XStringToKeysym(key)), Mod1Mask, root,
             True, GrabModeAsync, GrabModeAsync);
    SYX_PRIM_RETURN(syx_nil);
}

SYX_FUNC_PRIMITIVE(Xlib_XGrabButton)
{
    Display *dpy;
    Window root;
    syx_int32 mbutton;
    SYX_PRIM_ARGS(3);
    dpy = (Display *)es->message_arguments[0];
    root = SYX_SMALL_INTEGER(es->message_arguments[1]);
    mbutton = SYX_SMALL_INTEGER(es->message_arguments[2]);
    XGrabButton(dpy, mbutton, Mod1Mask, root, True, ButtonPressMask, GrabModeAsync,
                GrabModeAsync, None, None);
    SYX_PRIM_RETURN(syx_nil);
}

SYX_FUNC_PRIMITIVE(Xlib_XNextEvent)
{
    XEvent *ev;
    Display *dpy;
    SYX_PRIM_ARGS(1);
    dpy = (Display *)es->message_arguments[0];
    ev = syx_calloc(1, sizeof(XEvent));
    XNextEvent(dpy, ev);
    SYX_PRIM_RETURN(SYX_POINTER_CAST_OOP (ev));
}

SYX_FUNC_PRIMITIVE(Xlib_XCloseDisplay)
{
    SyxOop dpy;
    syx_int32 ret=0;
    SYX_PRIM_ARGS(1);
    dpy = es->message_arguments[0];
    if (!SYX_IS_NIL (dpy))
      ret = XCloseDisplay ((Display *)dpy);
    SYX_PRIM_RETURN(syx_small_integer_new (ret));
}

syx_bool
syx_plugin_initialize (void)
{
    static syx_bool _syx_x11_initialized = FALSE;
    syx_symbol *array_it;
    syx_string filename;
    static syx_symbol x11_filenames[] = {
      "XEvent.st", "XWindow.st", "XDisplay.st",
      NULL
    };
    static syx_symbol x11_initialize_request_classes[] = {
      "XDisplay", "XEvent",
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
