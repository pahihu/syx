INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)       \
	$(X11_DEP_CFLAGS)

pluginx11dir = $(plugindir)/x11

pluginx11_LTLIBRARIES= libsyx-x11.la

libsyx_x11_la_SOURCES	= 	\
	plugin-init.c Xlib_wrap.c

libsyx_x11_la_LIBADD	= $(SYX_DEP_LIBS) $(X11_DEP_LIBS)

dist_stx11data_DATA = st/*.st