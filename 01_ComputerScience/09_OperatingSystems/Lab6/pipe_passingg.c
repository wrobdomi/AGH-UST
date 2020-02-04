#include<stdio.h>
#include<fcntl.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>

#define BUFFSIZE 4096

int main()
{
    // ---------------------------------------------
    // parent --> child1
    // communication
    int pfd1[2];

    // child1 --> parent
    // communication
    int pfd2[2];
    
    pipe(pfd1);
    pipe(pfd2);
    // ---------------------------------------------

    // ---------------------------------------------
    // parent --> child2
    // communication
    int ppfd1[2];

    // child2 --> parent
    // communication
    int ppfd2[2];
    
    pipe(ppfd1);
    pipe(ppfd2);
    // ---------------------------------------------

    int childOne;
    int childTwo;

    char childOneReceived[BUFFSIZE];
    char parentSent[BUFFSIZE];
    char childOneToParent[BUFFSIZE];
    char parentFromChildOneReceived[BUFFSIZE];

    char childTwoReceived[BUFFSIZE];
    char childTwoToParent[BUFFSIZE];
    char parentFromChildTwoReceived[BUFFSIZE];

    const char * lookForThisWord = "pipe";

    int linesNumber = 0;

    int pipesWordNumber = 0;

    // open file
    int fdDictionary = open("dictionary.txt", O_RDONLY);
    if(fdDictionary == -1){
        printf("Error opening dictionary.txt");
        exit(EXIT_FAILURE);
    }

    // printf("BreakPoint1");

    childOne = fork();

    if(childOne == 0) // from parent to childOne
    {
        int j = 0;

        close(pfd1[1]);
        close(pfd2[0]);

        // parent --> childOne
        // receive and count lines
        while(read(pfd1[0], childOneReceived, BUFFSIZE) != 0) {
            for(j=0; j < BUFFSIZE; j++){
                if(childOneReceived[j]=='\n'){
                    linesNumber++;
                }
            }
        }
        
        // childOne --> parent
        // send number of counted lines
        printf("Lines sss are %d", linesNumber);

        sprintf(childOneToParent, "%d", linesNumber);
       
        write(pfd2[1],childOneToParent,BUFFSIZE);
        close(pfd2[1]);
        
        // printf("\nchild recieved is %s and lines are %d", childOneReceived, linesNumber);

        exit(EXIT_SUCCESS);
    }

    childTwo = fork();

    // printf("Child two is %d", childTwo);

    if(childTwo == 0) { // from parent to childTwo

        printf("BreakPoint2.1");

        close(ppfd1[1]);
        close(ppfd2[0]);

        char * s;
        const char * start = NULL;

        // parent --> childTwo
        // receive and count lines
        while(read(ppfd1[0], childTwoReceived, BUFFSIZE) != 0) {
                while ( (s = strstr(start, lookForThisWord)) != NULL ) {
                    pipesWordNumber++;
                }
        }

        // childTwo --> parent
        // send number of counted lines
        printf("Lines are %d", pipesWordNumber);

        sprintf(childTwoToParent, "%d", pipesWordNumber);
       
        write(ppfd2[1], childTwoToParent, BUFFSIZE);
        close(ppfd2[1]);

        exit(EXIT_SUCCESS);
        
        // printf("\nchild recieved is %s and lines are %d", childOneReceived, linesNumber);
    }


    if(childOne > 0 && childTwo > 0) { // parent
        
        close(pfd1[0]);
        close(pfd2[1]);
        close(ppfd1[0]);
        close(ppfd2[1]);

    // printf("BreakPoint4");
    // send from parent to children
        while(read(fdDictionary, parentSent, BUFFSIZE) != 0){
            // printf("BreakPoint5");
            write(pfd1[1], parentSent, BUFFSIZE);
            write(ppfd1[1], parentSent, BUFFSIZE);
            // printf("BreakPoint7");
        }
        close(pfd1[1]);
        close(ppfd1[1]);

    // printf("BreakPoint10");
    // receive from children
        read(pfd2[0], parentFromChildOneReceived, BUFFSIZE);

        printf("\nFrom childOne recieved is %s", parentFromChildOneReceived);

        read(ppfd2[0], parentFromChildTwoReceived, BUFFSIZE);

        printf("\nFrom childTwo recieved is %s", parentFromChildTwoReceived);

        exit(EXIT_SUCCESS);

    }


}