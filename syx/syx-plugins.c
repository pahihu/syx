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
#include "syx-parser.h"
#include "syx-lexer.h"
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

static SyxPluginEntry *_syx_plugins = NULL;
static syx_int32 _syx_plugins_top = 0;

static SyxOop _syx_default_method = 0;

#endif /* WITH_PLUGINS */

//! Initialize the plugin system
/*!
  This function is called internally, usually applications don't need to use this function directly.
*/
void
syx_plugins_init (void)
{
#ifdef WITH_PLUGINS
  static syx_bool initialized = FALSE;

  if (initialized)
    return;

  SyxParser *parser;
  SyxLexer *lexer;

  _syx_default_method = syx_method_new ();
  lexer = syx_lexer_new ("defaultPluginsFailMethod self primitiveFailed");
  parser = syx_parser_new (lexer, _syx_default_method, syx_nil);
  syx_parser_parse (parser);

  syx_lexer_free (lexer, FALSE);
  syx_parser_free (parser, FALSE);
#endif
}

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

  if (name)
    {
      namext = syx_calloc (strlen (name) + 15, sizeof (syx_char));
      
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
      
      location = (syx_string) syx_calloc (strlen (SYX_PLUGIN_PATH)
					  + strlen (name)
					  + strlen (namext) + 3, sizeof (syx_char));
      sprintf (location, "%s%c%s%c%s",
	       SYX_PLUGIN_PATH, SYX_PATH_SEPARATOR,
	       name, SYX_PATH_SEPARATOR,
	       namext);
      syx_free (namext);
      
#ifdef SYX_DEBUG_INFO
      syx_debug ("Loading plugin %s at %s\n", name, location);
#endif

      handle = syx_library_open (location);
      syx_free (location);
    }
  else
    handle = syx_library_open (NULL);

  if (!handle)
    return NULL;

  if (name)
    {
      func = syx_library_symbol (handle, "syx_plugin_initialize");
      if (!func)
	return NULL;
      
      if (!func ())
	return NULL;
    }

  _syx_plugins = syx_realloc (_syx_plugins, ++_syx_plugins_top * sizeof (SyxPluginEntry));
  entry = _syx_plugins + _syx_plugins_top - 1;
  entry->name = (name ? strdup (name) : NULL);
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
syx_plugin_finalize_all (void)
{
#ifdef WITH_PLUGINS
  SyxPluginEntry *entry;
  SyxPluginFinalizeFunc func;

  for (entry=_syx_plugins; entry < _syx_plugins + _syx_plugins_top; entry++)
    {
      if (!entry->name)
	continue;

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

//! Lookup a symbol of the given plugin
/*!
  If the plugin is not loaded yet, then load the plugin.

  \return the pointer to the looked up symbol or NULL
*/
syx_pointer
syx_plugin_symbol (syx_symbol plugin_name, syx_symbol symbol_name)
{
#ifdef WITH_PLUGINS

  SyxPluginEntry *entry;
  syx_pointer handle;

  for (entry=_syx_plugins; entry < _syx_plugins + _syx_plugins_top; entry++)
    {
      if ((!plugin_name && entry->name) || (plugin_name && !entry->name))
	continue;

      if (plugin_name && entry->name && strcmp (plugin_name, entry->name))
	continue;

      return syx_library_symbol (entry->handle, symbol_name);
    }

  // try loading the plugin if not loaded yet
  handle = syx_plugin_load (plugin_name);
  if (!handle)
    return NULL;

  // finally lookup the symbol again
  return syx_library_symbol (handle, symbol_name);

#endif /* WITH_PLUGINS */

  return NULL;
}

//! Calls a function of a plugin from within the interpreter
/*!
  If the plugin is not loaded yet, then load the plugin and call the requested primitive.

  \param es the execution state
  \param method method in which the primitive call has been requested
  \return FALSE to yield the process
*/
syx_bool
syx_plugin_call_interp (SyxExecState *es, SyxOop method)
{
#ifdef WITH_PLUGINS
  SyxOop *literals;
  SyxOop plugin_oop;
  syx_symbol plugin = NULL;
  syx_symbol func;

  literals = SYX_OBJECT_DATA(SYX_CODE_LITERALS(method));
  plugin_oop = literals[1];
  // if plugin is NULL, the function is looked up in the main program
  if (!SYX_IS_NIL (plugin_oop))
    plugin = SYX_OBJECT_SYMBOL(plugin_oop);
  func = SYX_OBJECT_SYMBOL(literals[0]);

  return syx_plugin_call (es, plugin, func, method);

#endif /* WITH_PLUGINS */

  SYX_PRIM_FAIL;
}

//! Calls a function of a plugin from within the interpreter
/*!
  If the plugin is not loaded yet, then load the plugin and call the requested primitive.

  \param es the execution state
  \param plugin_name the name of the plugin
  \param func_name the name of the function to be called
  \param method method to execute if the primitive fails or syx_nil
  \return FALSE to yield the process
*/
syx_bool
syx_plugin_call (SyxExecState *es, syx_symbol plugin_name, syx_symbol func_name, SyxOop method)
{
#ifdef WITH_PLUGINS
  SyxPrimitiveFunc fp;

  if (SYX_IS_NIL (method))
    method = _syx_default_method;

  fp = syx_plugin_symbol (plugin_name, func_name);
  if (fp)
    return fp (es, method);
#endif /* WITH_PLUGINS */

  SYX_PRIM_FAIL;
}
