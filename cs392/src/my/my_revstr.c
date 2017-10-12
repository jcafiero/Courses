/*
 * my_revstr.c
 *	Takes in a string and reverses the string without creating a new variable
 *
 *  Created on: Feb 7, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_revstr(char* str) {

	char temp;
	int i;
	int len = my_strlen(str);
	int end;
	int half = len/2;

	if (str == NULL)
		return -1;
	for(i = 0; i < half; i++) {
		end = len - 1 - i;
		temp = str[i];
		str[i] = str[end];
		str[end] = temp;
	}
	my_str(str);
	return len;
}
