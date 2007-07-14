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

#ifndef SYX_TYPES_H
#define SYX_TYPES_H

#include "syx-enums.h"

#include <limits.h>
#include <stdint.h>

/*! \page syx_types Syx Types
  Contains various C data types definition, including SyxOop
*/

#define SYX_IS_POINTER(oop) ((oop) && ((oop) & 3) == SYX_TYPE_POINTER)
#define SYX_IS_SMALL_INTEGER(oop) (((oop) & 1) == SYX_TYPE_SMALL_INTEGER)
#define SYX_IS_CHARACTER(oop) (((oop) & 3) == SYX_TYPE_CHARACTER)

#define SYX_OOP_EQ(oop1, oop2) ((oop1) == (oop2))
#define SYX_OOP_NE(oop1, oop2) ((oop1) != (oop2))

//! Cast a SyxOop to a native pointer type
#define SYX_OOP_CAST_POINTER(oop) ((syx_pointer) (oop))
//! Cast a pointer to a SyxOop
#define SYX_POINTER_CAST_OOP(ptr) ((SyxOop) (ptr))

//! TRUE if the number can be embedded
#define SYX_SMALL_INTEGER_CAN_EMBED(num) ((syx_int32)(num) >= (-1 << 30) && (syx_int32)(num) < (1 << 30))
//! TRUE if an overflow occurs when doing the sum of a and b
#define SYX_SMALL_INTEGER_SUM_OVERFLOW(a,b) (((a ^ b) | (((a ^ (~(a ^ b) & (1 << (sizeof(syx_int32) * CHAR_BIT - 1)))) + b) ^ b)) >= 0)
//! TRUE if an overflow occurs when doing the difference between a and b
#define SYX_SMALL_INTEGER_DIFF_OVERFLOW(a,b) (((a ^ b) & (((a ^ ((a ^ b) & (1 << (sizeof(syx_int32) * CHAR_BIT - 1)))) - b) ^ b)) < 0)
//! Force the embedding of an integer
#define SYX_SMALL_INTEGER_EMBED(num) ((syx_int32)(num) & ~(3 << 30))

#if !defined FALSE || !defined TRUE
#define FALSE 0
#define TRUE 1
#endif

typedef unsigned char syx_bool;

typedef char syx_char;
typedef unsigned char syx_uchar;

typedef int8_t syx_int8;
typedef uint8_t syx_uint8;

typedef syx_char * syx_string;
typedef const syx_char * syx_symbol;

typedef int16_t syx_int16;
typedef uint16_t syx_uint16;

typedef int32_t syx_int32;
typedef uint32_t syx_uint32;

typedef long syx_nint;
typedef unsigned long syx_unint;

#ifdef HAVE_INT64_T
typedef int64_t syx_int64;
typedef uint64_t syx_uint64;
#endif

typedef long syx_size;
typedef syx_int32 syx_varsize;

typedef double syx_double;

typedef void * syx_pointer;

typedef syx_nint SyxOop;


//! Basic instance types
//! Evaluate syx_true or syx_false depending on the given condition
#define syx_boolean_new(cond) ((cond) ? syx_true : syx_false)
#define syx_small_integer_new(num) (((SyxOop)(num) << 1) + SYX_TYPE_SMALL_INTEGER)
#define syx_character_new(ch) (((SyxOop)(ch) << 2) + SYX_TYPE_CHARACTER)

//! Basic conversions
#define SYX_SMALL_INTEGER(oop) ((syx_int32)(oop) >> 1)
#define SYX_CHARACTER(oop) ((syx_uchar)((syx_nint)(oop) >> 2))

//! TRUE if an overflow occurs when doing b times a
inline syx_bool SYX_SMALL_INTEGER_MUL_OVERFLOW (syx_int32 a, syx_int32 b);
//! TRUE if an overflow occurs when shifting a on the left by b
inline syx_bool SYX_SMALL_INTEGER_SHIFT_OVERFLOW (syx_int32 a, syx_int32 b);

#endif /* SYX_TYPES_H */
