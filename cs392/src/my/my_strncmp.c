/*
 * my_strncmp.c
 *
 *  Takes in two strings and an integer n, compares the first string to the first n numbers
 *  	of the second string and returns 0 if they are the same, 1 or -1 if they are different
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_strncmp(char* a, char* b, int n) {
	int i = 0;
	if ((a == NULL && b == NULL) || (n <= 0)){
		return 0;
	}
	else if (a == NULL){
		return -1;
	}
	else if (b == NULL){
		return 1;
	}

	while (i < n){
		if ((a[i] == '\0') || (b[i] == '\0')) {
			if ((a[i] == '\0') && (b[i] == '\0')) {
				return 0;
			}
			if (a[i] == '\0'){
				return -1;
			}
			if (b[i] == '\0'){
				return 1;
			}
		}
		if (a[i] > b[i])
			return 1;
		if (a[i] < b[i])
			return -1;
		i++;
	}
	return 0;

}

