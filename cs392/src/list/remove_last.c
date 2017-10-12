/*
 * remove_last.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Removes the last node from the list.
 *		 Parse Once.
 */

#include "list.h"

void* remove_last(struct s_node **node) {
	void *element;
	struct s_node *temp;
	if (node == NULL || *node == NULL) {
		return NULL;
	}
	temp = *node;
    if (temp->next == NULL) {
        if (temp->prev == NULL) {
            return remove_node(node);
        }
        else {
            element = temp->elem;
            temp->prev->next = NULL;
            temp->prev = NULL;
            free(temp);
            return element;
        }
    }
    else {
        while (temp->next != NULL) {
            temp = temp->next;
        }
        element = temp->elem;
        temp->prev->next = NULL;
        free(temp);
        return element;
    }
    
	
}


