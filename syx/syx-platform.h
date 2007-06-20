#ifndef SYX_PLATFORM_H
#define SYX_PLATFORM_H

/* Some platform specific informations */

#ifdef WINDOWS

 #define SYX_PATH_SEPARATOR '\\'

 #ifdef BUILD_DLL

 // the dll exports
  #define _SYX_EXPORT __declspec(dllexport)

 #else

 // the exe imports
  #define _SYX_EXPORT __declspec(dllimport)

 #endif /* BUILD_DLL */

#else

 #define SYX_PATH_SEPARATOR '/'

 #define _SYX_EXPORT

#endif /* WINDOWS */

#endif /* SYX_PLATFORM_H */
