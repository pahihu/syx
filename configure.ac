dnl configure.ac
dnl
dnl syx - Smalltalk YX programming language
dnl

dnl version info
m4_define([syx_version], [0.1.5])

dnl init autoconf
AC_INIT([syx], [syx_version], [lethalman88@gmail.com])

dnl set $target
AC_CANONICAL_TARGET

dnl init automake
AM_INIT_AUTOMAKE([syx], [syx_version()])
AM_INIT_AUTOMAKE([AC_PACKAGE_TARNAME()], [AC_PACKAGE_VERSION()])
AM_CONFIG_HEADER(syx/syx-config.h)

dnl with args
AC_ARG_WITH(gmp, [  --without-gmp           do not support big numbers])
AC_ARG_ENABLE(plugins, [  --disable-plugins       do not support plugins],:, enable_plugins=yes)
AC_ARG_ENABLE(profile, [  --enable-profile        compile and link with -pg],:, disable_profile=yes)
AC_ARG_ENABLE(iprofile, [  --enable-iprofile        enable internal profiling],:, disable_iprofile=yes)

dnl check for basic programs
AC_PROG_CC
AC_PROG_CC_STDC
AC_PROG_INSTALL
AC_PROG_LIBTOOL

CFLAGS="$CFLAGS -ansi -pedantic -Wall -Wno-strict-aliasing -DROOT_PATH=\"$datadir/syx\" -DIMAGE_PATH=\"$datadir/syx/default.sim\" -DPLUGIN_PATH=\"$libdir/syx\""

dnl check for standard header files
AC_HEADER_STDC

AC_CHECK_HEADERS([string.h sys/stat.h time.h stdio.h assert.h fcntl.h],,
		AC_MSG_ERROR(cannot build Syx without $ac_header header))
AC_CHECK_HEADERS([stdarg.h byteswap.h errno.h unistd.h stdint.h sys/time.h])

AC_CHECK_FUNCS([strtol strtod],,
	      AC_MSG_ERROR(cannot build Syx without $ac_func function))
AC_CHECK_FUNCS([fstat access getenv perror signal select])

AC_CHECK_TYPES(int64_t)

dnl check C Compiler characteristics
AC_C_INLINE
if test "$ac_cv_c_inline" != no; then
   AC_DEFINE(HAVE_INLINE, 1, [Define to 1 if you have 'inline'.])
fi
AC_C_BIGENDIAN

dnl target specific

native_win32=no 

case "$target" in 
*-darwin*) 
        CFLAGS="$CFLAGS -no-cpp-precomp -fno-common"
        ;;
*-wince*)
	native_win32=yes
	CFLAGS="$CFLAGS -DWINCE"
	;;
*-*-mingw*)
        native_win32=yes
        ;;
esac

dnl windows specific
if test "$native_win32" == yes; then
   CFLAGS="$CFLAGS -DWINDOWS -D_DLL"
   LIBS="$LIBS -lwsock32"
   AC_CHECK_HEADERS([windows.h])
fi

dnl check for profiling
if test "$enable_profile" == yes; then
   CFLAGS="$CFLAGS -pg"
   LIBS="$LIBS -pg"
fi

dnl check for internal profiling
if test "$enable_iprofile" == yes; then
   CFLAGS="$CFLAGS -DSYX_PROFILE"
fi

dnl check for math library
AC_CHECK_LIB(m, floor, [LIBS="$LIBS -lm"])

dnl check for gmp library
if test "$with_gmp" != no; then
   AC_CACHE_CHECK(for mpz_init in -lgmp, syx_cv_gmp_libs, [
     syx_cv_gmp_libs="-lgmp"
     ac_save_LIBS="$LIBS"
     LIBS="$LIBS $syx_cv_gmp_libs"

     AC_LINK_IFELSE([AC_LANG_PROGRAM([[
	    #include <stdio.h>
	    #include <gmp.h>
	]], [[
	    mpz_t z;
	    mpz_init (z);
     	]])],, [syx_cv_gmp_libs="not found"])
     LIBS="$ac_save_LIBS"
   ])

   if test "$syx_cv_gmp_libs" != "not found"; then
      LIBS="$LIBS $syx_cv_gmp_libs"
      AC_DEFINE(HAVE_LIBGMP, 1, [Define to 1 if you have the 'gmp' library (-lgmp).])
   fi
fi

dnl check for plugins
if test "$enable_plugins" != no; then
   AC_CHECK_LIB(dl, dlopen, [
   		    AC_DEFINE(HAVE_LIBDL, 1, [Define to 1 if you have the 'ltdl' library (-ldl).])
		    LIBS="$LIBS -ldl"])
fi

dnl set syx/st/kernel dir
stkerneldatadir="$datadir/syx/st/kernel"
AC_SUBST(stkerneldatadir)

dnl stuff to go in the syx-config.h file
AH_TOP(
[#ifndef SYX_CONFIG_H
#define SYX_CONFIG_H])
AH_BOTTOM(
[#endif /* SYX_CONFIG_H */])

AC_OUTPUT([
Makefile
syx/Makefile
src/Makefile
])