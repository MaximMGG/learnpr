CLIENT = udp_client
SERVER = udp_server
SRC_CLIENT = udp_client.c
SRC_SERVER = udp_server.c
OBJ_CLIENT = $(SRC_CLIENT:%.c=%.o)
OBJ_SERVER = $(SRC_SERVER:%.c=%.o)

.PHONY: client server clean

default: client server

client: $(OBJ_CLIENT)
	gcc -o $(CLIENT) $^ -g

server: $(OBJ_SERVER)
	gcc -o $(SERVER) $^ -g


%.o: %.c
	gcc -o $@ -c $< -g

clean:
	rm *.o $(CLIENT) $(SERVER)
