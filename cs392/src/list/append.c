/*
 * append.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Adds a node to the end of a list. DO NOT add a NULL node pointer or
 *		a node with a NULL elem.
 *		Parse the list once
 */

#include "list.h"

void append(struct s_node* node, struct s_node** head) {
	if(node != NULL && node->elem != NULL && head != NULL){
		struct s_node* temp;
		if (*head == NULL) {
			*head = node;
			return;
		}
		temp = *head;
		while (temp->next != NULL){
			temp = temp->next;
		}
		temp->next = node;
		node->prev = temp;
	}
}
