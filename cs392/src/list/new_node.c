/*
 * new_node.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Allocates and returns a node with the given element. You may
 * 		create nodes with NULL element.
 */

#include "list.h"

struct s_node* new_node(void* elem) {
	struct s_node *n;
	n = (struct s_node*)malloc(sizeof(struct s_node));
	n->elem = elem;
    n->next = NULL;
    n->prev = NULL;
	return n;
}
