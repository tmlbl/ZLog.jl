default: libzlogjl.so

libzlogjl.so:
	clang -c -fpic zlogjl.c
	clang -shared -lzlog -o libzlogjl.so zlogjl.o

clean:
	rm *.o *.so
