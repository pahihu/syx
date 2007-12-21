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

#ifndef SYX_INIT_H
#define SYX_INIT_H

#include "syx-platform.h"
#include "syx-types.h"
#include "syx-object.h"

SYX_BEGIN_DECLS

/*! Default initial memory size */
#define SYX_INIT_MEMORY_SIZE 100000

EXPORT extern syx_bool syx_system_initialized;

EXPORT extern syx_bool syx_init (syx_varsize argc, syx_string *argv, syx_symbol root_path);
EXPORT extern void syx_quit (void);
EXPORT extern void syx_build_basic (void);
EXPORT extern void syx_fetch_basic (void);
EXPORT extern void syx_initialize_system (void);

EXPORT extern syx_string syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename);
EXPORT extern syx_symbol syx_get_root_path (void);
EXPORT extern syx_bool syx_set_root_path (syx_symbol root_path);
EXPORT extern syx_bool syx_set_image_path (syx_symbol image_path);
EXPORT extern syx_symbol syx_get_image_path (void);

/*! Looks up a symbol from the Smalltalk dictionary. Raises an error if not found */
#define syx_globals_at(name) (syx_dictionary_at_symbol (syx_globals, (syx_symbol)(name)))
/*! Looks up a symbol from the Smalltalk dictionary and return a given SyxOop if not found */
#define syx_globals_at_if_absent(name,object) (syx_dictionary_at_symbol_if_absent (syx_globals, \
                                                                                   (syx_symbol)(name), \
                                                                                   object))

/*! Insert a SyxOop into the Smalltalk dictionary */
#define syx_globals_at_put(symbol,value) (syx_dictionary_at_symbol_put (syx_globals, (symbol), (value)))

SYX_END_DECLS

#endif /* SYX_INIT_H */
