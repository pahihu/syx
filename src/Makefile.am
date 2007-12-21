INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)

EXTRA_DIST = SConscript syx.ico resources.rc

bin_PROGRAMS		= syx

syx_SOURCES		= main.c

syx_DEPENDENCIES	= $(top_builddir)/syx/libsyx.la
syx_LDADD		= $(top_builddir)/syx/libsyx.la	