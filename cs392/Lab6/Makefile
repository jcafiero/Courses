OBJS = lab6.o
COBJS = lab6.c
CFLAGS = -std=c99 -Werror

EXEC = my_lab6

CC = gcc 

all: $(OBJS)
	$(CC) $(COBJS) -o $(EXEC) $(CFLAGS)

clean:
	rm -f $(OBJS)

fclean:
	rm -f $(EXEC) $(OBJS)

re:
	make fclean all