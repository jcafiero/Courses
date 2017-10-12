/*
 * my_atoi.c
 *	Takes in a string and returns the integer represented by the ascii string
 *
 *
 *   Created on: Feb 28, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */


#include "my.h"


int my_power2(int x, int y) {
	if (y == 0) {
		return 1;
	}
	return x * my_power2(x, y-1);
}

int my_atoi(char *c)
{
	int i = 0;
	int numFound = 0;
	int negCount = 0;
	int numStart = -1, numStop;
	int n = 0;

	if (c == NULL) return 0;

	while (c[i] != '\0' && (numFound == 0 || (c[i] > 47 && c[i] < 58)))
	{
		if (c[i] == '-') negCount++;
		if (c[i] >= '0' && c[i] <= '9' && numFound == 0)
		{
			numFound = 1;
			numStart = i;
		}

		i++;
	}

	numStop = i - 1;
	i = 0;
	if (numStart == -1) {return 0;}
	else {
		while (numStop >= numStart)
		{
			n += (c[numStop] - 48) * my_power2(10, i);
			i++;
			numStop--;
		}
	}

	if (negCount % 2 == 0) return n;
	else return n * -1;
}




