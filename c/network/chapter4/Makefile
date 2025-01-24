CLIENT = udp_client
SERVER = udp_server
SERVER_TO_UPPER = udp_server_to_upper
SRC_CLIENT = udp_client.c
SRC_SERVER = udp_server.c
SRC_SERVER_TO_UPPER = udp_server_to_upper.c
OBJ_CLIENT = $(SRC_CLIENT:%.c=%.o)
OBJ_SERVER = $(SRC_SERVER:%.c=%.o)
OBJ_SERVER_TO_UPPER = $(SRC_SERVER_TO_UPPER:%.c=%.o)

.PHONY: client server server_to_upper clean

default: client server server_to_upper

client: $(OBJ_CLIENT)
	gcc -o $(CLIENT) $^ -g

server: $(OBJ_SERVER)
	gcc -o $(SERVER) $^ -g

server_to_upper: $(OBJ_SERVER_TO_UPPER)
	gcc -o $(SERVER_TO_UPPER) $^ -g

%.o: %.c
	gcc -o $@ -c $< -g

clean:
	rm *.o $(CLIENT) $(SERVER)
