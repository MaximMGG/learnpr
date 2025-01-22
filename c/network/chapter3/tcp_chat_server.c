#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#define BOOL char


int main() {

    printf("Initialize server...\n");
    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;
    struct addrinfo *res;
    if (getaddrinfo(0, "4000", &hints, &res)) {
        fprintf(stderr, "getaddrinfo() failed %s\n", strerror(errno));
        return EXIT_FAILURE;
    }

    int sock_listen = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock_listen < 0) {
        fprintf(stderr, "socket() failed %s\n", strerror(errno));
        return EXIT_FAILURE;
    }

    if (bind(sock_listen, res->ai_addr, res->ai_addrlen)) {
        fprintf(stderr, "bind() failed %s\n", strerror(errno));
        close(sock_listen);
        return EXIT_FAILURE;
    }

    if (listen(sock_listen, 10) < 0) {
        fprintf(stderr, "listen() failed %s\n", strerror(errno));
        close(sock_listen);
        return EXIT_FAILURE;
    }

    fd_set reads;
    fd_set writes;
    FD_ZERO(&reads);
    FD_ZERO(&writes);
    FD_SET(sock_listen, &reads);
    FD_SET(sock_listen, &writes);
    int max_socket = sock_listen;

    BOOL server_work = 1;

    struct timeval timeout = {.tv_sec = 0, .tv_usec = 200000};
    
    while(server_work) {

        if (select(max_socket + 1, &reads, &writes, 0, NULL) < 0) {
            fprintf(stderr, "select() failed %s\n", strerror(errno));
            close(sock_listen);
            return EXIT_FAILURE;
        }


        for(int i = 0; i <= max_socket; i++) {
            char buf[1024] = {0};
            if (FD_ISSET(i, &reads)) {
                if (i == sock_listen) {

                    struct sockaddr_storage client_address = {0};
                    socklen_t client_len = sizeof(client_address);

                    int new_connection = accept(sock_listen, (struct sockaddr *)&client_address, &client_len);
                    if (new_connection < 0) {
                        fprintf(stderr, "select() failed %s\n", strerror(errno));
                        return EXIT_FAILURE;
                    }

                    char cl_host[512] = {0};
                    if (getnameinfo((struct sockaddr *)&client_address, client_len, cl_host, 512, 0, 0, NI_NUMERICHOST)) {}
                    printf("New connection %s\n", cl_host);


                    FD_SET(new_connection, &reads);
                    FD_SET(new_connection, &writes);
                    if (new_connection > max_socket) {
                        max_socket = new_connection;
                    }
                } else {
                    int bytes = recv(i, buf, 1024, 0);
                    printf("Data from socket %d -> %s\n", i, buf);
                    if (bytes < 0) {
                        printf("Problem to receiv data from socket - %d\n", i);
                        close(i);
                        FD_CLR(i, &reads);
                        FD_CLR(i, &writes);
                        continue;
                    }
                   
                    for(int j = 0;j <= max_socket; j++) {
                        if (FD_ISSET(j, &writes)) {
                            if (i != j) {
                                bytes = send(j, buf, strlen(buf), 0);
                                printf("Sent to socket - %d -> %s\n", j, buf);
                                if (bytes < 0) {
                                    printf("Problem to send data to socket - %d", j);
                                    close(j);
                                    FD_CLR(j, &writes);
                                    FD_CLR(j, &reads);
                                    continue;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    close(sock_listen);

    return 0;
}
