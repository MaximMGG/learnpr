#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>

#define ERR() fprintf(stderr, "Error in the line %d\n", __LINE__ - 1)
#define RESPONSE "OK 200 HTTP/1.1\r\n\r\n"
#define SOCKET int

int main() {

    struct addrinfo hints = {0}, *connections;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo(0, "7000", &hints, &connections) == -1) {
        ERR();
        return 1;
    }
    puts("Creating socket...");
    int listen_socket = socket(connections->ai_family, connections->ai_socktype, connections->ai_protocol);
    if (listen_socket == -1) {
        ERR();
        return 1;
    }
    puts("Binding socket...");
    if (bind(listen_socket, connections->ai_addr, connections->ai_addrlen) == -1) {
        ERR();
        return 1;
    }
    puts("Listening socket...");
    if (listen(listen_socket, 10) == -1) {
        ERR();
        return 1;
    }

    freeaddrinfo(connections);

    fd_set master, reads;
    FD_ZERO(&master);
    FD_SET(listen_socket, &master);
    SOCKET max_socket = listen_socket;

    while(1) {
        reads = master;
        if (select(max_socket + 1, &master, 0, 0, 0) == -1) {
            ERR();
            close(listen_socket);
            return 1;
        }

        for(int i = 0; i < max_socket; i++) {
            if (FD_ISSET(i, &reads)) {
                if (i == listen_socket) {
                    struct sockaddr_storage new_addr = {0};
                    socklen_t addrlen = sizeof(new_addr);
                    SOCKET new_con = accept(i, (struct sockaddr *) &new_addr, &addrlen);
                    if (new_con == -1) {
                        close(listen_socket);
                        ERR();
                    }
                    char addrname[512];
                    getnameinfo((struct sockaddr *) &new_addr, addrlen, addrname, 512, 0, 0, NI_NUMERICHOST);
                    printf("New incoming connection %s\n", addrname);
                    if (new_con > max_socket) {
                        max_socket = new_con;
                    }
                    FD_SET(new_con, &master);
                } else {
                    char request[512] = {0};
                    int bytes_count = recv(i, request, 512, 0);
                    if (bytes_count < 1) {
                        FD_CLR(i, &master);
                        close(i);
                    }
                    printf("Received %d bytes: %.*s\n", bytes_count, bytes_count, request);

                    bytes_count = send(i, RESPONSE, strlen(RESPONSE), 0);
                    printf("Sended %d bytes\n", bytes_count);
                }
            }
        }
    }
    puts("Close all connections");
    close(listen_socket);

    return 0;
}
