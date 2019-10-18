shell: shell.o funcs.o
		gcc shell.o funcs.o -o shell -I.

funcs.o: funcs.c funcs.h
		gcc -c -Wall -pedantic funcs.c -I.
		
shell.o: shell.c funcs.h
		gcc -c -Wall -pedantic shell.c -I.