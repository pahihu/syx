AM_CPPFLAGS = -DSYX_ROOT_DIR=\"$(pkgdatadir)\"

INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(BASE_DEPENDENCIES_CFLAGS)

lib_LTLIBRARIES= libsyx-0.1.la

libsyx_0_1_la_SOURCES	= 	\
	syx-object.c		\
	syx-init.c		\
	syx-lexer.c		\
	syx-bytecode.c 		\
	syx-parser.c		\
	syx-utils.c		\
	syx-scheduler.c		\
	syx-memory.c		\
	syx-primitives.c	\
	syx-interp.c		\
	syx-gc.c		\
	syx-plugins.c

libsyx_0_1_la_LIBADD	= $(BASE_DEPENDENCIES_LIBS) $(LIBJIT_LIBS)

syxincludedir	= $(includedir)/syx-$(SYX_API_VERSION)/syx
syxinclude_HEADERS	= 	\
	syx.h	 		\
	syx-enums.h		\
	syx-init.h		\
	syx-object.h		\
	syx-lexer.h		\
	syx-bytecode.h		\
	syx-parser.h		\
	syx-utils.h		\
	syx-scheduler.h		\
	syx-memory.h		\
	syx-interp.h		\
	syx-gc.h		\
	syx-plugins.h

bin_PROGRAMS		= syx

syx_SOURCES		=	\
	main.c

syx_DEPENDENCIES	= $(top_builddir)/syx/libsyx-$(SYX_API_VERSION).la
syx_LDADD		= $(top_builddir)/syx/libsyx-$(SYX_API_VERSION).la