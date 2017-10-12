/*
 * elem_at.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Returns a pointer to the elem at index n or the last node.
 *      Parse once.
 */

#include "list.h"

void* elem_at(struct s_node* head, int n) {
	struct s_node *node;
	if (head == NULL) {
		return NULL;
	}
	node = head;
	while (node->next != NULL &&  n > 0) {
		node = node->next;
		n--;
	}
	return node->elem;
}

