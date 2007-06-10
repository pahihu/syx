#ifndef SYX_INIT_H
#define SYX_INIT_H

#include "syx-types.h"
#include "syx-object.h"

#define SYX_INIT_MEMORY_SIZE 100000

void syx_init (syx_symbol root_path);
void syx_quit (void);
void syx_build_basic (void);
void syx_fetch_basic (void);

syx_bool syx_save_image (syx_symbol path);
syx_bool syx_load_image (syx_symbol path);

syx_string syx_find_file (syx_symbol domain, syx_symbol package, syx_symbol filename);
syx_symbol syx_get_root_path (void);
syx_bool syx_set_root_path (syx_symbol root_path);

#define syx_globals_at(name) (syx_dictionary_at_symbol (syx_globals, (syx_symbol)(name)))
#define syx_globals_at_put(symbol,value) (syx_dictionary_at_const_put (syx_globals, (symbol), (value)))

#endif
