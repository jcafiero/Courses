NAME=liblist.a

COBJS= new_node.c add_node.c debug_string.c debug_int.c debug_char.c print_string.c print_int.c print_char.c add_elem.c append.c add_node_at.c remove_node.c remove_node_at.c remove_last.c count_s_nodes.c empty_list.c node_at.c elem_at.c
OBJS= new_node.o add_node.o debug_string.o debug_int.o debug_char.o print_string.o print_int.o print_char.o add_elem.o append.o add_node_at.o remove_node.o remove_node_at.o remove_last.o count_s_nodes.o empty_list.o node_at.o elem_at.o
RM=rm -f

IPATH= -I../../../include
LIBPATH=../../lib
CFLAGS+= -std=c99 -I../../include -Wall -Werror --pedantic 


all: $(OBJS)
	ar -rc $(LIBPATH)/$(NAME) $(OBJS)
	ranlib $(LIBPATH)/$(NAME)

clean:
	-$(RM) $(OBJS)

fclean: clean
	-$(RM) $(LIBPATH)/$(NAME)

re: fclean all