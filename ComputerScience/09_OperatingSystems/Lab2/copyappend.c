    /*
     * copy1.c
     * 
     * based on: 
     *
     * Miscellaneous examples for Chap. 2
     * AUP2, Chap. 2
     *
     * modified by WTA
     */
     
    /*[copy-with-bug]*/
     
    #include <fcntl.h>
    #include <unistd.h>
    #include <stdio.h>
    #include <errno.h>
    #include <stdlib.h>
     
    #define BUFSIZE 512
     
    void copy(char *from, char *to)  /* has a bug */
    {
    	int fromfd = -1, tofd = -1;
    	ssize_t nread;
    	char buf[BUFSIZE];
     
    	fromfd = open(from, O_RDONLY);
    	if(fromfd == -1){
            if(errno == ENOENT){
                perror("File does not exists: ");
                exit(EXIT_FAILURE);
            }
            if(errno == EACCES){
                perror("Permission denied: ");
                exit(EXIT_FAILURE);
            }
        }

        
        tofd = open(to, O_WRONLY | O_CREAT | O_TRUNC,
    				S_IRUSR | S_IWUSR);
        if(tofd == -1){
            if(errno == ENOENT){
                perror("File does not exists: ");
                exit(EXIT_FAILURE);
            }
            if(errno == EACCES){
                perror("Permission denied: ");
                exit(EXIT_FAILURE);
            }
        }


    	while ((nread = read(fromfd, buf, sizeof(buf))) > 0)
    	    write(tofd, buf, nread);	
        if(nread == -1){
            perror("Reading failed: ");
        }
        

    
        close(fromfd);
    	close(tofd);
    	return;
    }





    /*[writeall]*/
    ssize_t writeall(int fd, const void *buf, size_t nbyte)
    {
        ssize_t nwritten = 0, n;
        
        do {
            if ((n = write(fd, &((const char *)buf)[nwritten], nbyte - nwritten)) == -1) {
                if (errno == EINTR)
                    continue;
                else
                    return -1;
            }
            nwritten += n;
        } while (nwritten < nbyte);
        return nwritten;
    }


    /*[readall]*/
    // ssize_t readall(int fd, const void *buf, size_t nbyte)
    // {
    //     ssize_t nread = 0, n;
        
    //     do {
    //         if ((n = read(fd, &((const char *)buf)[read], nbyte - nread)) == -1) {
    //             if (errno == EINTR)
    //                 continue;
    //             else
    //                 return -1;
    //         }char buf[BUFSIZE];
    //         nread += n;
    //     } while (nread < nbyte);
    //     return nread;
    // }


  


    void copyAppend(char *from, char *to)  /* has a bug */
    {
    	int fromfd = -1, tofd = -1;
    	ssize_t nread;
    	char buf[BUFSIZE];
     
    	fromfd = open(from, O_RDONLY | O_APPEND);
    	if(fromfd == -1){
            if(errno == ENOENT){
                perror("File does not exists: ");
                exit(EXIT_FAILURE);
            }
            if(errno == EACCES){
                perror("Permission denied: ");
                exit(EXIT_FAILURE);
            }
        }

        
        tofd = open(to, O_WRONLY | O_CREAT | O_TRUNC,
    				S_IRUSR | S_IWUSR | O_APPEND);
        if(tofd == -1){
            if(errno == ENOENT){
                perror("File does not exists: ");
                exit(EXIT_FAILURE);
            }
            if(errno == EACCES){
                perror("Permission denied: ");
                exit(EXIT_FAILURE);
            }
        }


    	while ((nread = read(fromfd, buf, sizeof(buf))) > 0)
    	    write(tofd, buf, nread);	
        if(nread == -1){
            perror("Reading failed: ");
        }
            
        close(fromfd);
    	close(tofd);
    	return;
    }


    




    // cat
    // lseek / append

    int main(int argc, char **argv){

        // char buf[BUFSIZE];
        // int fromfd; 
        // fromfd = open(argv[1], O_RDONLY);

        // if( argc == 1){
        //     readall(fromfd, buf, BUFSIZE);
        //     printf(buf);
        // }
    	if (argc != 3)
    	{
    		fprintf(stderr,"usage: %s from_pathname to_pathname\n", argv[0]);
    		return 1;
    	}
    	copyAppend(argv[1], argv[2]);
    	return 0;
    }

