/*
 * my_strnconcat.c
 * Takes in two strings and an integer and returns a new string with the entire first string
 * 		and the first n-characters of the second concatenated.
 *
 *  Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */


#include "my.h"

char* my_strnconcat(char* a, char* b, int n) {
	int i, j;
	int len1 = my_strlen(a);
	int len2 = my_strlen(b);
	char *resstr;
	if (n < 0){
		n = 0;
	}
	if (a != NULL && b != NULL){
		if (len2 < n)
			resstr = (char*)malloc(len1 + len2 + 1);
		else
			resstr = (char*)malloc(len1 + n);
		for(i = 0; i < len1; i++)
			resstr[i] = a[i];
		if (len2 < n)
			for (i = 0; i <= len2; i++)
				resstr[i+len1] = b[i];
		else
			for (i = 0; i < n; i++)
				resstr[i+len1] = b[i];
	}
	else if (a == NULL && b != NULL){
		if (len2 < n){
			resstr = (char*)malloc(len2 + 1);
			for(j = 0; j <= len2; j++)
				resstr[j] = b[j];
		}
		else {
			resstr = (char*)malloc(n);
			for(j = 0; j < n; j++)
				resstr[j] = b[j];
		}
	}
	else if (a != NULL && b == NULL){
		resstr = (char*)malloc(len1 + 1);
		for(i = 0; i < len1; i++)
			resstr[i] = a[i];
	}
	else
		resstr = NULL;
	return resstr;


}


