#ifndef _SYX_CONFIG_H
#define _SYX_CONFIG_H

#include <io.h>
#include <malloc.h>

#define HAVE_ERRNO_H 1
#define HAVE_STDARG_H 1
#define HAVE__INLINE 1

#define open _open
#define read _read
#define write _write
#define close _close

#define trunc(x) (double)(int)(x)

#endif
