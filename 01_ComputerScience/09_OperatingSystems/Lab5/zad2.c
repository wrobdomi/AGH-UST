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
            
         // sleep(1); I - usun wywolanie sleep(1) z main
         }

        for(i = 0 ; i < THREADS_NUM; i++){ // IV - zmodyfikuj program aby czekal na koniec watkow
            pthread_join(threads[i], NULL); // wait for a thread to finish
        }

         printf("End of the main thread!\n"); // III - przed return wypisz info. o zakoncz. watku glow.
        
         return 0;
    }
    // ----------------------------------------------------------
     
    void *PrintHello(void *arg){
        sleep(1); // II -dodaj identyczne wywolanie sleep(1) na poczatku f. rozpoczecia
         printf("Next boring 'Hello World!' version! Thread number %d\n", ((int*) arg));
         return NULL;
    }

