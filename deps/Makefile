DEPS_DIR=$(shell pwd)
LIB_PFX=$(DEPS_DIR)/lib
INC_PFX=$(DEPS_DIR)/include

UNAME_S=$(shell sh -c 'uname -s 2>/dev/null || echo not')
ifeq ($(UNAME_S),Linux)
DLL=so
LINK_OPT=-Wl,-rpath=$(LIB_PFX)
else ifeq ($(UNAME_S),Darwin)
DLL=dylib
LINK_OPT="-install-name $(DEPS_DIR)/libzlogjl.$(DLL)"
endif

default: libzlogjl.$(DLL)

zlog-latest-stable:
	wget https://github.com/HardySimpson/zlog/archive/latest-stable.tar.gz
	tar xf latest-stable.tar.gz

zlog-latest-stable/src/libzlog.$(DLL): zlog-latest-stable
	make -C zlog-latest-stable/src/ install PREFIX=$(DEPS_DIR)

libzlogjl.$(DLL): zlog-latest-stable/src/libzlog.$(DLL)
	cc -c -fpic -I$(INC_PFX) -Wno-format-security zlogjl.c
	cc -dynamiclib -Wno-format-security -o libzlogjl.$(DLL) \
		zlogjl.o -L$(LIB_PFX) -Xlinker -rpath -Xlinker  `pwd` -lzlog $(LINK_OPT) -lpthread
	ln -sf `pwd`/libzlogjl.$(DLL) `pwd`/lib/libzlogjl.$(DLL)
ifeq ($(UNAME_S),Darwin)
	install_name_tool -change libzlog...dylib $(DEPS_DIR)/lib/libzlog...dylib libzlogjl.dylib
endif

clean:
	rm *.o *.$(DLL)
