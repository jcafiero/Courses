/*
 * add_elem.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Creates a new node with elem and adds it to head (again, assume head is actually the head). DO NOT add a NULL elem to the list
 *		 DOES NOT PARSE THE LIST
 *
 */

#include "list.h"

void add_elem(void* elem, struct s_node** head) {
	if (elem != NULL && head != NULL) {
		add_node(new_node(elem), head);
	}
}
