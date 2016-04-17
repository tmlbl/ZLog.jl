DEPS_DIR=`pwd`
LIB_PFX=`pwd`/zlog-latest-stable/lib/
INC_PFX=`pwd`/zlog-latest-stable/include/

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
	cd zlog-latest-stable && make
	cd zlog-latest-stable && make install PREFIX=$(DEPS_DIR)

libzlogjl.$(DLL): zlog-latest-stable/src/libzlog.$(DLL)
	cc -c -fpic -I$(INC_PFX) -Wno-format-security zlogjl.c
	cc -shared -Wno-format-security -o libzlogjl.$(DLL) \
		zlogjl.o -L$(LIB_PFX) -lzlog $(LINK_OPT) -lpthread

clean:
	rm *.o *.$(DLL)
