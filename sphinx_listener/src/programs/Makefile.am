bin_PROGRAMS = rpi-vcha
	
rpi_vcha_SOURCES = rpi-vcha.c
rpi_vcha_LDADD = \
	$(top_builddir)/src/libpocketsphinx/libpocketsphinx.la -lsphinxad

INCLUDES = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/libpocketsphinx \
	-I$(top_builddir)/include
