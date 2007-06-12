INCLUDES		=	\
	-I$(top_srcdir)		\
	$(BASE_DEPENDENCIES_CFLAGS) $(JIT_CFLAGS)

DEPS =                                                                  \
        $(top_builddir)/syx/libsyx-$(SYX_API_VERSION).la 

LDADDS =                                                                \
        $(top_builddir)/syx/libsyx-$(SYX_API_VERSION).la

TESTS = 			\
	testlexer		\
	testimage		\
	testcoldparser		\
	testinstances		\
	testparser		\
	testinterp		\
	testscheduler		\
	testplugin

noinst_PROGRAMS =		\
	testlexer		\
	testcoldparser		\
	testinstances		\
	testparser		\
	testimage		\
	testinterp		\
	testscheduler		\
	testplugin

testlexer_DEPENDENCIES = $(TEST_DEPS)
testcoldparser_DEPENDENCIES = $(TEST_DEPS)
testinstances_DEPENDENCIES = $(TEST_DEPS)
testparser_DEPENDENCIES = $(TEST_DEPS)
testinterp_DEPENDENCIES = $(TEST_DEPS)
testscheduler_DEPENDENCIES = $(TEST_DEPS)
testimage_DEPENDENCIES = $(TEST_DEPS)
testplugin_DEPENDENCIES = $(TEST_DEPS)

testlexer_LDADD = $(LDADDS)
testcoldparser_LDADD = $(LDADDS)
testinstances_LDADD = $(LDADDS)
testparser_LDADD = $(LDADDS)
testinterp_LDADD = $(LDADDS)
testscheduler_LDADD = $(LDADDS)
testimage_LDADD = $(LDADDS)
testplugin_LDADD = $(LDADDS)

testlexer_SOURCES = testlexer.c
testcoldparser_SOURCES = testcoldparser.c
testinstances_SOURCES = testinstances.c
testparser_SOURCES = testparser.c
testinterp_SOURCES = testinterp.c
testscheduler_SOURCES = testscheduler.c
testimage_SOURCES = testimage.c
testplugin_SOURCES = testplugin.c