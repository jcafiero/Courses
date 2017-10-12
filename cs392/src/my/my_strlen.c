/*
 * my_strlen.c
 * 	Takes in a string as input and returns the length of the string
 * 		(not including null terminator)
 *
 *  Created on: Feb 7, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_strlen(char* str){
	int length = 0;
	if(str == NULL){
		return -1;
	}
	while(str[length] != '\0'){
		length++;
	}
	return length;
}
