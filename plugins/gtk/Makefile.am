INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)       \
	$(GTK_DEP_CFLAGS)

CFLAGS+="-std=c99"

plugingtkdir = $(plugindir)/gtk

plugingtk_LTLIBRARIES= libsyx-gtk.la

libsyx_gtk_la_SOURCES	= 	\
	plugin-init.c gtk_wrap.c

libsyx_gtk_la_LIBADD	= $(SYX_DEP_LIBS) $(GTK_DEP_LIBS)

dist_stgtkdata_DATA = st/*.st