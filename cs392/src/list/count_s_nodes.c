/*
 * count_s_nodes.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Returns the value the length of the list
 *		 Parse Once.
 */

#include "list.h"

int count_s_nodes(struct s_node* head) {
	int n = 0;
	struct s_node* temp;
	if (head == NULL) {
		return 0;
	}
	temp = head;
	while (temp != NULL){
		n++;
		temp = temp->next;
	}
	return n;
}
