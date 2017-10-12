/*
 * my_strncpy.c
 * 	Takes in two strings and an integer n, copies the first n characters from the src
 * 		string into the dst string and returns the dst string
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strncpy(char* dst, char* src, int n) {

	int len2 = my_strlen(src);

	if (dst == NULL || src == NULL) {
		return dst;
	}
	if (n > len2) {
		n = len2;
	}

	int i = 0;
	while(src[i] != '\0' && i < n) {
		dst[i] = src[i];
		i++;
	}
	dst[i] = '\0';
	return dst;
}
