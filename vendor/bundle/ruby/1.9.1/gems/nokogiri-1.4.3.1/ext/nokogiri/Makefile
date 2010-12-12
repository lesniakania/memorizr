
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = .
topdir = /home/ania/.rvm/rubies/ruby-1.9.2-p0/include/ruby-1.9.1
hdrdir = /home/ania/.rvm/rubies/ruby-1.9.2-p0/include/ruby-1.9.1
arch_hdrdir = /home/ania/.rvm/rubies/ruby-1.9.2-p0/include/ruby-1.9.1/$(arch)
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = $(DESTDIR)/home/ania/.rvm/rubies/ruby-1.9.2-p0
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_BASE_NAME)-$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitedir = $(rubylibprefix)/site_ruby
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(prefix)/include
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(prefix)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
rubylibdir = $(rubylibprefix)/$(ruby_version)
archdir = $(rubylibdir)/$(arch)
sitelibdir = $(sitedir)/$(ruby_version)
sitearchdir = $(sitelibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendorarchdir = $(vendorlibdir)/$(sitearch)

CC = gcc
CXX = g++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -Wl,-R -Wl,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -Wl,-R -Wl,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)-static
OUTFLAG = -o 
COUTFLAG = -o 

RUBY_EXTCONF_H = 
cflags   =  $(optflags) $(debugflags) $(warnflags)
optflags = -O3
debugflags = -ggdb
warnflags = -Wextra -Wno-unused-parameter -Wno-parentheses -Wpointer-arith -Wwrite-strings -Wno-missing-field-initializers -Wno-long-long
CFLAGS   = -fPIC $(cflags)  -fPIC  -g -DXP_UNIX -O3 -Wall -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline 
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir)
DEFS     = 
CPPFLAGS = -DHAVE_XMLFIRSTELEMENTCHILD -DHAVE_XMLRELAXNGSETPARSERSTRUCTUREDERRORS -DHAVE_XMLRELAXNGSETPARSERSTRUCTUREDERRORS -DHAVE_XMLRELAXNGSETVALIDSTRUCTUREDERRORS -DHAVE_XMLSCHEMASETVALIDSTRUCTUREDERRORS -DHAVE_XMLSCHEMASETPARSERSTRUCTUREDERRORS -I/opt/local/include/libxml2 -I/usr/local/include/libxml2 -I/home/ania/.rvm/rubies/ruby-1.9.2-p0/include/libxml2 -I/opt/local/include -I/usr/local/include -I/home/ania/.rvm/rubies/ruby-1.9.2-p0/include -I/usr/include -I/usr/include/libxml2  $(DEFS) $(cppflags)
CXXFLAGS = $(CFLAGS) $(cxxflags)
ldflags  = -L.  -rdynamic -Wl,-export-dynamic
dldflags = 
ARCH_FLAG = 
DLDFLAGS = $(ldflags) $(dldflags)
LDSHARED = $(CC) -shared
LDSHAREDXX = $(CXX) -shared
AR = ar
EXEEXT = 

RUBY_BASE_NAME = ruby
RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = ruby
arch = x86_64-linux
sitearch = $(arch)
ruby_version = 1.9.1
ruby = /home/ania/.rvm/rubies/ruby-1.9.2-p0/bin/ruby
RUBY = $(ruby)
RM = rm -f
RM_RF = $(RUBY) -run -e rm -- -rf
RMDIRS = $(RUBY) -run -e rmdir -- -p
MAKEDIRS = /bin/mkdir -p
INSTALL = /bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp

#### End of system configuration section. ####

preload = 

libpath = . $(libdir) /opt/local/lib /usr/local/lib /home/ania/.rvm/rubies/ruby-1.9.2-p0/lib /usr/lib
LIBPATH =  -L. -L$(libdir) -Wl,-R$(libdir) -L/opt/local/lib -Wl,-R/opt/local/lib -L/usr/local/lib -Wl,-R/usr/local/lib -L/home/ania/.rvm/rubies/ruby-1.9.2-p0/lib -Wl,-R/home/ania/.rvm/rubies/ruby-1.9.2-p0/lib -L/usr/lib -Wl,-R/usr/lib
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = /nokogiri
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED) -lexslt -lxslt -lxml2  -lpthread -lrt -ldl -lcrypt -lm   -lc 
SRCS = xml_libxml2_hacks.c xml_element_decl.c xml_sax_push_parser.c xml_text.c xml_xpath_context.c xml_document_fragment.c xml_sax_parser_context.c xml_dtd.c nokogiri.c html_sax_parser_context.c xml_namespace.c html_element_description.c xml_node_set.c xml_sax_parser.c xml_io.c xslt_stylesheet.c xml_processing_instruction.c xml_entity_decl.c xml_reader.c xml_document.c html_document.c xml_cdata.c xml_node.c xml_schema.c xml_attribute_decl.c xml_entity_reference.c xml_element_content.c xml_attr.c xml_comment.c html_entity_lookup.c xml_syntax_error.c xml_relax_ng.c xml_encoding_handler.c
OBJS = xml_libxml2_hacks.o xml_element_decl.o xml_sax_push_parser.o xml_text.o xml_xpath_context.o xml_document_fragment.o xml_sax_parser_context.o xml_dtd.o nokogiri.o html_sax_parser_context.o xml_namespace.o html_element_description.o xml_node_set.o xml_sax_parser.o xml_io.o xslt_stylesheet.o xml_processing_instruction.o xml_entity_decl.o xml_reader.o xml_document.o html_document.o xml_cdata.o xml_node.o xml_schema.o xml_attribute_decl.o xml_entity_reference.o xml_element_content.o xml_attr.o xml_comment.o html_entity_lookup.o xml_syntax_error.o xml_relax_ng.o xml_encoding_handler.o
TARGET = nokogiri
DLLIB = $(TARGET).so
EXTSTATIC = 
STATIC_LIB = 

BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR = /home/ania/memorizr/vendor/bundle/ruby/1.9.1/gems/nokogiri-1.4.3.1/lib$(target_prefix)
RUBYARCHDIR = /home/ania/memorizr/vendor/bundle/ruby/1.9.1/gems/nokogiri-1.4.3.1/lib$(target_prefix)
HDRDIR        = $(rubyhdrdir)/ruby$(target_prefix)
ARCHHDRDIR    = $(rubyhdrdir)/$(arch)/ruby$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).so 
CLEANOBJS     = *.o  *.bak

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-rb

clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-rb-default clean-rb
		@-$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean-rb-default::
distclean-rb::
distclean-so::
distclean: clean distclean-so distclean-rb-default distclean-rb
		@-$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		@-$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		@-$(RMDIRS) $(DISTCLEANDIRS)

realclean: distclean
install: install-so install-rb

install-so: $(RUBYARCHDIR)
install-so: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB)
	@-$(MAKEDIRS) $(@D)
	$(INSTALL_PROG) $(DLLIB) $(@D)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
$(RUBYARCHDIR):
	$(MAKEDIRS) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

$(DLLIB): $(OBJS) Makefile
	@-$(RM) $(@)
	$(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



###
html_document.o: html_document.c
html_element_description.o: html_element_description.c
html_entity_lookup.o: html_entity_lookup.c
html_sax_parser_context.o: html_sax_parser_context.c
nokogiri.o: nokogiri.c
xml_attr.o: xml_attr.c
xml_attribute_decl.o: xml_attribute_decl.c
xml_cdata.o: xml_cdata.c
xml_comment.o: xml_comment.c
xml_document.o: xml_document.c
xml_document_fragment.o: xml_document_fragment.c
xml_dtd.o: xml_dtd.c
xml_element_content.o: xml_element_content.c
xml_element_decl.o: xml_element_decl.c
xml_encoding_handler.o: xml_encoding_handler.c
xml_entity_decl.o: xml_entity_decl.c
xml_entity_reference.o: xml_entity_reference.c
xml_io.o: xml_io.c
xml_namespace.o: xml_namespace.c
xml_node.o: xml_node.c
xml_node_set.o: xml_node_set.c
xml_processing_instruction.o: xml_processing_instruction.c
xml_reader.o: xml_reader.c
xml_relax_ng.o: xml_relax_ng.c
xml_sax_parser.o: xml_sax_parser.c
xml_sax_parser_context.o: xml_sax_parser_context.c
xml_sax_push_parser.o: xml_sax_push_parser.c
xml_schema.o: xml_schema.c
xml_syntax_error.o: xml_syntax_error.c
xml_text.o: xml_text.c
xml_xpath_context.o: xml_xpath_context.c
xslt_stylesheet.o: xslt_stylesheet.c
