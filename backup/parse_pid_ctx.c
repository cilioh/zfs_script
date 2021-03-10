#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>

#define DEVICE_FILENAME "/dev/mctxt"

int main(int argc, char *argv[])
{
	FILE *fp;
	FILE *fp2;
	char path[128];
	char path2[128];
	char *pid;
	char *ptr;
	char *ctxt;
	int n=0;
	char status[32] = "";

	int nctxt = 0;
	char str_nctxt[32];
	int *ptr_nctxt;
	
	int fd;
	char *p = NULL;
	char buff[32];

	//ptr_nctxt = (int*)malloc(sizeof(int));
	//printf("ptr_nctxt: %p\n", &ptr_nctxt);

	ssize_t i = 0;
	fd = open(DEVICE_FILENAME, O_RDWR|O_NDELAY);
	if(fd >= 0){
		p = (char *)mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
		if(p == MAP_FAILED){
			printf("failed mmap\n");
			close(fd);
			return 0;
		}
	}

	while(1){
		SLEEP:
		nctxt = 0;
		fp = popen("ps -ef | grep z_wr_iss", "r");
		if (fp == NULL) {
			printf("Failed to get z_wr_iss info\n");
			goto SLEEP;
			//exit(1);
		}
		while(fgets(path, sizeof(path), fp) != NULL){
			if(strstr(path, "grep") == NULL){
				ptr = path;
				n = 0;
				while(pid = strtok(ptr, " \t")){
					if(n==1){
						//printf("%s\n", pid);
						break;
					}
					ptr = NULL;
					n++;
				}
				strcpy(status, "cat /proc/");
				strcat(status, pid);
				strcat(status, "/status");
				//printf("%s\n", status);
				fp2 = popen(status, "r");
				if (fp2 == NULL) {
					printf("Failed to open pid status file\n");
					goto SLEEP;
					//exit(1);
				}
				while(fgets(path2, sizeof(path2), fp2) != NULL) {
					if(strstr(path2, "voluntary_ctxt_switches:") != NULL){
						ptr = path2;
						n = 0;
						while(ctxt = strtok(ptr, " \t")){
							if(n==1){
								ctxt[strlen(ctxt)-1] = '\0';
								nctxt += atoi(ctxt);
								//printf("%s\n", ctxt);
								break;
							}
							ptr = NULL;
							n++;
						}
						//printf("%s\n", path2);
					}
				}
				pclose(fp2);


			}
		}
		pclose(fp);

		sprintf(str_nctxt, "%d", nctxt);
		strcpy(p, str_nctxt);
		
		printf("total: %s\n", str_nctxt);
		//SLEEP:
	//		sleep(1);
	}

	munmap(p, 4096);
	close(fd);
	pclose(fp2);
	pclose(fp);

	return 0;
}
