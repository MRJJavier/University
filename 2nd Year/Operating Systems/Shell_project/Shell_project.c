
/**
UNIX Shell Project

Sistemas Operativos
Grados I. Informatica, Computadores & Software
Dept. Arquitectura de Computadores - UMA

Some code adapted from "Fundamentos de Sistemas Operativos", Silberschatz et al.

To compile and run the program:
   $ gcc Shell_project.c job_control.c -o Shell
   $ ./Shell          
	(then type ^D to exit program)

**/

#include "job_control.h"   // remember to compile with module job_control.c 
#define MAX_LINE 256 /* 256 chars per line, per command, should be enough. */

job * my_job_list;
void sigchld_manejador(int in){
	block_SIGCHLD();
	job * j;
	int stat;
	int wait;
	int inf;
	enum status stat_res;
	for(int i=list_size(my_job_list); 0<i;i--){
		j= get_item_bypos(my_job_list,i);
		wait = waitpid((pid_t)j->pgid,&stat,WUNTRACED | WNOHANG);
		stat_res=analyze_status(stat,&inf);

		if((stat_res==EXITED || (stat_res==SIGNALED && (SIGTERM==inf || SIGKILL==inf))) && wait == j->pgid){
			delete_job(my_job_list,j);
		}
		if(stat_res==SUSPENDED && wait == j->pgid){
			j->state=STOPPED;
		}
	}
	unblock_SIGCHLD();
}

void foreground_manejador(int pos){
	enum status status_res;
	int status,info;
	block_SIGCHLD();
	job * j= get_item_bypos(my_job_list,pos);
	int pgid=j->pgid;
	char * command = malloc(sizeof(j->command));
	strcpy(command,j->command);
	enum job_state state=j->state;
	unblock_SIGCHLD();
	set_terminal(pgid);
	if(state==STOPPED){
		killpg(pgid,SIGCONT);
	}
	waitpid((pid_t)pgid,&status,WUNTRACED);
	set_terminal(getpid());
	status_res= analyze_status(status,&info);
	if(status_res!=SUSPENDED){
		block_SIGCHLD();
		delete_job(my_job_list,j);
		unblock_SIGCHLD();
		printf("Foreground pid: %d, command: %s, %s, info: %d\n",pgid,command,status_strings[status_res],info);
	}else{
		block_SIGCHLD();
		j->state=STOPPED;
		unblock_SIGCHLD();
		printf("\nForeground job stopped pid: %d, command: %s, %s, info: %d\n",pgid,command,status_strings[status_res],info);
	
	}
	free(command);
}

void background_manejador(int pos){
	block_SIGCHLD();
	job * j= get_item_bypos(my_job_list,pos);
	if(j->state==STOPPED){
		j->state=BACKGROUND;
		killpg(j->pgid,SIGCONT);
		printf("Background job running... pid:%d, command:%s\n",j->pgid,j->command);
	}else{
		printf("This job is already running in background. pid:%d, command:%s,%s\n",j->pgid,j->command,state_strings[2]);
	}
	unblock_SIGCHLD();
}



// -----------------------------------------------------------------------
//                            MAIN          
// -----------------------------------------------------------------------
int main(void)
{
	char inputBuffer[MAX_LINE]; /* buffer to hold the command entered */
	int background;             /* equals 1 if a command is followed by '&' */
	char *args[MAX_LINE/2];  /* command line (of 256) has max of 128 arguments */
	// probably useful variables:
	int pid_fork, pid_wait; /* pid for created and waited process */
	int status;             /* status returned by wait */
	enum status status_res; /* status processed by analyze_status() */
	int info;		/* info processed by analyze_status() */
	

	my_job_list = new_list("Jobs");

	signal(SIGCHLD,sigchld_manejador);	
	ignore_terminal_signals();
	while (1)   /* Program terminates normally inside get_command() after ^D is typed*/
	{   	
		
		printf("COMMAND->");
		fflush(stdout);
		get_command(inputBuffer, MAX_LINE, args, &background);  /* get next command */
		
		if(args[0]==NULL) continue;   // if empty command
		if(!strcmp(args[0],"cd")){
			if(chdir(args[1])==-1){
				if(args[1]!=NULL){
				printf("No es posible cambiar al directorio %s .\n",args[1]);
				}
				
			}
		}else if(!strcmp(args[0],"jobs")){
			if(!empty_list(my_job_list)){
				print_job_list(my_job_list);
			}else{
				printf("La lista de trabajos esta vacia\n");
			}
		}else if(!strcmp(args[0],"fg")){
			if(!empty_list(my_job_list)){
				if(args[1]==NULL){
					foreground_manejador(1);		
				}else{
					int fg = atoi(args[1]);
					if(fg!=0 && fg<=list_size(my_job_list)){
						foreground_manejador(fg);
					}else{
						printf("Argumento no válido\n");
					}
				}
			}else{
				printf("La lista de trabajos esta vacia\n");
			}
		}else if(!strcmp(args[0],"bg")){
			if(!empty_list(my_job_list)){
				if(args[1]==NULL){
					background_manejador(1);		
				}else{
					int bg = atoi(args[1]);
					if(bg!=0 && bg<=list_size(my_job_list)){
						background_manejador(bg);
					}else{
						printf("Argumento no válido\n");
					}
				}
			}else{
				printf("La lista de trabajos esta vacia\n");
			}
		}else if(!strcmp(args[0],"logout")){
			printf("Bye. See you next time ! :)\n");
			exit(0);
		}else{
			pid_fork = fork();
			if(pid_fork==0){
				new_process_group(getpid());
				if(background==0){
					set_terminal(getpid());
				}
				restore_terminal_signals();
				execvp(args[0],args);
				printf("Error, command not found: %s \n",args[0]);
				exit(-1);
			}else{
				new_process_group(getpid());
				if(background){
					block_SIGCHLD();
					add_job(my_job_list,new_job(pid_fork,args[0],background));
					unblock_SIGCHLD();
					printf("Background job running... pid: %d, command: %s\n",pid_fork,args[0]);
				}else{
					waitpid((pid_t)pid_fork,&status,WUNTRACED);
					set_terminal(getpid());
					status_res= analyze_status(status,&info);
					if(status_res!=SUSPENDED){
						printf("Foreground pid: %d, command: %s, %s, info: %d\n",pid_fork,args[0],status_strings[status_res],info);
					}else{
						block_SIGCHLD();
						add_job(my_job_list,new_job(pid_fork,args[0],STOPPED));
						unblock_SIGCHLD();
						printf("\nAdded to Jobs' list pid: %d, command: %s, %s, info: %d\n",pid_fork,args[0],status_strings[status_res],info);
					}
				}
			}
		}
		continue;
	} // end while
}
