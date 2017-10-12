/*
 * my_strdup.c
 *	Takes in a string, allocates new memory, copies the string into that memory and returns
 *		a pointer to the new string.
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strdup(char* str) {
	int len = my_strlen(str);
	char* str_mem = (char*)malloc(len + 1);
	int i;
	if (str == NULL) {
		return NULL;
	}
	for (i = 0; i < len; i++) {
		str_mem[i] = str[i];
	}
	return str_mem;
}
