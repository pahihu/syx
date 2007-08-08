#ifndef _STDINT_MSVC_EMU_H
#define _STDINT_MSVC_EMU_H

#ifndef _MSC_VER
#error "This should only be used when compiling with Visual Studio compiler"
#endif

typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned int uint32_t;

#endif
