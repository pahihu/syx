INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(BASE_DEPENDENCIES_CFLAGS)

lib_LTLIBRARIES= libsyx-kernel-0.1.la

libsyx_kernel_0_1_la_SOURCES	= 	\
	plugin-init.c			\
	plugin-basic.c

libsyx_kernel_0_1_la_LIBADD	= $(BASE_DEPENDENCIES_LIBS)

EXTRA_DIST = kernel.la