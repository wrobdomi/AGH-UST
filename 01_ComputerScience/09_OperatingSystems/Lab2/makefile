compare: t.o timecmp.o
	gcc timecmp.o t.o -o compare -I.

t.o : t.c t.h
	gcc -c -Wall -pedantic t.c -I.

timecmp.o: timecmp.c t.h
	gcc -c -Wall -pedantic timecmp.c -I.