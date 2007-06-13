#ifndef SYX_TYPES_H
#define SYX_TYPES_H

#include <stdio.h>
#include "syx-enums.h"

/*! \page syx_types Syx Types
  Contains various C data types definition, including SyxOop
*/

#define GError void *
#define g_error printf

#define SYX_OOP_EQ(oop1, oop2) (oop1.idx == oop2.idx)
#define SYX_OOP_NE(oop1, oop2) (oop1.idx != oop2.idx)

//! Cast the index of a SyxOop to a native pointer type
#define SYX_OOP_CAST_POINTER(oop) ((syx_pointer)(syx_nint)oop.idx)

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

typedef union SyxOop SyxOop;
union SyxOop
{
  struct
  {
    syx_int32 value : 30;
    SyxType type : 2;
  } c;

  struct
  {
    syx_int32 value : 31;
    syx_bool type : 1;
  } i;

  syx_int32 idx;
};

#endif /* SYX_TYPES_H */
