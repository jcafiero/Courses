/*
 * my_int.c
 *
 *  Created on: Feb 21, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"
void my_int(int i){

	unsigned int n;
	if (i == 0){
		/*if it's zero just print zero. like a base case or something*/
		my_char('0');
		return;
	}

	if (i < 0){
		/*Do something to multiply by -1. like print my_char '-' or something*/
		n = i * -1;
		my_char('-');
	}
	else {
		n = i;
	}
	unsigned int temp = 1;

	while (temp <= n/10){
		temp = temp * 10;
	}
	/*DID NOT NEED TO USE AN UNSIGNED INTEGER. COULD BE TEMP != 0 SOLUTION. */
	while (temp > 0){
		my_char('0' + n/temp);
		n = n % temp;
		temp = temp / 10;
	}







}
