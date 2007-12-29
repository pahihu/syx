INCLUDES		=	\
	-I$(top_srcdir) 	\
	$(SYX_DEP_CFLAGS)       \
	$(WINGUI_DEP_CFLAGS)

pluginwinguidir = $(plugindir)/wingui

pluginwingui_LTLIBRARIES= libsyx-wingui.la

libsyx_wingui_la_SOURCES	= 	\
	plugin-init.c

libsyx_wingui_la_LIBADD	= $(SYX_DEP_LIBS) $(WINGUI_DEP_LIBS)

EXTRA_DIST = SConscript