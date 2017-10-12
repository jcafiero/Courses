/*
 * my_strconcat.c
 * Takes in two strings and allocates memory for and returns a new string with strings a &
 * 	b concatenated together
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strconcat(char* a, char* b) {
	int i, j;
	int len1 = my_strlen(a);
	int len2 = my_strlen(b);

	char* str_concat = (char*)malloc(len1 + len2 + 1);

	if (a == NULL && b == NULL)
		return NULL;
	if (b == NULL)
		return a;
	if (a == NULL) {
		str_concat = b;
		return str_concat;
	}

	for (i = 0; i < len1; i++) {
		str_concat[i] = a[i];
	}
	for (j = 0; j < len2; i++, j++) {
		str_concat[i] = b[j];
	}
	str_concat[i] = '\0';
	return str_concat;

}
