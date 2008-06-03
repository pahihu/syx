MAINTAINERCLEANFILES	= Makefile.in
CLEANFILES		= manual/syx.info
info_TEXINFOS		= manual/syx.texi
syx_TEXINFOS		= manual/blocks.texi manual/commonobjects.texi manual/introsyx.texi \
			manual/objects.texi manual/inheritance.texi manual/variables.texi \
			manual/streference.texi manual/varscope.texi manual/messages.texi \
			manual/methods.texi manual/fdl-1.2.texi manual/language.texi

SUFFIXES		= .info .pdf
info_docs		= manual/syx.info
html_docs		= manual/syx.html
pdf_docs		= manual/syx.pdf

man1_MANS		= manpage/syx.1

EXTRA_DIST		= reference/html/extras/footer.html manpage/syx.1	\
			$(syx_TEXINFOS)

.texi.info:
	$(MAKEINFO) $<

.texi.html:
	$(MAKEINFOHTML) $<

.texi.pdf:
	$(TEXI2PDF) $<

reference:
	cd $(top_srcdir) && doxygen Doxyfile

.PHONY: reference