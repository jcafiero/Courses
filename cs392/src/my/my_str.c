/*
 * my_str.c
 * 	Takes in a string and prints a null terminated C string to the console
 *
 *  Created on: Feb 7, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

void my_str(char* str){
	int i = 0;
	if (str != NULL) {
		for(i = 0; str[i] != '\0'; i++){
			my_char(str[i]);
		}
	}
}
