    #include <unistd.h>
    #include <stdlib.h>
    #include <string.h>
    #include <errno.h>
    #include <fcntl.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <sys/resource.h>
     
    #include <stdio.h>
     
    #define BUFSIZE 5
     
    int main(int argc, char* argv[])
    {

      char* filename;
      int s = 100;
      int fd;
      
      if(argc == 1){
          printf("Not enough arguments. Please enter filename.");
          return 1;
      }
      if(argc == 2){
          printf("One argument");
          filename = argv[1];
          fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC);
          if(fd == -1){
              printf("Error opening file");
              exit(EXIT_FAILURE);
          }
      } else if(argc == 3){
          printf("Two arguments");
          filename = argv[2];
          fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC);
          if(fd == -1){
              printf("Error opening file");
              exit(EXIT_FAILURE);
          }
          s = atoi(argv[1]);
          printf("s is %d", s);
      }

      struct rlimit limit;
      char buf[BUFSIZE] = {'a','a','a','a','a'};
      
      int bytes = 0, towrite, smin = 0, smax = 10000, sdef = 100, 
        wrote; 
     
      // filename = "tmp.txt";
      if((s < smin) || (s > smax))
         s = sdef;     
     
      /* reading file size limit */
      getrlimit(RLIMIT_FSIZE, &limit);
      printf("RLIMIT_FSIZE: cur=%d, max=%d\n", limit.rlim_cur, limit.rlim_max);
      fflush(stdout);
     
      printf("Writing %d bytes into %s file...\n", s, filename);
      
      do{
        towrite = s - bytes;
        towrite = towrite<BUFSIZE?towrite:BUFSIZE;
        wrote = write(fd, buf, towrite);
        bytes += wrote;
        if(wrote == -1)
          break;
      }
      while((wrote > 0) && (bytes < s));
      close(fd);
     
      printf("Returning zero");

      return 0;
    }

