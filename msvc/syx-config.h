#ifndef _SYX_CONFIG_H
#define _SYX_CONFIG_H

#include <io.h>
#include <malloc.h>

#define HAVE_ERRNO_H 1
#define HAVE_STDARG_H 1

/* TODO: this is a hack: class is reserved word in C++ so we need to rename it
   when compiling with C++ compiler. The right fix is to not use 'class' as
   names in the code (e.g. use 'klass')) */
#define class my_class

#define open _open
#define read _read
#define write _write
#define close _close

#define trunc(x) (double)(int)(x)

#endif
