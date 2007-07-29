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

#include "syx-memory.h"
#include "syx-types.h"
#include "syx-platform.h"
#include "syx-plugins.h"
#include "syx-error.h"

#ifdef WITH_PLUGINS

#ifdef HAVE_LIBDL
  #include <dlfcn.h>
#endif

#ifdef HAVE_WINDOWS_H
  #include <windows.h>
  #include <winbase.h>
#endif

#endif /* WITH_PLUGINS */

static SyxPluginEntry *_syx_plugins = NULL;
static syx_int32 _syx_plugins_top = 0;

//! Load a dynamic library and return its handle
/*!
  \param location the location of the library
  \return A pointer to the handle or NULL
*/
syx_pointer
syx_library_open (syx_symbol location)
{
  syx_pointer ret = NULL;

#ifdef WITH_PLUGINS

  if (!location)
    return NULL;

#ifndef HAVE_LIBDL
  ret = LoadLibrary (SYX_IFDEF_UNICODE (location));
#else /* HAVE_LIBDL */
  ret = dlopen (location, RTLD_NOW);

#ifdef SYX_DEBUG_INFO
  if (!ret)
    puts (dlerror ());
#endif /* SYX_DEBUG_INFO */

#endif /* HAVE_LIBDL */

#endif /* WITH_PLUGINS */
  return ret;
}

//! Resolve a symbol in a library
/*!
  \param handle the handle returned by syx_library_open
  \param name the symbol name
  \return A pointer to the symbol or NULL
*/
syx_pointer
syx_library_symbol (syx_pointer handle, syx_symbol name)
{
  syx_pointer ret = NULL;

#ifdef WITH_PLUGINS

  if (!handle || !name)
    return NULL;

#ifndef HAVE_LIBDL
  ret = GetProcAddress (handle, SYX_IFDEF_UNICODE (name));
#else /* HAVE_LIBDL */
  ret = dlsym (handle, name);

#ifdef SYX_DEBUG_INFO
  if (!ret)
    puts (dlerror ());
#endif /* SYX_DEBUG_INFO */

#endif /* HAVE_LIBDL */

#endif /* WITH_PLUGINS */

  return ret;
}

//! Close a library handle
/*!
  \param handle the handle retruedn by syx_library_open
  \return FALSE if the handle exists but can't be closed
*/
syx_bool
syx_library_close (syx_pointer handle)
{
#ifdef WITH_PLUGINS
  
  if (!handle)
    return TRUE;

#ifndef HAVE_LIBDL
  FreeLibrary (handle);
  return TRUE;
#else
  if (dlclose (handle) == 0)
    return TRUE;
  else
    return FALSE;
#endif /* HAVE_LIBDL */

#endif /* WITH_PLUGINS */

  return TRUE;
}

//! Open a dynamic library and initialize the plugin
/*!
  \param name the name of the plugin
  \return A pointer to the plugin handle or NULL
*/
syx_pointer
syx_plugin_load (syx_symbol name)
{
  syx_pointer handle = NULL;

#ifdef WITH_PLUGINS
  syx_string location;
  syx_string namext;
  SyxPluginInitializeFunc func;
  SyxPluginEntry *entry;

  if (!name)
    return NULL;

  namext = syx_malloc (strlen (name) + 15);
  memset (namext, '\0', strlen (name) + 15);

  // use syx-name.dll instead of libsyx-name.dll on Windows
#ifndef WINDOWS
  strcpy (namext, "lib");
#endif

  strcat (namext, "syx-");
  strcat (namext, name);

#ifdef WINDOWS
  strcat (namext, ".dll");
#else
  strcat (namext, ".so");
#endif /* WINDOWS */

  location = syx_find_file ("plugins", name, namext);
  syx_free (namext);

#ifdef SYX_DEBUG_INFO
  syx_debug ("Loading plugin %s at %s\n", name, location);
#endif

  if (!location)
    return NULL;

  handle = syx_library_open (location);
  syx_free (location);
  if (!handle)
    return NULL;

  func = syx_library_symbol (handle, "syx_plugin_initialize");
  if (!func)
    return NULL;

  if (!func ())
    return NULL;

  _syx_plugins = syx_realloc (_syx_plugins, ++_syx_plugins_top * sizeof (SyxPluginEntry));
  entry = _syx_plugins + _syx_plugins_top - 1;
  entry->name = strdup (name);
  entry->handle = handle;

#endif /* WITH_PLUGINS */

  return handle;
}



//! Close the library handle and finalize the plugin
/*!
  This function finalize the plugin but it's not sure it closes the library handler.

  \param handler the plugin handler
  \return FALSE if the handler exists but can't be closed
*/
syx_bool
syx_plugin_unload (syx_symbol plugin)
{
#ifdef WITH_PLUGINS
  SyxPluginEntry *entry;
  SyxPluginFinalizeFunc func;
  syx_bool ret;

  if (!plugin)
    return TRUE;

#ifdef SYX_DEBUG_INFO
  syx_debug ("Unloading plugin %s\n", plugin);
#endif

  for (entry=_syx_plugins; entry < _syx_plugins + _syx_plugins_top; entry++)
    {
      if (!strcmp (entry->name, plugin))
	{
	  func = syx_library_symbol (entry->handle, "syx_plugin_finalize");
	  if (!func)
	    return FALSE;

	  func ();

	  ret = syx_library_close (entry->handle);
	  syx_free (entry->name);
	  entry->name = entry->handle = NULL;

	  return ret;
	}
    }

#endif /* WITH_PLUGINS */

  return TRUE;
}

//! Finalize all plugins
/*!
  This function is usually called internally and user programs don't need to call this manually.
*/
void
syx_plugin_finalize (void)
{
#ifdef WITH_PLUGINS
  SyxPluginEntry *entry;
  SyxPluginFinalizeFunc func;

  for (entry=_syx_plugins; entry < _syx_plugins + _syx_plugins_top; entry++)
    {
      func = syx_library_symbol (entry->handle, "syx_plugin_finalize");
      if (!func)
	return;

      func ();

      syx_library_close (entry->handle);
      syx_free (entry->name);
    }

  syx_free (_syx_plugins);
  _syx_plugins_top = 0;

#endif /* WITH_PLUGINS */

}

//! Calls a function of a plugin from within the interpreter
/*!
  If the plugin is not loaded yet, then load the plugin and call the requested primitive.

  \param plugin the name of the plugin
  \param func the name of the function
  \param es the execution state
  \param method method to call if the primitive fails
  \return FALSE to yield the process
*/
syx_bool
syx_plugin_call (SyxExecState *es, SyxOop method)
{
#ifdef WITH_PLUGINS
  SyxPluginEntry *entry;
  SyxPrimitiveFunc fp;
  SyxOop *literals;
  syx_symbol plugin;
  syx_symbol func;
  syx_pointer handle;

  literals = SYX_OBJECT_DATA(SYX_CODE_LITERALS(method));
  plugin = SYX_OBJECT_SYMBOL(literals[1]);
  func = SYX_OBJECT_SYMBOL(literals[0]);
  for (entry=_syx_plugins; entry < _syx_plugins + _syx_plugins_top; entry++)
    {
      if (!strcmp (entry->name, plugin))
	{
	  fp = syx_library_symbol (entry->handle, func);
	  if (!fp)
	    {
	      SYX_PRIM_FAIL;
	    }

	  return fp (es, method);
	}
    }

  // try loading the plugin if not loaded yet
  handle = syx_plugin_load (plugin);
  if (!handle)
    {
      SYX_PRIM_FAIL;
    }

  // call the primitive now
  fp = syx_library_symbol (handle, func);
  if (!fp)
    {
      SYX_PRIM_FAIL;
    }

  return fp (es, method);

#endif /* WITH_PLUGINS */

  SYX_PRIM_FAIL;
}
