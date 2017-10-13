/*
 * pipesex.c
 *
 *  Created on: Apr 18, 2017
 *      Author: jcafiero
 *      Demo on pipes using forks
 */
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>


int main(int argc, char* argv[]) {
	int maxBufferSize = 150;
	pid_t pid;
	int p[2];

	if (pipe(p) < 0) {
		perror("Failed on creating pipe"), exit(1);
	}

	if ((pid=fork()) < 0) {
		perror("Error creating fork"), exit(1);
	} else if (pid == 0) {
		/*child*/
		printf("Hello from child\n");
		char buffer[maxBufferSize];
		int numbytes;
		close(p[1]);
		if ((numbytes = read(p[0], buffer, maxBufferSize)) < 0){
			perror("Error reading from pipe"), exit(1);
		}
		printf("Child: %s\n", buffer);

		exit(5);
	} else {
		/*adult*/
		int status;
		char* str = argv[1];
		printf("parent: %s\n", str);
		close(p[0]);
		if (write(p[1], str, strlen(str) + 1) < 0){
			perror("Error writing on pipe"), exit(1);
		}
		close(p[1]);

		wait(&status);//waits for child to exit before proceeding
		printf("hello from parent! Child exited with code %i\n", WEXITSTATUS(status));
	}
	return 0;
}
