MAINTAINERCLEANFILES	= Makefile.in
CLEANFILES		= manual/syx.info
info_TEXINFOS		= manual/syx.texi

SUFFIXES		= .info .pdf
info_docs		= manual/syx.info
html_docs		= manual/syx.html
pdf_docs		= manual/syx.pdf

.texi.info:
	$(MAKEINFO) $<

.texi.html:
	$(MAKEINFO) --html $<

.texi.pdf:
	texi2pdf $<

reference:
	cd $(top_srcdir) && doxygen Doxyfile

.PHONY: info doc pdf html reference
info: manual/syx.texi $(info_docs)
pdf: manual/syx.texi $(pdf_docs)
html: manual/syx.texi $(html_docs)
doc: info html reference pdf
