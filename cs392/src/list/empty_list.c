/*
 * empty_list.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Frees all the nodes in the list.
 *		CHALLENGE: Write in two lines (allowed and encouraged to use other methods in
 *		this assignment)
 */

#include "list.h"

void empty_list(struct s_node** head){
	if (head != NULL) {
		while (*head != NULL) {
			remove_node(head);
		}
	}
}
