#
#
# License: LGPL-3.0-only  same as upstream
# Copyright: 2018 Geert Stappers <stappers@stappers.it>
#

JAVA_HOME = /usr/lib/jvm/default-java
JAVA_INCLUDE_PATH = $(JAVA_HOME)/include

CC = gcc

# Define listSerialsj variables
LSJ_NAME = listSerialsj
LSJ_MAJOR = 1
LSJ_MINOR = 4
LSJ_PATCH = 0
LSJ_RELEASE = 0
LSJ_LINKERNAME = lib$(LSJ_NAME).so
LSJ_SONAME = $(LSJ_LINKERNAME).$(LSJ_MAJOR)
LSJ_REALNAME = $(LSJ_SONAME).$(LSJ_MINOR).$(LSJ_RELEASE)
LSJ_SRCS = jnilib.c
LSJ_OBJS = $(LSJ_SRCS:.c=.o)
$(LSJ_REALNAME): CUSTOM_CFLAGS =-fPIC -I$(JAVA_INCLUDE_PATH)\
	-I$(JAVA_INCLUDE_PATH)/linux
$(LSJ_REALNAME): CUSTOM_LDFLAGS = -shared -lserialport


all: listserialportsc $(LSJ_REALNAME)


listserialportsc: main.c
	$(CC) -g -o $@ $<  -l serialport

$(LSJ_REALNAME): $(LSJ_OBJS)
	$(CC) $(LDFLAGS) $(CUSTOM_LDFLAGS) -Wl,-soname,$(LSJ_SONAME) -o $@ $^
	ln -sf $@ $(LSJ_SONAME)
	ln -sf $(LSJ_SONAME) $(LSJ_LINKERNAME)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(CUSTOM_CFLAGS) -c -o $@ $<

version: Makefile
	echo "VERSION=$(LSJ_MAJOR).$(LSJ_MINOR).$(LSJ_PATCH)" > $@
	@cat $@
	@echo Advice: compare it with https://github.com/arduino/listSerialPortsC/tags

install: all
	install -d $(DESTDIR)/usr/bin
	install -m 755 listserialportsc $(DESTDIR)/usr/bin

clean:
	rm -f *.so* *.o
	rm -f listserialportsc

# after script/update_upstream or script/create_orig_tar_xz
# but before another build
dist-clean: clean
	rm -f version compile_linux.sh

dist:
	make version
	script/create_orig_tar_xz
	ls ../listserialportsc_*.orig.tar.xz
