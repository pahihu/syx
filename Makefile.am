SUBDIRS = syx src plugins share doc examples tests

dist_stkerneldata_DATA = st/kernel/*.st
dist_stforeigndata_DATA = st/foreign/*.st

EXTRA_DIST =						\
	autogen.sh Doxyfile README-BINARIES SConstruct	\
	syx.sln syx.vcproj makefile.vc			\
	INSTALL-SCONS msvc/syx-config.h	scripts/excm.py

CLEANFILES	= syx.pc

docdir		= $(top_builddir)/doc
pkgconfigdir	= $(libdir)/pkgconfig
pkgconfig_DATA	= syx.pc

doc:
	@echo Making $@ in $(docdir)
	@cd $(docdir) && make $@

install: install-recursive
	@echo Generating default image at $(DESTDIR)$(datadir)/default.sim
	LD_PRELOAD="$(DESTDIR)$(libdir)/libsyx.so" $(DESTDIR)$(bindir)/syx -r $(DESTDIR)$(pkgdatadir) -S
	@echo ============================================
	@echo Smalltalk YX has been installed successfully
	@echo ============================================

.PHONY: doc
