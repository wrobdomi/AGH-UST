  #include "funcs.h"
	#include <stdlib.h>
  #include <sys/resource.h>
    /* -------------------------------------------------------------------------------------- */
     
    int main(void)
    {
      int res;
      char cmd[MAXCMD];
      struct cmdlist cmds;
     
      /* setting up the initial values of the structure  */
      /* this should be done every time when new object is created */
      setupnewcommand(&cmds);
     
      /* Setting up file size limit for this process and for the child processes */
     
      /* main loop of the shell */
      /* this loop proceses command wirtten by user in the following steps: */
      /* 1. Displaying command prompt
         2. Reading command from the std input
         3. Parsing this command
         4. Executing parsed commands
         5. Dealocating used memory
       */

      struct rlimit r;
      getrlimit(RLIMIT_FSIZE, &r);
      r.rlim_cur = 50;
      setrlimit(RLIMIT_FSIZE, &r);


      while(1){
        printf("a1");
        printprompt();
        printf("a2");
        if(readcmd(cmd, MAXCMD) == RESERROR) continue;
        printf("a3");
        res = parsecmd(cmd, MAXCMD, &cmds);
        printf("a4");
        // printparsedcmds(&cmds);
        printf("a5");
        executecmds(&cmds);
        printf("a6");
        dealocate(&cmds);
        printf("a7");
      }
     
      return 0;
    }
    /* -------------------------------------------------------------------------------------- */
     
    /* This function sets up the initial values of the fileds in the cmdlist structure  */
    void setupnewcommand(struct cmdlist* __cmd)
    {
      if(__cmd == NULL)
        return;
     
      __cmd->next = NULL;           /* in order to know where is the end of the list */
      __cmd->argv = NULL;           /* see realloc(3) */
      __cmd->conjuction = CONJUD;
      __cmd->argc = 0;
    }
    /* -------------------------------------------------------------------------------------- */
     
    /* This function adds the NULL pointer to the end of the argument list  */
    /* For more details see exec(3) */
    int setupparsedcommand(struct cmdlist* __cmd)
    {
      /* Checking id the argument is not NULL */
      if(__cmd == NULL){
        printf("Null pointer at setupparsedcommand.");
        return RESERROR;
      }
     
      __cmd->argc++;
      __cmd->argv = (char**)realloc(__cmd->argv, __cmd->argc*sizeof(char*));  /* Adding new pointer  */
      if(__cmd->argv == NULL)                                                 /* Checking is allocation was OK  */
        return RESERROR;
      __cmd->argv[__cmd->argc-1] = NULL;                                      /* Setting NULL poniter  */
     
      return RESSUCCESS;
    }
    /* -------------------------------------------------------------------------------------- */
     
    /* 2. Reading command from the std input */
    int readcmd(char* __buf, int __bufsize)
    {

         printf("b1");
      /* Reading command from the std input  */
      if(fgets(__buf, __bufsize, stdin) == NULL){
        printf("Error while reading -- try again!");
        return RESERROR;
      }
     
        printf("b2");
      /* If the std input buffer is not empty */
      /* In this case we did not read all the data from the buffer, 
         so the incomplete command should not be executed
         and that is why we ignore it */
      if(strchr(__buf, '\n') == NULL){
        while(1){
          char c = getchar();
          if(c == '\n')
    	break;
          else if((c == EOF) && (ferror(stdin)))
    	return RESERROR;
        }
        printf("Line is too long -- the command will be ignored.\nMaximal size is %d.", __bufsize-2);
        return RESERROR;
      }
      return RESSUCCESS;
    }
    /* -------------------------------------------------------------------------------------- */
     
    /* 3. Parsing this command */
    int parsecmd(char* __buf, int __bufsize, struct cmdlist* __head)
    {
      char* cmd = __buf;                  /* String that must be parsed  */
      char* word;                         /* String between white characters  */
      struct cmdlist* curr = __head;
      struct cmdlist * new_struct; 
	  
		
		
      /* Reading next word - read strtok(3)  */
      while((word = strtok(cmd, " \t\n")) != NULL){ 
		  
		  
		  
		if(!strcmp("&&", word) || !strcmp("||", word)){
			// printf("Operator found");
			
			new_struct = malloc(sizeof *new_struct);
			curr->next = new_struct;
		    if(setupparsedcommand(curr) == RESERROR){                               
        		printf("Error while setting up parsed command.");
        		return RESERROR;
      		}
			curr = new_struct;
			setupnewcommand(curr);
			if(!strcmp("&&", word)){
				curr->conjuction = CONJAND;
			}
			if(!strcmp("||", word)){
				curr->conjuction = CONJOR;
			}
			continue;
			
		}
		  
		  
		  
        curr->argc++;
        curr->argv = (char**)realloc(curr->argv, sizeof(char*)*curr->argc);   /* memory reallocation - needed for new argument  */
        if(curr->argv == NULL){
          printf("Error while allocating memory!");
          return RESERROR;
        }
        curr->argv[curr->argc-1] = word;                                      /* Storing new argument in the argument vector in our structure */
        cmd = NULL;
      }
     
      /* Setting up parsed command -- the NULL pointer at the end of the parameters list must added  */
      if(setupparsedcommand(curr) == RESERROR){                               
        printf("Error while setting up parsed command.");
        return RESERROR;
      }
      return RESSUCCESS;
    }
    /* -------------------------------------------------------------------------------------- */
     
    /* 4. Executing parsed commands */
    int executecmds(struct cmdlist* __head)
    {
      int f, e;
      struct cmdlist* curr = __head;
      int status;
	  int wait_ret;
	  int procres;
	  int flag = 0;
	
		
	  int cmp = strcmp("exit", curr->argv[0]);
	  if(cmp == 0){
	  	exit(RESERROR);
		return RESSUCCESS;
	  }
		
		
      while(curr != NULL){
		
		if(flag == 0){
		
        f = fork();
        e = errno;
     	
        if(f == 0){
          execvp(curr->argv[0], curr->argv);
          e = errno;
          printf("Error while executing: %s", strerror(e));
		  exit(RESSUCCESS);
        }
        if(f == -1){
          printf("Fork error: %s", strerror(e));
          return RESERROR;
        }
        
		wait_ret = wait(&status);
		if(wait_ret == -1){
			printf("Error while waiting for child process termination");
			exit(RESERROR);
		}
		if(WIFEXITED(status)){
			procres = 0;
		}else {
			procres = 1;
		}
		printf("Process exited: %d", status);
		}
		  
	    
		if(!procres){
			if(curr->next->conjuction == 1){
				printf("Conjuction OR break");
				flag = 1;
				curr = curr->next;
				continue;
			}
		}
		else{
			flag = 0;
		}
		
		  
		if(procres){
			if(curr->next->conjuction == 2){
				printf("Conjuction AND break");
				flag = 1;
				curr = curr->next;
				continue;
			}
		}else{
			flag = 0;
		}
	
		  
		curr = curr->next;
		 
      }
	
		
      return RESSUCCESS;
    }
    /* -------------------------------------------------------------------------------------- */

