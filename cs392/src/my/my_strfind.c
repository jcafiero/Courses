/*
 * my_strfind.c
 *
 *  Takes in a string and a char to look for. Returns the position of the pointer to the
 *   	first char in the string that matches the char input. Returns NULL if the
 *   	input is not found/input string is null
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

char* my_strfind(char* str, char c) {
	int i;
	if (str == NULL)
		return NULL;
	for (i = 0; str[i] != '\0'; i++) {
		if (c == str[i]) {
			return &str[i];
		}
	}
	return NULL;
}
