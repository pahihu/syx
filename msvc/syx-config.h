#ifndef _SYX_CONFIG_H
#define _SYX_CONFIG_H

#include <io.h>
#include <malloc.h>

#define HAVE_ERRNO_H 1
#define HAVE_STDARG_H 1
#define HAVE__INLINE 1
#define HAVE_WINDOWS_H 1
#define HAVE_INT64_T

#define open _open
#define read _read
#define write _write
#define close _close

/* TODO: not sure what trunc() does, this might be wrong */
#define trunc(x) (double)(int)(x)

#endif
