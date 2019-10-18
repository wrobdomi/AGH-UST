#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include<stdlib.h> 

#define BUFSIZE 1024
 
int main (int argc, char **argv) {
    int f1, c;
    char b[BUFSIZE], *n1;
 	int bytesRead;
	
    c = 10;
    n1 = argv[1];
 
    f1 = open (n1, O_RDONLY);
	if(f1 == -1){
		perror("open failed: ");
		exit(EXIT_FAILURE);
	}
	
    bytesRead = read (f1, b, c);
	if(bytesRead == -1){
		perror("read failed: ");
		exit(EXIT_FAILURE);
	}
	else{
		if(bytesRead == 0){
			printf("read EOF");
		} else{
		printf("%s: Przeczytano %d znakow z pliku %s: \"%s\"\n",
		   argv[0], c, n1, b);
		}
	}
    close(f1);
 
	exit(EXIT_SUCCESS);
	
    return(0);
}
