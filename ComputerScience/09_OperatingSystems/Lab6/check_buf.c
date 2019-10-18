#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>

int main(){
    
    int pfd[2];
    long v;

    pipe(pfd);

    v = fpathconf(pfd[0], _PC_PIPE_BUF);
    printf("PIPE_BUF = %ld\n", v);
    
}