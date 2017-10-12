/*
 * debug_int.c
 *
 *  Created on: Apr 12, 2017
 *      Author: jcafiero
 *      Pledge: I pledge my honor that I have abided by the Stevens Honor System
 *
 *       Prints all the elems as ints separated by a space in the format
 * 		 (NULL <- Elem -> Next elem), ..., (Previous elem <- Elem -> NULL)
 *
 */

#include "list.h"

void debug_int(struct s_node* head) {
	if (head != NULL)
	{
		struct s_node* node = head;

		while (node != NULL)
		{
			my_str("(");
			print_int(node->prev);
			my_str(" <- ");

			print_int(node);

			my_str(" -> ");
			print_int(node->next);
			my_str(")");

			if (node->next != NULL)
			{
				my_str(", ");
			}
			node = node->next;
            
		}
	}
	else
	{
		my_str(" ");
	}


}
