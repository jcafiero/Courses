OBJS_S = server.o
OBJS_C = client.o

SERVER = server
CLIENT = client

CFLAGS = -I../../include -Werror
LFLAGS = -L../../lib -llist -lmy -lncurses

CC = gcc

all:	server client

server: $(OBJS_S)
	$(CC) $(OBJS_S) -o $(SERVER) $(CFLAGS) $(LFLAGS)

client: $(OBJS_C)
	$(CC) $(OBJS_C) -o $(CLIENT) $(CFLAGS) $(LFLAGS)

clean:
	rm -f $(OBJS_S)
	rm -f $(OBJS_C)

fclean:
	rm -f $(SERVER)
	rm -f $(CLIENT)

re:
	make fclean all
 