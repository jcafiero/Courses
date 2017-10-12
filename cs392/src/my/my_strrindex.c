/*
 * my_strrindex.c
 * 	Takes in a string and a character and returns the index of the last occurrence
 * 		of the specified character in the given string
 *
 *
 *  Created on: Feb 25, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_strrindex(char* c, char x) {
	int i = 0;
	int z = -1;

	if (c != NULL) {
		while (c[i] != '\0'){
			if (c[i] == x) {
				z = i;
			}
			i++;
		}
	}

	return z;

}

