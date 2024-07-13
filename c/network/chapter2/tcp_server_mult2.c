#include <sys/select.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>

#include <unistd.h>
#include <stdio.h>
#include <string.h>


#define ERR() fprintf(stderr, "error, line %d", (__LINE__ - 1));


int main() {

    struct addrinfo hints = {0}, *con;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo(0, "6000", &hints, &con) == -1) {
        ERR();
        return 1;
    }
    printf("Create socket\n");
    int listen_socket = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (listen_socket <= 0) {
        ERR();
    }
    printf("Bind socket\n");
    if (bind(listen_socket, con->ai_addr, con->ai_addrlen) == -1) {
        ERR();
    }
    printf("Listening socket\n");
    if (listen(listen_socket ,10) == -1) {
        ERR();
    }


    fd_set master, reads;
    FD_ZERO(&master);
    FD_SET(listen_socket, &master);
    int max_sock = listen_socket;

    while(1) {
        reads = master;
        if (select(max_sock + 1, &master, NULL, NULL, NULL) < 0) {
            ERR();
        }
        for(int i = 0; i < max_sock; i++) {
            if (FD_ISSET(i, &reads)) {
                if (i == listen_socket) {
                    struct sockaddr_storage client_address;
                    socklen_t addrlen = sizeof(client_address);
                    int socket_client = accept(listen_socket, (struct sockaddr *) &client_address, &addrlen);
                    if (socket_client < 0) {
                        ERR();
                    }
                    FD_SET(socket_client, &master);
                    if (socket_client > max_sock) {
                        max_sock = socket_client;
                    }

                    char addr_buffer[100];
                    getnameinfo((struct sockaddr *) &client_address, addrlen, addr_buffer, 10, NULL, 0, NI_NUMERICHOST);
                    printf("New connection %s\n", addr_buffer);
                } else {
                    char read[1024];
                    int read_bytes = recv(i, read, 1024, 0);

                    if (read_bytes < 1) {
                        FD_CLR(i, &master);
                        close(i);
                        continue;
                    }
                    printf("Client setd %d bytes: %.*s", read_bytes, read_bytes, read);

                    char response[128] = "Response from server!";
                    send(i, response, strlen(response), 0);
                }
            }
        }
    }

    freeaddrinfo(con);
    close(listen_socket);

    return 0;
}
