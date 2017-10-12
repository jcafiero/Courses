/*
 * my_strcmp.c
 *
 *  Takes in two strings and returns 0 if the two strings are equal. Returns -1 or 1 if
 *  	they are not equal
 *
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

#include "my.h"

int my_strcmp(char* a, char* b) {
	int i = 0;
		if (a == NULL && b == NULL){
			return 0;
		}
		else if (a == NULL){
			return -1;
		}
		else if (b == NULL){
			return 1;
		}
		int len_a = my_strlen(a);
		int len_b = my_strlen(b);
		int n;
		if (len_a > len_b)
			n = len_a;
		else
			n = len_b;


		while (i < n){
			if ((a[i] == '\0') || (b[i] == '\0')) {
				if ((a[i] == '\0') && (b[i] == '\0')) {
					return 0;
				}
				if (a[i] == '\0'){
					return -1;
				}
				if (b[i] == '\0'){
					return 1;
				}
			}
			if (a[i] > b[i])
				return 1;
			if (a[i] < b[i])
				return -1;
			i++;
		}
		return 0;


}
