/*
 * remove_node_at.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Removes the node at index n or the last node.
 *		Parse once
 */

#include "list.h"

 void* remove_node_at(struct s_node** head, int n) {
	 struct s_node *node;
	 void *element;
	 if (head == NULL || *head == NULL) {
		 return NULL;
	 }
	 if (n <= 0) {
		 return remove_node(head);
	 }
     node = *head;
	 while (n > 0) {
         if (node->next == NULL) {
             break;
         }
         node = node->next;
         n--;
     }
     if (n > 0 || node->next == NULL) {//if n is longer than the node, remove the last elem from the O.G. head
         return remove_last(head);
     }
     
     else {
		 
		 element = node->elem;
         node->prev->next = node->next;
         node->next->prev = node->prev;
		 free(node);
		 return element;

	 }
 }

