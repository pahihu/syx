SUBDIRS = syx src

dist_stkerneldata_DATA = st/kernel/*.st

install-data-hook:
	$(DESTDIR)$(bindir)/syx -r $(pkgdatadir) -S