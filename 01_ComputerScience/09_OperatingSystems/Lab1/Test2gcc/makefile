hello: main.o hello.o
		gcc main.o hello.o -o hello -I.

hello.o: hello.c hello.h
		gcc -c -Wall -ansi -pedantic hello.c -I.
		
main.o: main.c hello.h
		gcc -c -Wall -ansi -pedantic main.c -I.
		
