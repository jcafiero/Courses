/*
 * remove_node.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Removes the given node from the list. Returns elem and frees the
 *		 node from memory.
 *		 DOES NOT PARSE THE LIST!!!!!!!!!!!!!!!
 */

#include "list.h"

void* remove_node(struct s_node** node){
	struct s_node *temp;
	void *element;
    if (node == NULL || *node == NULL) {
        return NULL;
    }
	if (node != NULL || *node != NULL) {
        if ((*node)->prev != NULL) {
            temp = *node;
            element = temp->elem;
            temp->prev->next = temp->next;
            if (temp->next != NULL) {
                element = temp->elem;
                temp->prev->next = temp->next;
                temp->next->prev = temp->prev;
                *node = temp->next;
                free(temp);
                return element;
            }
            else {
                element = temp->elem;
                temp->prev->next = NULL;
                *node = temp->next;
                free(temp);
                return element;
            }
        }
        else {
            temp = *node;
            *node = temp->next;
            element = temp->elem;
            if (*node != NULL) {
                (*node)->prev = NULL;
            }
            free(temp);
            return element;
        }
    }
    return NULL;


}

