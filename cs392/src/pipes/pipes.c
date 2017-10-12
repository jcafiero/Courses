/*
 * pipesex.c
 *
 *  Created on: Apr 18, 2017
 *      Author: jcafiero
 *      Demo on pipes using forks
 */

#include <stdio.h>
#include "my.h"
#include <sys/wait.h>


int main(int argc, char* argv[]) {
	int maxBufferSize = 150;
	int maxGChildSize = 100;
	pid_t pid;
	int p1[2];
	int p2[2];
	char *str;

	if (argc < 2) {
		perror("usage: arg1 [arg2] [arg3]...\n"), exit(1);
	}
	else {
		if (pipe(p1) < 0) {
			perror("Failed on creating p1"), exit(1);
		}
		if ((pid=fork()) < 0) {
			perror("Error creating fork"), exit(1);
		}
		else if (pid > 0) {
			if (close(p1[0])) {
				perror("Failed to close p1"), exit(1);
			}
			char* str = my_vect2str(&argv[1]);
			if (my_strlen(str) < 0){
				free(str);
				str = "NULL";
			}
			int status;
			my_str("Parent: ");
			my_str(str);
			my_str("\n");
			close(p1[0]);
			if (write(p1[1], str, my_strlen(str) + 1) < 0){
				perror("Error writing on p1"), exit(1);
			}
			wait(&status);

		}
		else {
			int n;
			if (close(p1[1])) {
				perror("Failed to close p1");
			}
			if (pipe(p2)) {
				perror("Failed to create p2");
			}
			if ((pid = fork()) < 0) {
				perror("Error spawning child");
			}
			else if (pid > 0) {
				if (close(p2[0])){
					perror("Error closing p2");
				}
				n = read(p1[0], str, maxBufferSize);
				int status;
				if (n < 0){
					perror("Error: failed to read from p1");
				}
				my_str("Child: ");
				my_str(str);
				my_str("\n");

				if (write(p2[1], str, my_strlen(str) + 1) < 0){
					perror("Error writing on p2"), exit(1);
				}

				wait(&status);

			}
			else {
				if (close(p2[1])){
					perror("Error closing p2[1]");
				}
				n = read(p2[0], str, maxBufferSize);
				if (n < 0){
					perror("Error reading from p2"), exit(1);
				}

				my_str("Grandchild");
				my_str(str);
				my_str("\n");
			}
		}
	}




	return 0;
}
