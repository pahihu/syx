#ifndef SYX_INIT_H
#define SYX_INIT_H

#include "syx-types.h"
#include "syx-object.h"

//! Default initial memory size
#define SYX_INIT_MEMORY_SIZE 10000

syx_bool syx_init (syx_symbol root_path);
void syx_quit (void);
void syx_build_basic (void);
void syx_fetch_basic (void);

syx_string syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename);
syx_symbol syx_get_root_path (void);
syx_bool syx_set_root_path (syx_symbol root_path);
syx_bool syx_set_image_path (syx_symbol image_path);
syx_symbol syx_get_image_path (void);

//! Looks up a symbol from the Smalltalk dictionary. Raises an error if not found
#define syx_globals_at(name) (syx_dictionary_at_symbol (syx_globals, (syx_symbol)(name)))
//! Looks up a symbol from the Smalltalk dictionary and return a given SyxOop if not found
#define syx_globals_at_if_absent(name,object) (syx_dictionary_at_symbol_if_absent (syx_globals,	\
										   (syx_symbol)(name), \
										   object))

//! Get a binding to a variable in the Smalltalk dictionary. Raises an error if not found
#define syx_globals_link_at(name) (syx_dictionary_link_at_symbol (syx_globals, (syx_symbol)(name)))

//! Insert a SyxOop into the Smalltalk dictionary
#define syx_globals_at_put(symbol,value) (syx_dictionary_at_const_put (syx_globals, (symbol), (value)))

#endif /* SYX_INIT_H */
