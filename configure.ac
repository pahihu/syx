dnl configure.ac
dnl

AC_PREREQ(2.52)

dnl version info
m4_define([syx_version], [0.1])
m4_define([syx_api_version], [0.1])
m4_define([glib_required_version], [2.6.0])
m4_define([gmodule_required_version], [2.6.0])

dnl init autoconf
AC_INIT([syx], [syx_version], [lethalman88@gmail.com])
AC_CONFIG_HEADERS([config.h])

dnl init automake
AM_INIT_AUTOMAKE

SYX_VERSION=syx_version
SYX_API_VERSION=syx_api_version
AC_SUBST(SYX_VERSION)
AC_SUBST(SYX_API_VERSION)

dnl check for basic programs
AC_PROG_CC_STDC
AC_PROG_INSTALL
AC_PROG_LIBTOOL

dnl check for standard header files
AC_HEADER_STDC
AC_CHECK_HEADERS([errno.h signal.h stddef.h string.h time.h \
		  unistd.h])
AC_CHECK_FUNCS(setjmp longjmp)

dnl portable runtime library
PKG_CHECK_MODULES(BASE_DEPENDENCIES,
	[glib-2.0 >= glib_required_version
	gmodule-2.0 >= gmodule_required_version])

CFLAGS="$CFLAGS -Wall -pedantic -g -O2"

AC_OUTPUT([
Makefile
syx.pc
syx/Makefile
tests/Makefile
plugins/Makefile
plugins/kernel/Makefile
])