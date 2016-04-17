UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
DLL=so
else ifeq ($(UNAME_S),Darwin)
DLL=dylib
endif

default: libzlogjl.$(DLL)

zlog-latest-stable:
	wget https://github.com/HardySimpson/zlog/archive/latest-stable.tar.gz
	tar xf latest-stable.tar.gz

zlog-latest-stable/src/libzlog.$(DLL): zlog-latest-stable
	cd zlog-latest-stable && make

LIB_PFX=`pwd`/zlog-latest-stable/src

libzlogjl.$(DLL): zlog-latest-stable/src/libzlog.$(DLL)
	cc -c -fpic -I$(LIB_PFX) -Wno-format-security zlogjl.c
	cc -shared -L$(LIB_PFX) -Wno-format-security -o libzlogjl.$(DLL) \
		zlogjl.o -lzlog -Wl,-rpath=$(LIB_PFX) -lpthread

clean:
	rm *.o *.$(DLL)
