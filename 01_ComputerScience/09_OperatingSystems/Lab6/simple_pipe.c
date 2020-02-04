    #include <stdio.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdlib.h>
    #include <sys/types.h>
     
    int main(int argc, char *argv[]){
     
        int pfd[2]; // file descriptors 
        size_t nread;
        char buf[100];
        pid_t newProcessPID;

        pipe(pfd); // create pipe

        char * str ="Ur beautiful pipe example";
        
        newProcessPID = fork(); // create child process

        if(newProcessPID == 0){ // child process
            close(pfd[1]); // close writing descriptor
            nread=read(pfd[0],buf,sizeof(buf));
            (nread!=0)?printf("%s (%ld bytes)\n",buf,(long)nread):printf("No data\n");
            _exit(EXIT_SUCCESS);
        } else{ // parent process
            close(pfd[0]); // close reading descriptor
            write(pfd[1], str, strlen(str));
            _exit(EXIT_SUCCESS);
        }
     
        return 0;
}

