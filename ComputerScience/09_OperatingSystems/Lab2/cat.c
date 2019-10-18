#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>

#define BUFSIZE 512

ssize_t readall(int fd, void *buf, size_t nbyte)
{
     ssize_t nread = 0;
	 ssize_t n;	
	
     do {
		if ( (n = read(fd, &((char *)buf)[nread], nbyte - nread)) == -1 ) {
             if (errno == EINTR)
                 continue;
             else
                 return -1;
         }
		 if(n == 0){
		 	return 0;
		 }
         nread += n;
     } while (nread < nbyte);
     
	return nread;
	
}



    int main(int argc, char **argv){

		int toRead = -1;
		char buf[BUFSIZE];
		
    	if (argc != 2)
    	{
    		printf("Podaj tekst dla cat: ");
			scanf("%s", buf); // standardowe wejscie
			printf("%s", buf);
			return 0;
    	}

        toRead = open(argv[1], O_RDONLY);
    	if(toRead == -1){
            if(errno == ENOENT){
                perror("File does not exists: ");
                exit(EXIT_FAILURE);
            }
            if(errno == EACCES){
                perror("Permission denied: ");
                exit(EXIT_FAILURE);
            }
        }

        readall(toRead, buf, BUFSIZE); // plik
		
		printf("%s", buf);
    	
		return 0;
}