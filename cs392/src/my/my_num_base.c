/*
 * my_num_base.c
 *	Takes in an integer and a string and returns a number using the length of
 *		the string as the base and the contents of the string as the alphabet
 *
 *
 *  Created on: Feb 25, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */
#include "my.h"

int my_power(int x, int y) {
	if (y == 0) {
		return 1;
	}
	return x * my_power(x, y-1);
}


void my_num_base(int x, char* c){
	if (c == NULL) {
		my_str("Error: char* is NULL or empty\n");
		return;
	}
	int absx = 0;
	if (x < 0){
		my_char('-');
		absx = x;
	}
	if (x > 0){
		absx = x * -1;
	}
	if (my_strlen(c) == 1) {
		while (absx < 0){
			my_char(c[0]);
			absx++;
		}
	}

	if (my_strlen(c) > 1) {
		int len = my_strlen(c);
		int temp_negx = absx;
		int digits = 1;
/*		int y;

		for (y = 0; temp_negx/len != 0; y++) {
			digits += 1;
			temp_negx = temp_negx/len;
		}*/
		while (temp_negx/len != 0) {
			digits += 1;
			temp_negx = temp_negx/len;
		}

		while(digits >= 0) {

			my_char(c[((absx/(my_power(len, digits-1)))%len)*-1]);
			digits--;
		}


	}

}

