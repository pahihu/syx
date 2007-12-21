SUBDIRS = syx src tests

dist_stkerneldata_DATA = st/kernel/*.st
dist_stforeigndata_DATA = st/foreign/*.st

EXTRA_DIST =

install-data-hook:
	$(DESTDIR)$(bindir)/syx -r $(pkgdatadir) -S