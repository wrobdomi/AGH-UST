    #include <sys/types.h>
    #include <sys/stat.h>
    #include <time.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <libgen.h>
	#include <pwd.h>
	#include <grp.h>
	#include <string.h>
	#include <unistd.h>
	#include <fcntl.h>
	#include <aio.h>
	#include <errno.h>
	
    /* -------------------------------------------------------------------------------- */
     
    static void print_type(struct stat *sb);
    static void print_ino(const struct stat *sb);
    static void print_perms(const struct stat *sb);
    static void print_linkc(const struct stat *sb);
    static void print_owner(const struct stat *sb);
    static void print_size(const struct stat *sb);
    static void print_laststch(const struct stat *sb);
    static void print_lastacc(const struct stat *sb);
    static void print_lastmod(const struct stat *sb);
    static void print_name(const struct stat *sb, char *name);
	static void print_content(char * name);
    /* -------------------------------------------------------------------------------- */
     
    int  main(int argc, char *argv[])
    {
      struct stat sb;
     
      if (argc != 2) {
        fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
        exit(EXIT_FAILURE);
      }
     
      if (stat(argv[1], &sb) == -1) {
        perror("stat");
        exit(EXIT_SUCCESS);
      }
     
      print_type(&sb);
      print_name(&sb, argv[1]);
      print_ino(&sb);
      print_perms(&sb);
      print_linkc(&sb);
      print_owner(&sb);
      print_size(&sb);
      print_laststch(&sb);
      print_lastacc(&sb);
      print_lastmod(&sb);
     
	  print_content(argv[1]);
		
      exit(EXIT_SUCCESS);
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_type(struct stat *sb){
      printf("File type:                ");
      switch (sb->st_mode & S_IFMT) {
      case S_IFBLK:  printf("block device\n");            break;
      case S_IFCHR:  printf("character device\n");        break;
  	  case S_IFDIR:	 printf("directory\n");				  break;
  	  case S_IFIFO:	 printf("named or unnamed pipe\n");   break;
	  case S_IFLNK:  printf("symbolic link\n");			  break;
  	  case S_IFREG:  printf("regular file\n");		      break;
      case S_IFSOCK: printf("Socket\n");			      break;
      default:       printf("unknown?\n");                break;
      }
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_ino(const struct stat *sb){
      printf("I-node number:            %ld", (long) sb->st_ino);
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_perms(const struct stat *sb){
		
	  char *perms = (char *) malloc(sizeof(char) * 128);
	  strcat(perms, "Your permissions: read: ");	
	  
	  int usr = 0;
	  int grp = 0;
	  int oth = 0; 
      printf("Mode:                     %lo (octal)\n", (unsigned long) sb->st_mode);
	  if( (sb->st_mode & S_IRUSR) == S_IRUSR){
	  	usr += 4;
		strcat(perms, "yes, write: ");
	  }
	  else{
	  	strcat(perms, "no, write: ");
	  }
	  if( (sb->st_mode & S_IWUSR) == S_IWUSR){
	  	usr += 2;
		strcat(perms, "yes, execute: ");
	  }
	  else{
	  	strcat(perms, "no, execute: ");
	  }
	  if( (sb->st_mode & S_IXUSR) == S_IXUSR){
	  	usr += 1;
		strcat(perms, "yes");
	  }
	  else {
	  	strcat(perms, "no");
	  }
	  if( (sb->st_mode & S_IRGRP) == S_IRGRP){
	  	grp += 4;
	  }
	  if( (sb->st_mode & S_IWGRP) == S_IWGRP){
	  	grp += 2;
	  }
	  if( (sb->st_mode & S_IXGRP) == S_IXGRP){
	  	grp += 1;
	  }	
	  if( (sb->st_mode & S_IROTH) == S_IROTH){
	  	oth += 4;
	  }
	  if( (sb->st_mode & S_IWOTH) == S_IWOTH){
	  	oth += 2;
	  }
	  if( (sb->st_mode & S_IXOTH) == S_IXOTH){
	  	oth += 1;
	  }		
	  printf("Permission: %d %d %d \n", usr, grp, oth);
	  printf("%s\n", perms);
		
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_linkc(const struct stat *sb){
      printf("Link count:               %ld\n", (long) sb->st_nlink);
    }
    /* -------------------------------------------------------------------------------- */
     
  
	static void print_owner(const struct stat *sb){
	  
	  char *userName =(char *)malloc(64*sizeof(char));
	  char *groupName =(char *)malloc(64*sizeof(char));  
		
	  long uid = (long) sb->st_uid;
	  long gid = (long) sb->st_gid;
	  struct passwd *pwd = getpwuid(uid);
	  struct group *grp = getgrgid(gid);
	 
	  userName = pwd->pw_name;
	  groupName = grp->gr_name;

	  printf("Ownership:                UID=%ld   GID=%ld\n", (long) sb->st_uid, (long) sb->st_gid);
	  printf("Ownership:                %s(%ld) %s(%ld)\n", userName, (long) sb->st_uid, groupName, (long) sb->st_gid );


	}
    /* -------------------------------------------------------------------------------- */
     
    static void print_size(const struct stat *sb){
      printf("Preferred I/O block size: %ld bytes\n", (long) sb->st_blksize);
      
	  printf("File size:                %lld bytes\n",(long long) sb->st_size);
 
      printf("Kb File size:           %f kb\n",(float)sb->st_size/1024);
  
	  printf("MB File size:           %f Mb\n",(float)sb->st_size/(1024*1024));
		
      printf("Blocks allocated:         %lld\n",(long long) sb->st_blocks);
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_laststch(const struct stat *sb){
      printf("Last status change:       %s", ctime(&sb->st_ctime));
	  
	  time_t currentTime;
  	  time(&currentTime);
  	  long long diffTime;
	  diffTime = difftime(currentTime,sb->st_ctime);
		
	  printf("Last status change:         %lld days ago\n",diffTime/(60*60*24) );
		
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_lastacc(const struct stat *sb){
      printf("Last file access:         %s", ctime(&sb->st_atime));
		
	  time_t currentTime;
  	  time(&currentTime);
  	  long long diffTime;
	  diffTime = difftime(currentTime,sb->st_atime);
		
	  printf("Last file access:         %lld days ago\n",diffTime/(60*60*24) );
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_lastmod(const struct stat *sb){
      printf("Last file modification:   %s", ctime(&sb->st_mtime));
		
	  time_t currentTime;
  	  time(&currentTime);
  	  long long diffTime;
	  diffTime = difftime(currentTime,sb->st_mtime);
		
	  printf("Last file modification:         %lld days ago\n",diffTime/(60*60*24) );
    }
    /* -------------------------------------------------------------------------------- */
     
    static void print_name(const struct stat *sb, char *name){
      char* bname = basename(name);
      printf("Name of the file:         %s\n", bname);
		
	  char* lname = (char*) malloc(256 * sizeof(char));
	  ssize_t bytesRead;
	  
	  if( (sb->st_mode & S_IFMT) == S_IFLNK ){
		printf("Is Link");
		if((bytesRead = readlink(name,lname, sizeof(lname)) != -1)){
			if(lname != NULL){
		  		lname[bytesRead] = '\0';
		  		printf("SymLink %s -> File %s\n",lname,bname);
			}
			else{
		  		exit(EXIT_FAILURE);
			}
	  	} 
	}
		
    }
    /* -------------------------------------------------------------------------------- */

	static void print_content(char * name){
		
		char * choice = (char*) malloc(1*sizeof(char));
		
		printf("Would you like to print content of your file ?\n");
		printf("Press Y - Yes, any key otherwise");
		
		int fd;
		struct aiocb cb;
		char check[256];
		
		scanf("%c", choice);
		if(*choice == 'y' || *choice == 'Y'){
			
			fd = open(name, O_RDONLY); // open file
			memset(&cb, 0, sizeof(struct aiocb));
			cb.aio_fildes = fd; // configure struct
			cb.aio_buf = check;
			cb.aio_nbytes = 256;
			printf("reading aio");
			int n;
			while(1){
				n = aio_read(&cb);
				if(n==-1){
					printf("AIO Error");
					exit(EXIT_FAILURE);
				}
				int err;
				printf("reading aio 2");
				while((err = aio_error (&cb)) == EINPROGRESS); // wait for asynchronous read to complete
				printf("%s\n", check);
				if(n==0){
					break;
				}
			}
				
		} else {
			printf("Printing cancelled");
		}
		
		return;
		
	}
