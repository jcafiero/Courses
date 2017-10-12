
OBJS = my_alpha.o my_char.o my_revstr.o my_str.o my_strlen.o my_int.o my_num_base.o my_strindex.o my_strrindex.o my_strfind.o my_strrfind.o my_strcmp.o my_strncmp.o my_strcpy.o my_strncpy.o my_strcat.o my_strdup.o my_strconcat.o my_strnconcat.o my_atoi.o my_vect2str.o
COBJS = my_alpha.c my_char.c my_revstr.c my_str.c my_strlen.c my_int.c my_num_base.c my_strindex.c my_strrindex.c my_strfind.c my_strrfind.c my_strcmp.c my_strncmp.c my_strcpy.c my_strncpy.c my_strcat.c my_strdup.c my_strconcat.c my_strnconcat.c my_atoi.c my_vect2str.c
LFLAGS = -L../../lib -lmy
CFLAGS = -std=c99 -I../../include -Wall -Werror --pedantic 

NAME = libmy.a
LIBPATH = ../../lib

CC = gcc

all: $(OBJS)
	ar -rc $(NAME) $(OBJS)
	ranlib $(NAME)
	mv $(NAME) $(LIBPATH)

clean:
	rm -f $(OBJS)

fclean:
	rm -f $(LIBPATH)/$(NAME) $(OBJS)

re:
	make fclean all