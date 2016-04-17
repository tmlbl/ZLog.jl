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

libzlogjl.$(DLL): zlog-latest-stable/src/libzlog.$(DLL)
	cc -c -fpic -I./zlog-latest-stable/src -Wno-format-security zlogjl.c
	cc -shared -L./zlog-latest-stable/src -Wno-format-security -lzlog -o libzlogjl.$(DLL) zlogjl.o

clean:
	rm *.o *.$(DLL)
