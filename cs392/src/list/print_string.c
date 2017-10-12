/*
 * print_string.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *      Prints the elem of node as a string
 */

#include "list.h"

void print_string(struct s_node* node) {
     if (node == NULL){
        my_str("NULL");
        return;
    }
    if (node->elem == NULL){
        my_str("NULL");
        return;
    }
	my_str((char*)(node->elem));
}
