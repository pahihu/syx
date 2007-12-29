dnl configure.ac
dnl
dnl syx - Smalltalk YX programming language
dnl

dnl version info
m4_define([syx_version], [0.1.5])

dnl init autoconf
AC_INIT([syx], [syx_version], [lethalman88@gmail.com])
AC_PREREQ([2.59])

dnl set $target
AC_CANONICAL_TARGET

dnl init automake
AM_INIT_AUTOMAKE([syx], [syx_version()])
AM_CONFIG_HEADER(syx/syx-config.h)

CFLAGS="$(CFLAGS) -Wall -Wno-strict-aliasing -DROOT_PATH=$datadir/syx -DIMAGE_PATH=$datadir/syx/default.sim -DPLUGIN_PATH=$libdir/syx"

dnl check for basic programs
AC_PROG_CC
AC_PROG_CC_STDC
AC_PROG_INSTALL
AC_PROG_LIBTOOL
PKG_PROG_PKG_CONFIG

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
        target_wince=yes
        CFLAGS="$CFLAGS -DWINCE"
        ;;
*-*-mingw*)
        native_win32=yes
        ;;
esac

dnl default final output
build_gmp="no"
build_plugins="no"
build_gtk="no"
build_x11="no"
build_readline="no"
build_wingui="no"

dnl debug level
AC_MSG_CHECKING([the build debug level])
AC_ARG_ENABLE(debug,
        AC_HELP_STRING([--enable-debug],
                       [debug level (no, normal, info, full) [default=normal]]),
                       [],[enable_debug="normal"])
AC_MSG_RESULT([$enable_debug])

dnl gmp support
AC_MSG_CHECKING([whether to build with big numbers support])
AC_ARG_WITH(gmp,
        AC_HELP_STRING([--without-gmp],
                       [do not support big numbers [default=yes]]),
                       [],[with_gmp="yes"])
AC_MSG_RESULT([$with_gmp])

dnl plugins support
AC_MSG_CHECKING([whether to build with plugins support])
AC_ARG_WITH(plugins,
        AC_HELP_STRING([--without-plugins],
                       [do not support plugins [default=yes]]),
                       [],[with_plugins="yes"])
AC_MSG_RESULT([$with_plugins])

dnl gprof profiling
AC_MSG_CHECKING([whether to compile and link with -pg])
AC_ARG_ENABLE(profile,
        AC_HELP_STRING([--enable-profile],
                       [compile and link with -pg [default=no]]),
                       [enable_profile="yes"],[enable_profile="no"])
AC_MSG_RESULT([$enable_profile])

dnl internal profiling
AC_MSG_CHECKING([whether to enable internal profiling])
AC_ARG_ENABLE(iprofile,
        AC_HELP_STRING([--enable-iprofile],
                       [enable internal profiling [default=no]]),
                       [enable_iprofile="yes"],[enable_iprofile="no"])
AC_MSG_RESULT([$enable_iprofile])

dnl gtk
AC_MSG_CHECKING([whether to build the GTK+ plugin])
AC_ARG_ENABLE(gtk,
        AC_HELP_STRING([--disable-gtk],
                       [enable build the GTK+ plugin [default=yes]]),
                       [],[enable_gtk="yes"])
AC_MSG_RESULT([$enable_gtk])

dnl x11
AC_MSG_CHECKING([whether to build the X11 plugin])
AC_ARG_ENABLE(x11,
        AC_HELP_STRING([--disable-x11],
                       [enable build the X11 plugin [default=yes]]),
                       [],[enable_x11="yes"])
AC_MSG_RESULT([$enable_x11])

dnl readline
AC_MSG_CHECKING([whether to build the Readline plugin])
AC_ARG_ENABLE(readline,
        AC_HELP_STRING([--disable-readline],
                       [enable build the Readline plugin [default=yes]]),
                       [],[enable_readline="yes"])
AC_MSG_RESULT([$enable_readline])

dnl wingui
AC_MSG_CHECKING([whether to build the WinGui plugin])
AC_ARG_ENABLE(wingui,
        AC_HELP_STRING([--enable-wingui],
                       [enable build the WinGui plugin]),
                       [],[enable_wingui=$native_win32])
AC_MSG_RESULT([$enable_wingui])

dnl check for debug level
case "$enable_debug" in
no)
   CFLAGS="$CFLAGS -O3"
   ;;
normal)
   CFLAGS="$CFLAGS -g -O2"
   ;;
info)
   CFLAGS="$CFLAGS -g -O -DSYX_DEBUG_INFO"
   ;;
full)
   CFLAGS="$CFLAGS -g -O -DSYX_DEBUG_INFO -DSYX_DEBUG_FULL"
   ;;
esac

dnl win32 specific
if test "$native_win32" == yes; then
   SYX_OTHER_CFLAGS="$SYX_OTHER_CFLAGS -DWINDOWS -D_DLL"
   SYX_OTHER_LIBS="$SYX_OTHER_LIBS -lwsock32"
fi

dnl check for profile
if test "$enable_profile" == yes; then
   SYX_OTHER_CFLAGS="$SYX_OTHER_CFLAGS -pg"
   SYX_OTHER_LIBS="$SYX_OTHER_LIBS -pg"
fi

dnl check for internal profiling
if test "$enable_iprofile" == yes; then
   CFLAGS="$CFLAGS -DSYX_PROFILE"
fi

dnl check for math library
AC_CHECK_LIB(m, floor, [SYX_OTHER_LIBS="$SYX_OTHER_LIBS -lm"])

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
      SYX_OTHER_LIBS="$SYX_OTHER_LIBS $syx_cv_gmp_libs"
      AC_DEFINE(HAVE_LIBGMP, 1, [Define to 1 if you have the 'gmp' library (-lgmp).])
      build_gmp="yes"
   else
      build_gmp="no"
   fi
fi

dnl check for plugins
if test "$with_plugins" != no; then
   AC_CHECK_LIB(dl, dlopen, [
                AC_DEFINE(HAVE_LIBDL, 1, [Define to 1 if you have the 'ltdl' library (-ldl).])
                SYX_OTHER_LIBS="$SYX_OTHER_LIBS -ldl"
                build_plugins="yes"], [build_plugins="no"])
fi

AC_SUBST(SYX_OTHER_CFLAGS)
AC_SUBST(SYX_OTHER_LIBS)

dnl set syx/st/kernel dir
stkerneldatadir="$datadir/syx/st/kernel"
AC_SUBST(stkerneldatadir)

dnl set syx/st/foreign dir
stforeigndatadir="$datadir/syx/st/foreign"
AC_SUBST(stforeigndatadir)

dnl stuff to go in the syx-config.h file
AH_TOP(
[#ifndef SYX_CONFIG_H
#define SYX_CONFIG_H])
AH_BOTTOM(
[#endif /* SYX_CONFIG_H */])

AC_CONFIG_FILES([
Makefile
syx/Makefile
src/Makefile
share/Makefile
examples/Makefile
examples/basic/Makefile
examples/console/Makefile
examples/embedding/Makefile
examples/web/Makefile
examples/gtk/Makefile
examples/x11/Makefile
tests/Makefile
])

plugin_subdirs=

if test "$build_plugins" == yes; then

   dnl enable gtk
   if test "$enable_gtk" != no; then
      PKG_CHECK_MODULES([GTK_DEP],
                     [gthread-2.0 >= 2.14.0
                      gtk+-2.0 >= 2.14.0],
                     [build_gtk="yes"
                      plugin_subdirs="$plugin_subdirs plugins/gtk"
                      AC_CONFIG_FILES([plugins/gtk/Makefile])
                      stgtkdatadir="$datadir/syx/st/gtk"
                      AC_SUBST(stgtkdatadir)])
   fi

   dnl enable readline
   if test "$enable_readline" != no; then
      AC_CHECK_LIB([readline], [add_history],
                [build_readline="yes"
                 READLINE_DEP_LIBS="-lreadline"
                 AC_SUBST([READLINE_DEP_LIBS])
                 plugin_subdirs="$plugin_subdirs plugins/readline"
                 AC_CONFIG_FILES([plugins/readline/Makefile])
                 streadlinedatadir="$datadir/syx/st/readline"
                 AC_SUBST(streadlinedatadir)])
   fi

   dnl enable x11
   if test "$enable_x11" != no; then
      PKG_CHECK_MODULES([X11_DEP],
                     [x11 >= 1.1.2],
                     [build_x11="yes"
                      plugin_subdirs="$plugin_subdirs plugins/x11"
                      AC_CONFIG_FILES([plugins/x11/Makefile])
                      stx11datadir="$datadir/syx/st/x11"
                      AC_SUBST(stx11datadir)])
   fi

   dnl enable wingui
   if test "$enable_wingui" != no; then
      if test "$target_wince" == yes; then
            AC_CHECK_LIB([commctrl], [MessageBox],
                [build_wingui="yes"
                 WINGUI_DEP_LIBS="-lcommctrl"
                 AC_SUBST([WINGUI_DEP_LIBS])
                 plugin_subdirs="$plugin_subdirs plugins/wingui"
                 AC_CONFIG_FILES([plugins/wingui/Makefile])
                 stwinguidatadir="$datadir/syx/st/wingui"
                 AC_SUBST(stwinguidatadir)])
      else
         build_wingui="yes"
      fi
   fi
fi

AC_SUBST(plugin_subdirs)

plugindir="$libdir/syx"
AC_SUBST(plugindir)

AC_OUTPUT

echo "
Smalltalk YX was configured with the following options:

 Debug level              : $enable_debug
 Big numbers support      : $build_gmp
 Plugins support          : $build_plugins
"

if test "$build_plugins" == "yes"; then
echo "
The following plugins will be built:

 GTK+                     : $build_gtk
 Readline                 : $build_readline
 X11                      : $build_x11
 WinGui                   : $build_wingui

" 
fi