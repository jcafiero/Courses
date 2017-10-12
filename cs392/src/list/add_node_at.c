/*
 * add_node_at.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Adds a node at index n of a list or at the end of the list if n is
 *		too large.
 *		Parse the list once
 */

#include "list.h"

void add_node_at(struct s_node* node, struct s_node** head, int n){
	struct s_node *temp;
	if (node != NULL && node->elem != NULL && head != NULL) {
		if (*head == NULL) {
			*head = node;
			return;
		}

		if (n <= 0){
			add_node(node, head);
            return;
		}
		else {
			temp = *head;
			while (n > 0) {
				if (temp->next == NULL) {
					break;
				}
				temp = temp->next;
				n--;
			}
			if (n > 0) {
				append(node, head);
			}
			else {
				temp->prev->next = node;
				node->prev = temp->prev;
				temp->prev = node;
				node->next = temp;
			}

		}
	}
}
