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

#ifndef SYX_PLATFORM_H
#define SYX_PLATFORM_H

#include "syx-config.h"

#define _SYX_XSTRINGIFY(s) #s
#define SYX_STRINGIFY(s) _SYX_XSTRINGIFY(s)

#define SYX_IMAGE_PATH SYX_STRINGIFY(IMAGE_PATH)
#define SYX_ROOT_PATH SYX_STRINGIFY(ROOT_PATH)

/* Version */

#define SYX_VERSION "0.1.4"

/* Inline */

#undef INLINE
#if defined (HAVE_INLINE) && defined (__GNUC__)
#  define INLINE static __inline__
#elif !defined (HAVE_INLINE)
#  if defined (HAVE__INLINE__)
#    define INLINE static __inline__
#  elif defined (HAVE__INLINE)
#    define INLINE static __inline
#  else
#    define INLINE static
#  endif
#endif

/* Byte swapping */

#ifdef HAVE_BYTESWAP_H
#include <byteswap.h>
#define syx_bswap_16(x) bswap_16(x)
#define syx_bswap_32(x) bswap_32(x)
#else
#define syx_bswap_16(x)					     \
  ((((x) & 0xff00) >> 8) | (((x) & 0x00ff) << 8))
#define syx_bswap_32(x)					     \
  ((((x) & 0xff000000) >> 24) | (((x) & 0x00ff0000) >> 8) |  \
   (((x) & 0x0000ff00) << 8) | (((x) & 0x000000ff) << 24))
#endif /* HAVE_BYTESWAP_H */

/* Swap for big endian machines */

#ifdef HAVE_BIG_ENDIANNESS

//! Swap 16-bit on big endian machines. No operation is done on little endian machines
#define SYX_COMPAT_SWAP_16(x) syx_bswap_16(x)

//! Swap 16-bit on big endian machines. No operation is done on little endian machines
#define SYX_COMPAT_SWAP_32(x) syx_bswap_32(x)

#else /* HAVE_BIG_ENDIANNESS */

//! Swap 16-bit on big endian machines. No operation is done on little endian machines
#define SYX_COMPAT_SWAP_16(x) (x)

//! Swap 16-bit on big endian machines. No operation is done on little endian machines
#define SYX_COMPAT_SWAP_32(x) (x)

#endif /* HAVE_BIT_ENDIANNESS */

/* Some platform specific informations */

#ifndef HAVE_ERRNO_H
EXPORT extern int errno;
#  define ERANGE -32
#endif

#ifdef WINDOWS
#  define SYX_PATH_SEPARATOR '\\'
#  ifdef _DLL
#    define EXPORT __declspec(dllexport)
#  else
#    define EXPORT __declspec(dllimport)
#  endif /* _DLL */
#else /* WINDOWS */
#  define SYX_PATH_SEPARATOR '/'
#  define EXPORT
#endif /* WINDOWS */


#endif /* SYX_PLATFORM_H */
