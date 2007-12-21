INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)       \
	$(X11_DEP_CFLAGS)

plugin_LTLIBRARIES= libsyx-x11.la

libsyx_x11_la_SOURCES	= 	\
	plugin-init.c

libsyx_x11_la_LIBADD	= $(SYX_DEP_LIBS) $(X11_DEP_LIBS)

dist_stx11data_DATA = st/*.st