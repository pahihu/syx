INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)

EXTRA_DIST = SConscript

lib_LTLIBRARIES= libsyx.la

libsyx_la_SOURCES	= 	\
	syx-bytecode.c syx-init.c syx-interp.c \
	syx-lexer.c syx-memory.c syx-object.c syx-parser.c \
	syx-primitives.c syx-scheduler.c syx-utils.c syx-error.c \
        syx-plugins.c syx-signal.c syx-profile.c

libsyx_la_LIBADD	= $(SYX_DEP_LIBS)

syxincludedir	= $(includedir)/syx
syxinclude_HEADERS	= 	\
	syx.h syx-interp.h syx-config.h syx-bytecode.h syx-enums.h syx-error.h \
        syx-lexer.h syx-memory.h syx-object.h syx-init.h \
        syx-parser.h syx-platform.h syx-scheduler.h syx-utils.h \
        syx-types.h syx-plugins.h syx-signal.h syx-profile.h
