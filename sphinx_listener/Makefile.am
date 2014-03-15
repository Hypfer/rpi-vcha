SUBDIRS = src \
	  doc \
	  model \
	  include 

EXTRA_DIST = autogen.sh							\
	pocketsphinx.pc.in						\
	m4/pkg.m4							

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = pocketsphinx.pc
CLEANFILES = pocketsphinx.pc

ACLOCAL_AMFLAGS = -I m4
