EXEC=pipes

COBJS= pipes.c
OBJS= pipes.o

WHAT = ../my/my_char.o ../my/my_str.o ../my/my_strlen.o ../my/my_vect2str.o

CC = gcc

LFLAGS = -L../../lib -lmy
CFLAGS = -std=c99 -I../../include -Werror


all: $(OBJS)
	$(CC)  -o $(EXEC) $(OBJS) $(LFLAGS) $(CFLAGS)

clean:
	rm -f $(OBJS)

fclean: 
	rm -f $(EXEC)

re:
	make fclean all