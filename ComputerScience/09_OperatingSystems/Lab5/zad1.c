    #include <pthread.h>
    #include <stdio.h>
    #include <stdlib.h>
    // ----------------------------------------------------------
     
    void *PrintHello(void *arg);
    // ----------------------------------------------------------
     
    int main(int argc, char *argv[]){

         const int THREADS_NUM = 10;
         pthread_t threads[THREADS_NUM];
         int i;

         for(i = 0; i < THREADS_NUM ; i++){
            
            int rc = pthread_create(&threads[i], NULL, PrintHello, (void*)i);
            if (rc){
                printf("Return code: %d\n", rc);
                exit(-1);
            }
            sleep(1);

         }

        
         return 0;
    }
    // ----------------------------------------------------------
     
    void *PrintHello(void *arg){
         printf("Next boring 'Hello World!' version! Thread number %d\n", ((int*) arg));
         return NULL;
    }

