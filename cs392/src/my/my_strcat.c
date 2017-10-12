/*
 * my_strcat.c
 *	Takes in two strings as input and returns a concatenation of the first string with
 *		the second, if enough memory is allocated
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strcat(char* dst, char* src) {
	int len1 = my_strlen(dst);
	int pos = 0;

	if (dst == NULL){
		return NULL;
	}
	if (src == NULL){
		return dst;
	}
	if (dst == NULL && src == NULL){
		return NULL;
	}
	while (src[pos] != '\0') {
		dst[len1+pos] = src[pos];
		pos++;
	}
	dst[len1+pos] = '\0';
	return dst;
}
