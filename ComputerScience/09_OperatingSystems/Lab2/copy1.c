#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h> /* add errno.h to get errno variable */
#include<stdlib.h>

#define BUFSIZE 512
 
void copy(char *from, char *to)  /* has a bug */
{
	int fromfd = -1, tofd = -1;
	ssize_t nread;
	char buf[BUFSIZE];
 
	fromfd = open(from, O_RDONLY);
	if(fromfd == -1){
		if(errno == ENOENT ){
			printf("fromfd - Errno is %d", errno); /* No such file or directory */
			perror("Error: ");
			exit(EXIT_FAILURE);
		}
		if(errno == EACCES){
			printf("fromfd - Errno is %d", errno); /* Permission denied */
			perror("Error: ");
			exit(EXIT_FAILURE);
		}
	}
	
	
	tofd = open(to, O_WRONLY | O_CREAT | O_TRUNC,
				S_IRUSR | S_IWUSR);
	if(tofd == -1){
		if(errno == ENOENT )
		{
			printf("to - Errno is %d", errno); /* No such file or directory */
			perror("Error: ");
			close(fromfd);		
			exit(EXIT_FAILURE);
		}
		if(errno == EACCES)
		{
			printf("to - Errno is %d", errno); /* Permission denied */
			perror("Error: ");
			close(fromfd);
			close(tofd);
			exit(EXIT_FAILURE);
		}
	}

	
	
	while ((nread = read(fromfd, buf, sizeof(buf))) > 0)
	    write(tofd, buf, nread);	
 	
	if(nread == -1){
		if(errno == ENOENT )
		{
			printf("read - Errno is %d", errno); /* No such file or directory */
			perror("Error: ");
			close(fromfd);
			close(tofd);
			exit(EXIT_FAILURE);
		}
		if(errno == EACCES)
		{
			printf("read - Errno is %d", errno); /* Permission denied */
			perror("Error: ");
			close(fromfd);
			close(tofd);
			exit(EXIT_FAILURE);
		}
	}
	
    close(fromfd);
	close(tofd);
	return;
}
 
int main(int argc, char **argv){
	if (argc != 3)
	{
		fprintf(stderr,"usage: %s from_pathname to_pathname\n", argv[0]);
		return 1;
	}
	copy(argv[1], argv[2]);
	return 0;
}