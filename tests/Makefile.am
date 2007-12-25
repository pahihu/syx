AM_CFLAGS = -ansi -pedantic

INCLUDES = -I$(top_srcdir)/syx

DEPS = $(top_builddir)/syx/libsyx.la

LDADDS = $(top_builddir)/syx/libsyx.la

TESTS = testlexer testimage testcoldparser testinstances testparser	\
	testinterp testforeignstruct testscheduler

noinst_PROGRAMS = testlexer testimage testcoldparser testinstances testparser	\
		  testinterp testforeignstruct testscheduler

testlexer_DEPENDENCIES = $(TEST_DEPS)
testimage_DEPENDENCIES = $(TEST_DEPS)
testcoldparser_DEPENDENCIES = $(TEST_DEPS)
testinstances_DEPENDENCIES = $(TEST_DEPS)
testparser_DEPENDENCIES = $(TEST_DEPS)
testinterp_DEPENDENCIES = $(TEST_DEPS)
testforeignstruct_DEPENDENCIES = $(TEST_DEPS)
testscheduler_DEPENDENCIES = $(TEST_DEPS)

testlexer_LDADD = $(LDADDS)
testimage_LDADD = $(LDADDS)
testcoldparser_LDADD = $(LDADDS)
testinstances_LDADD = $(LDADDS)
testparser_LDADD = $(LDADDS)
testinterp_LDADD = $(LDADDS)
testforeignstruct_LDADD = $(LDADDS)
testscheduler_LDADD = $(LDADDS)

testlexer_SOURCES = testlexer.c
testimage_SOURCES = testimage.c
testcoldparser_SOURCES = testcoldparser.c
testinstances_SOURCES = testinstances.c
testparser_SOURCES = testparser.c
testinterp_SOURCES = testinterp.c
testforeignstruct_SOURCES = testforeignstruct.c
testscheduler_SOURCES = testscheduler.c

EXTRA_DIST = SConscript stsupport/*.st
CONFIG_CLEAN_FILES = test.sim
