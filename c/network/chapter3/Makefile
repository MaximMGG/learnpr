SERVER = tcp_server
CHAT_SERVER = tcp_chat_server
CLIENT = tcp_client

#FLAG = -std=c17
SRC_SERVER = tcp_server.c
SRC_CLIENT = tcp_client.c
SRC_CHAT_SERVER = tcp_chat_server.c
OBJ_SERVER = $(SRC_SERVER:%.c=%.o)
OBJ_CLIENT = $(SRC_CLIENT:%.c=%.o)
OBJ_CHAT_SERVER = $(SRC_CHAT_SERVER:%.c=%.o)

.PHONY: server client chat_server clean

default: server client chat_server

chat_server: $(OBJ_CHAT_SERVER)
	gcc -o $(CHAT_SERVER) $^ -g

server: $(OBJ_SERVER)
	gcc -o $(SERVER) $^ -g

client: $(OBJ_CLIENT)
	gcc -o $(CLIENT) $^ -g

%.o:%.c
	gcc -o $@ -c $< -g

clean:
	rm *.o $(SERVER) $(CLIENT) $(CHAT_SERVER)
