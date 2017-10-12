/*
 * my_strcpy.c
 *	Takes in two strings, copies the src string into the dst string and
 *	returns the dst string value
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strcpy(char* dst, char* src) {
	if (dst == NULL || src == NULL){
		return dst;
	}
	if (src[0] == '\0'){
		dst[0] = '\0';
		return dst;
	}

	int i = 0;
	while(src[i] != '\0') {
		dst[i] = src[i];
		i++;
	}
	dst[i] = '\0';
	return dst;
}
