/*
 * my_strindex.c
 *	Takes a string and character as input and returns the
 *		first index where the character is found in the string
 *
 *
 *  Created on: Feb 25, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_strindex(char* c, char x) {
	int i = 0;

	if (c != NULL){
		while(c[i] != '\0') {
			if(c[i] == x) {
				return i;
			}
			i++;
		}
	}

	return -1;
}
