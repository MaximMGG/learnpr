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
    FD_ZERO(&reads);
    FD_SET(sock_listen, &reads);
    int max_socket = sock_listen;

    BOOL server_work = 1;

    struct timeval timeout = {.tv_sec = 0, .tv_usec = 200000};
    
    while(server_work) {

        int selected_socket = 0;

        if ((selected_socket = select(max_socket + 1, &reads, NULL, 0, &timeout)) < 0) {
            fprintf(stderr, "select() failed %s\n", strerror(errno));
            close(sock_listen);
            return EXIT_FAILURE;
        }

        for(int i = 0; i <= max_socket; i++) {
            if (FD_ISSET(i, &reads)) {
                if (i == sock_listen) {
                    struct sockaddr_storage new_cli = {0};
                    socklen_t cli_len = sizeof(new_cli);


                    int new_connection = accept(sock_listen, (struct sockaddr *)&new_cli, &cli_len);
                    if (new_connection < 0) {
                        fprintf(stderr, "accept() failed %s\n", strerror(errno));
                        close(sock_listen);
                        return EXIT_FAILURE;
                    }
                    char cli_name[1024];
                    getnameinfo((struct sockaddr *)&new_cli, cli_len, cli_name, 1024, 0, 0, NI_NUMERICHOST);
                    printf("New connection -> %s\n", cli_name);
                    FD_SET(new_connection, &reads);

                    if (new_connection > max_socket) {
                        max_socket = new_connection;
                        continue;
                    }
                } else {
                    char msg[4096] = {0};
                    int bytes = recv(i, msg, 4096, 0);
                    if (bytes < 0) {
                        fprintf(stderr, "recved less then 0 form socket %d\n", i);
                        close(i);
                        FD_CLR(i, &reads);
                    }

                    bytes = send(i, msg, strlen(msg), 0);
                    if (bytes < 0) {
                        fprintf(stderr, "send less then 0 bytes to socket %d\n", i);
                        close(i);
                        FD_CLR(i, &reads);
                    }
                }
            }
        }
    }

    close(sock_listen);

    return 0;
}
