EXTRA_DIST = SConscript browser.st coldbrowser.st

DEPS = $(top_builddir)/syx/libsyx.la
LDADDS = $(top_builddir)/syx/libsyx.la

noinst_PROGRAMS = browser

browser_DEPENDENCIES = $(DEPS)
browser_LDADD = $(LDADDS)
browser_SOURCES = browser.c