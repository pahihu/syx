EXTRA_DIST = SConscript add.st average.st do-me.st

DEPS = $(top_builddir)/syx/libsyx.la
LDADDS = $(top_builddir)/syx/libsyx.la

noinst_PROGRAMS = add average init do-me

average_LDFLAGS = -rdynamic

add_DEPENDENCIES = $(DEPS)
average_DEPENDENCIES = $(DEPS)
init_DEPENDENCIES = $(DEPS)
do_me_DEPENDENCIES = $(DEPS)

add_LDADD = $(LDADDS)
average_LDADD = $(LDADDS)
init_LDADD = $(LDADDS)
do_me_LDADD = $(LDADDS)

add_SOURCES = add.c
average_SOURCES = average.c
init_SOURCES = init.c
do_me_SOURCES = do-me.c