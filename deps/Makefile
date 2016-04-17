DEPS_DIR=$(shell pwd)
LIB_PFX=$(DEPS_DIR)/lib
INC_PFX=$(DEPS_DIR)/include

UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
DLL=so
LINK_OPT=-Wl,-rpath=$(LIB_PFX)
else ifeq ($(UNAME_S),Darwin)
DLL=dylib
LINK_OPT=""
endif

default: libzlogjl.$(DLL)

zlog-latest-stable:
	wget https://github.com/HardySimpson/zlog/archive/latest-stable.tar.gz
	tar xf latest-stable.tar.gz

zlog-latest-stable/src/libzlog.$(DLL): zlog-latest-stable
	cd zlog-latest-stable/src/ && make install PREFIX=$(DEPS_DIR)

libzlogjl.$(DLL): zlog-latest-stable/src/libzlog.$(DLL)
	cc -c -fpic -I$(INC_PFX) -Wno-format-security zlogjl.c
	cc -shared -Wno-format-security -o libzlogjl.$(DLL) \
		zlogjl.o -L$(LIB_PFX) -lzlog $(LINK_OPT) -lpthread
	ln -s `pwd`/libzlogjl.$(DLL) `pwd`/lib/libzlogjl.$(DLL)

clean:
	rm *.o *.$(DLL)
