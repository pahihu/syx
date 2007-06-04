#ifndef SYX_TYPES_H
#define SYX_TYPES_H

#include <bits/wordsize.h>
#include "syx-enums.h"

/*! \page syx_types Syx Types
  
  \section numbers_and_constants Numbers and Constants
  
  The pointer to objects can also represent other kind of objects:
  
    - \b Pointers (00) have the two least bits set to 0, the other 30 bits is the pointer.
    - \b Small \b integers (10) have the least bit set to 1, the other 31 bits is the signed integer.
    - \b Characters (01) have the second least bit set to 1, and the least to 0, first 8 bits are the characters.
    - \b nil is 0
    - \b true is 1
    - \b false is 2
    
  This method allows us to avoid allocating unuseful memory. For instance, small integers, characters and constants don't have other \b data to hold.
  
  \b syx_object_get_class() will return the right class for these special objects.
*/

#if __WORDSIZE == 64
#define SYX_TYPE_POINTER_BITS ((syx_nint)3 << 62)
#define SYX_TYPE_SMALL_INTEGER_BITS ((syx_nint)1 << 63)
#define SYX_TYPE_CHARACTER_BITS ((syx_nint)1 << 62)
#else
#define SYX_TYPE_POINTER_BITS ((syx_nint)3 << 30)
#define SYX_TYPE_SMALL_INTEGER_BITS ((syx_nint)1 << 31)
#define SYX_TYPE_CHARACTER_BITS ((syx_nint)1 << 30)
#endif

#define SYX_POINTER(n) ((syx_pointer)(syx_nint)(n))
#define SYX_SMALL_INTEGER(ptr) ((syx_int32)(((syx_nint)ptr << 1) >> 1))
#define SYX_CHARACTER(ptr) ((syx_int8)(syx_nint)(ptr))

#define SYX_NIL ((syx_pointer) 0)
#define SYX_TRUE ((syx_pointer) 1)
#define SYX_FALSE ((syx_pointer) 2)

#define SYX_IS_NIL(ptr) ((ptr) == SYX_NIL)
#define SYX_IS_TRUE(ptr) ((ptr) == SYX_TRUE)
#define SYX_IS_FALSE(ptr) ((ptr) == SYX_FALSE)
#define SYX_IS_POINTER(ptr) ((syx_nint)(ptr) > 2 && ((syx_nint)(ptr) & SYX_TYPE_POINTER_BITS) == 0)
#define SYX_IS_BOOLEAN(ptr) (SYX_IS_TRUE(ptr) || SYX_IS_FALSE(ptr))
#define SYX_IS_SMALL_INTEGER(ptr) ((syx_nint)ptr & SYX_TYPE_SMALL_INTEGER_BITS)
#define SYX_IS_CHARACTER(ptr) (((syx_nint)ptr & SYX_TYPE_POINTER) == SYX_TYPE_CHARACTER_BITS)

#define syx_small_integer_new(n) ((syx_pointer)(((syx_nint)n) | SYX_TYPE_SMALL_INTEGER_BITS))
#define syx_character_new(n) ((syx_pointer)((((syx_nint)n) & ~SYX_TYPE_POINTER_BITS) | SYX_TYPE_CHARACTER_BITS))
#define syx_boolean_new(cond) ((cond) ? SYX_TRUE : SYX_FALSE)

#if !defined FALSE || !defined TRUE
#define FALSE 0
#define TRUE 1
#endif

typedef unsigned char syx_bool;

typedef char syx_char;
typedef unsigned char syx_uchar;

typedef char syx_int8;
typedef unsigned char syx_uint8;

typedef syx_char * syx_string;
typedef const syx_char * syx_symbol;

typedef short int syx_int16;
typedef unsigned short int syx_uint16;

typedef int syx_int32;
typedef unsigned int syx_uint32;

typedef long syx_nint;
typedef unsigned long syx_unint;

typedef long long int syx_int64;
typedef unsigned long long int syx_uint64;

typedef long syx_size;
typedef syx_int32 syx_varsize;

typedef void * syx_pointer;

#endif /* SYX_TYPES_H */
