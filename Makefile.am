SUBDIRS = syx src $(plugin_subdirs) share tests

dist_stkerneldata_DATA = st/kernel/*.st
dist_stforeigndata_DATA = st/foreign/*.st

EXTRA_DIST =						\
	autogen.sh Doxyfile README-BINARIES SConstruct	\
	syx.sln syx.vcproj makefile.vc

installcheck-local:
	$(DESTDIR)$(bindir)/syx -r $(DESTDIR)$(pkgdatadir) -S
	@echo ============================================
	@echo Smalltalk YX has been installed successfully
	@echo ============================================