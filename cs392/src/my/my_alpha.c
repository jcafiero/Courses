/*
 * my_alpha.c
 * 	Prints all the letters from a to z in uppercase when function is ran
 *
 *  Created on: Feb 7, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

void my_alpha(){
	int i;
	for(i = 0x41; i < 0x54; i++){
		my_char(i);
	}
}
