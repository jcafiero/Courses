/*
 * my_char.c
 * 	Takes in a character and writes the character
 *
 *  Created on: Feb 7, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"
void my_char(char c){
	write(1, &c, 1);
}
