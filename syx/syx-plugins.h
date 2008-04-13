/* 
   Copyright (c) 2007-2008 Luca Bruno

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

#ifndef SYX_PLUGINS_H
#define SYX_PLUGINS_H

#include "syx-platform.h"
#include "syx-interp.h"

SYX_BEGIN_DECLS

typedef struct SyxPluginEntry SyxPluginEntry;

/*! A simple structure that contains informations about loaded plugins */
struct SyxPluginEntry
{
  /*! Name of the plugin */
  syx_string name;
  /*! Handle to the library */
  syx_pointer handle;
};

/* Dealing with dynamic libraries */

EXPORT extern syx_pointer syx_library_open (syx_symbol location);
EXPORT extern syx_pointer syx_library_symbol (syx_pointer handle, syx_symbol name);
EXPORT extern syx_bool syx_library_close (syx_pointer handle);

/* Managing plugins */

typedef syx_bool (* SyxPluginInitializeFunc) (void);
typedef void (* SyxPluginFinalizeFunc) (void);

EXPORT extern void syx_plugins_init (void);
EXPORT extern void syx_plugin_finalize_all (void);
EXPORT extern syx_pointer syx_plugin_load (syx_symbol name);
EXPORT extern syx_bool syx_plugin_unload (syx_symbol name);
EXPORT extern syx_pointer syx_plugin_symbol (syx_symbol plugin_name, syx_symbol func_name);
EXPORT extern syx_bool syx_plugin_call_interp (SyxInterpState *es, SyxOop method);
EXPORT extern syx_bool syx_plugin_call (SyxInterpState *es, syx_symbol plugin_name, syx_symbol func_name, SyxOop method);

SYX_END_DECLS

#endif /* SYX_PLUGINS_H */
