#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>

#include <sys/types.h>
#include <sys/stat.h>
/* ------------------------------------------------------------- */

#include "fifo.h"
/* ------------------------------------------------------------- */

int main(void)
{
  struct message msg;
  char* fifosrvbasename = "srvfifoqueue";
  char fifosrvname[FIFO_NAME_BUF_SIZE];
  char fifocntname[FIFO_NAME_BUF_SIZE];
  int fdsrv,
    fdcnt,
    bread,
    bwrite;

  int fdwrite;
  int flags;

  printf("Server started...\n");
  setbuf(stdout, NULL);

  /* Creating server fifo queue */
  make_srv_fifo_queue_name(fifosrvname, fifosrvbasename, FIFO_NAME_BUF_SIZE);
  printf("Creating server fifo queue \'%s\'...", fifosrvname);
  if((mkfifo(fifosrvname, PERM_FILE) == -1) && (errno != EEXIST))
    {
      printf("FAIL!\nError: %s\n", strerror(errno));
      return 0;
    }

  /* Opening fifo */
  printf("OK\nOpening server fifo queue \'%s\' for reading...\n", fifosrvname);

 
  printf("Before read opening\n"); 
  // setting nonblock flag 
  fdsrv = open(fifosrvname, O_RDONLY | O_NONBLOCK);
  printf("After read opening\n");

  if(fdsrv == -1)
    {
      printf("FAIL!\nError: \'%s\'\n", strerror(errno));
      return 0;
    }
  printf("OK\n");

  flags = fcntl(fdsrv, F_GETFL);
  flags &= ~O_NONBLOCK;
  fcntl(fdsrv, F_SETFL, flags);

  printf("Opening for writing");
  fdwrite = open(fifosrvname, O_WRONLY);

  while(1)
    {
      /* Reading from queue */
      printf("Waiting for data...");
      bread = read(fdsrv, &msg, sizeof(msg));
      if(bread == -1)
	{
	  printf("FAIL!\nError: %s\n", strerror(errno));
	  break;
	}
      printf("OK\n");

      printf("Message from client [%d]: %s\n", msg.pid, msg.data);
      printf("Your responce: ");
      stdin_readall(msg.data, MESSAGE_BUF_SIZE);

      /* Creating client fifo name  */
      make_cnt_fifo_queue_name(fifocntname, msg.pid, FIFO_NAME_BUF_SIZE); 

      /* Opening client fifo for writing  */
      printf("Opening client fifo \'%s\' for writing...", fifocntname);
      fdcnt = open(fifocntname, O_WRONLY);
      if(fdcnt == -1)
	{
	  printf("FAIL!\nError: %s\n", strerror(errno));
	  break;
	}

      /* Sending responce */
      printf("OK\nWritting responce to client [%ld]...", (long)msg.pid);
      bwrite = write(fdcnt, &msg, sizeof(msg));
      if(bwrite == -1)
	{
	  printf("FAIL!\nError: %s\n", strerror(errno));
	  break;
	}
      printf("OK\n");
      close(fdcnt);
    }
  
  
  /* Cleaning up */
  close(fdsrv);
  unlink(fifosrvname);
  
  return 0;
}
