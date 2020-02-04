#include<stdio.h>
#include<fcntl.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>

#define BUFFSIZE 4096

int main()
{

    // ---------------------------------------------
    // child1 --> child2
    int ch1ch2Pipe[2];

    // child2 --> parent
    int ch2pPipe[2];
    
    pipe(ch1ch2Pipe);
    pipe(ch2pPipe);
    // ---------------------------------------------

    int childOne;
    int childTwo;

    char childOneToChildTwo[BUFFSIZE];
    char childTwoReceived[BUFFSIZE];

    // char childTwoToParent[BUFFSIZE];
    char parentReceived[BUFFSIZE];
    
    childOne = fork();

    if(childOne == 0){ // child one

        printf("Inside child one ! \n");

        int i = 0;
        close(ch1ch2Pipe[0]);

        for(i=0; i<10; i++){
            sprintf(childOneToChildTwo, "%d", (i+1));
            write(ch1ch2Pipe[1],childOneToChildTwo,BUFFSIZE);
        }

        close(ch1ch2Pipe[0]);
        exit(EXIT_SUCCESS);
    }
    

    childTwo = fork();

    if(childTwo == 0){ // child two

        printf("Inside child two ! \n");
        int numReceived = 0;

        close(ch1ch2Pipe[1]);
        close(ch2pPipe[0]);

        while(read(ch1ch2Pipe[0], childTwoReceived, BUFFSIZE) != 0) {
            printf("Child two received %s \n", childTwoReceived);
            numReceived = (atoi(childTwoReceived) * 5);
            sprintf(childTwoReceived, "%d", numReceived);
            write(ch2pPipe[1], childTwoReceived, BUFFSIZE);
        }
        
        close(ch2pPipe[1]);
      
        exit(EXIT_SUCCESS);
    }
    else { // parent
       printf("I am inside parent ! \n");

       close(ch2pPipe[1]);
     
        while(read(ch2pPipe[0], parentReceived, BUFFSIZE) != 0) {
            printf("Parent Received %s \n", parentReceived);
        }

        exit(EXIT_SUCCESS);
    }

    return 0;

}