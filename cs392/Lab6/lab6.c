/*
 * lab6.c
 *
 *  Created on: Mar 21, 2017
 *      Author: jcafiero
 */


/*
 * Put includes here:
 */

#include "stdio.h"
#include "stdlib.h"
#include "string.h"

/*
 * Put the struct you create in part 3 here:
 */
  typedef struct position {
	  int x;
	  int y;
	  char id;
  }Position;




int main(){

  /*
   * This lab is meant to serve as a review of concepts learned so far
   * As you go, you will need to put several includes at the top of this file
   * When you are done, call over a TA for +3 bonus points.
   * We will ask you a series of questions to make sure you actually understand what you did
   *
   */


  /*****************************************************************
   * Part 1: Makefile
   *****************************************************************
   *
   * Create a make file with targets all, clean, fclean, and re.
   * all should make Lab6.c
   * clean should remove all .o files
   * fclean should clean and remove all executables
   * re should fclean and all.
   *
   * This is NOT a library. If you copy your Makefile from the String Library,
   * you will need to make many changes.
   *
   * DO NOT have any useless global variables in your makefile. We will check for this when we grade
   *
   * Use -Werror, and -std=c99 as your CFLAGS.
   *
   *
   ******************************************************************
   * Part 2: Strings
   ******************************************************************
   *
   * Create a string called str that has a length of 6
   *
   * 1 line of code
   * YOUR CODE HERE:
   */
	char* str = (char*) malloc(6 * sizeof(char));

  /*
   * Make ONLY the first character of str equal 'b'
   *
   * One line of code
   * YOUR CODE HERE:
   */
	str[0] = 'b';

   /*
   * Make ONLY the second character of str equal 'a'
   *
   * One line of code
   * YOUR CODE HERE:
   */
	str[1] = 'a';

  /*
   * Put a null terminator as the third character of str
   *
   * One line of code
   * YOUR CODE HERE [YCH]:
   */
	str[2] = '\0';

  /*
   * Given the following string:
   */
  char* str2 = "abcdefghijklbebaedaebdob";

  /*
   * Calculate the amount of 'b's in str2 using a for loop
   *
   * Max 8 lines of code (counting brackets as own line)
   * YCH:
   */
  int countBs = 0;
  for (int i = 0; i < strlen(str2); i++)
  {
	  if(str2[i] == 'b')
	  {
		  countBs += 1;
	  }
  }

  /*
   * Calculate the amount of 'b's in str2 using a while loop and a pointer
   *
   * Max 11 lines of code (counting brackets as own line)
   * YCH:
   */
  int countBsW = 0;
  int j = 0;
  while (j < strlen(str2))
  {
	  if (str2[j] == 'b')
	  {
		  countBsW++;
	  }
	  j++;
  }



  /*
   * Create a pointer to str called strptr
   * (this should end up being a double pointer)
   * DO NOT USE &. Use Malloc
   * 2 lines of code
   *
   * YCH:
   */
  char** strptr = (char**) malloc(sizeof(str)*1);
  *strptr = str;


  /* Note the output of the following lines */
  printf("str = %s\n", str);
  printf("*str = %c\n", *str);

  /*Now, lets look at the output of these:*/
  printf("strptr=%p\n", (void *) strptr); //What does the output of this represent?
  printf("*strptr=%s\n", *strptr);
  printf("**strptr=%c\n", **strptr);


  /*
   * Now, use what you know, and make an integer array called intarr of 5 integers
   *
   * YCH:
   */
  int* intarr = (int*)malloc(5 * sizeof(int));

  /*
   * Populate the array with values 0-3, and make the last element a -1.
   * Use a for loop for the 0-3 values
   *
   *YCH:
   */
  for(int i = 0; i < 5; i++){
	  intarr[i] = i;
	  if (i == 4){
		  intarr[i] = -1;
	  }
  }


  /***************************************************************
   * Part 3: Structs
   ***************************************************************
   *
   * Create a struct called position, that hold's an objects x and y position, as well as an ID.
   * The position struct should have an x field and a y field (both are integers)
   * and an ID field that is a string
   *
   * Put your struct at the top of the code under the appropriate heading
   */


  /*
   * Create a pointer to your struct, called positionPtr (this involves malloc)
   *
   * YCH:
   */
  struct position *positionPtr;
  positionPtr = (Position*)malloc(2*sizeof(Position));


  /*
   * Set the x value of of the positionPtr to be -2, and set the y value of the positionPtr to be 3
   * Also set the ID field to be str2
   *
   * YCH:
   */
	positionPtr->x = -2;
	positionPtr->y = 3;
	positionPtr->id = *str2;

  /******************************************************************
   * Part 4: Cleaning Up Once we are Done
   ******************************************************************
   *
   * Malloc reserves space on the heap for variables that we malloc.
   * C has no garbage collection, so we need to free up that space.
   * We do so by calling free() on the pointer we malloc'ed
   *
   * I.E. char* mystr = (char*)malloc(sizeof(char)*6);
   *      free(mystr);
   *
   * This tells the memory manager that we no longer need the data located at the mystr pointer address
   * and that we can reuse that data in other parts of our code.
   *
   * If we don't make calls to free, we will end up with memory leaks.
   *
   * Note that the following will cause memory errors, so always avoid:
   * 1) Freeing a pointer twice. I.E. free(myptr); free(myptr);
   * 2) Freeing a variable never malloc'ed
   *   I.E. int i = 1; free(i);
            char* str; free(str);
   * 3) Using a variable once it is freed
   *   I.E. char* str = (char*)malloc(sizeof(char)*6); free(str); str[3] = 'c';
   *
   */

  /*
   *  Now, clean up, and free everything that should be freed:
   *
   * YCH:
   */
	free(str);
	free(strptr);
	free(intarr);
	free(positionPtr);



  /*And finally, */
  return 0;

}
