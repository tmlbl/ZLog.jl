default: libzlogjl.so

zlog-latest-stable:
	wget https://github.com/HardySimpson/zlog/archive/latest-stable.tar.gz
	tar xf latest-stable.tar.gz

zlog-latest-stable/src/libzlog.so: zlog-latest-stable
	cd zlog-latest-stable && make

libzlogjl.so: zlog-latest-stable/src/libzlog.so
	clang -c -fpic zlogjl.c
	clang -shared -lzlog -o libzlogjl.so zlogjl.o

clean:
	rm *.o *.so
