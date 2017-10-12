/*
 * add_node.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Inserts a node at the start of the list You can assume that the provided pointer to
  	  	  head is the actual head of the list, and there are no elements before it.
 	 	 ****DO NOT add a node with a NULL elem or with a NULL head.****
  	  	  Make sure to check that head!= NULL, and that *head !=NULL
  	  	  DOES NOT PARSE THE LIST
 */

#include "list.h"

void add_node(struct s_node* node, struct s_node** head) {
	if (head != NULL && node != NULL){
		if (node->elem != NULL)
		{
            if (*head == NULL) {
                *head = node;
                return;
            }
            if ((*head)->prev != NULL) {
                node->prev = (*head)->prev;
                node->next = *head;
                (*head)->prev->next = node;
                (*head)->prev = node;
            }
            else {
                node->next = *head;
                node->prev = (*head)->prev;
                (*head)->prev = node;
                *head = node;
            }
			
		}
	}
    else {
        
    }
}
