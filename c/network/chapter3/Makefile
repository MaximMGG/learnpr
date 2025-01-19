SERVER = tcp_server
CLIENT = tcp_client
#FLAG = -std=c17
SRC_SERVER = tcp_server.c
SRC_CLIENT = tcp_client.c
OBJ_SERVER = $(SRC_SERVER:%.c=%.o)
OBJ_CLIENT = $(SRC_CLIENT:%.c=%.o)

.PHONY: server

default: server client

server: $(OBJ_SERVER)
	gcc -o $(SERVER) $^

client: $(OBJ_CLIENT)
	gcc -o $(CLIENT) $^

%.o:%.c
	gcc -o $@ -c $<

clean:
	rm *.o $(SERVER) $(CLIENT)
