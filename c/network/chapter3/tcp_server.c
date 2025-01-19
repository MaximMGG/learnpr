#include "sock.h"
#include <stdlib.h>
#include <ctype.h>



int main() {


    printf("Configuring local address...\n");
    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    struct addrinfo *bind_address;

    if (getaddrinfo(0, "8080", &hints, &bind_address)) {
        fprintf(stderr, "getaddrinfo() fail...\n");
        return EXIT_FAILURE;
    }
    printf("Connecting socket...\n");

    SOCKET socket_listen = socket(bind_address->ai_family, bind_address->ai_socktype, bind_address->ai_protocol);

    if (!ISVALIDSOCKET(socket_listen)) {
        fprintf(stderr, "socket() failed (%d)\n", GETSOCKETERRNO);
        return EXIT_FAILURE;
    }

    printf("Bind socket to local address...\n");
    if(bind(socket_listen, bind_address->ai_addr, bind_address->ai_addrlen)) {
        fprintf(stderr, "bind() failed (%d)\n", GETSOCKETERRNO);
        return EXIT_FAILURE;
    }
    printf("Listening...\n");

    if(listen(socket_listen, 10) < 0) {
        fprintf(stderr, "listen() failed (%d)\n", GETSOCKETERRNO);
        return EXIT_FAILURE;
    }

    fd_set master;
    FD_ZERO(&master);
    FD_SET(socket_listen, &master);
    SOCKET max_socket = socket_listen;

    printf("Waiting for connection...\n");

    while(1) {

        fd_set reads;
        reads = master;

        if (select(max_socket + 1, &reads, 0, 0, 0) < 0) {
            fprintf(stderr, "select() failed (%d)\n", GETSOCKETERRNO);
            CLOSESOCKET(socket_listen);
            return EXIT_FAILURE;
        }

        SOCKET i;
        for(i = 1; i <= max_socket; i++) {
            if (FD_ISSET(i, &reads)) {
                if (i == socket_listen) {
                    struct sockaddr_storage client_address;
                    socklen_t client_len = sizeof(client_address);
                    SOCKET socket_client = accept(socket_listen,
                            (struct sockaddr *) &client_address,
                            &client_len);
                    if (!ISVALIDSOCKET(socket_client)) {
                        fprintf(stderr, "accept() failed (%d)\n", GETSOCKETERRNO);
                        CLOSESOCKET(socket_listen);
                        return EXIT_FAILURE;
                    }
                    FD_SET(socket_client, &master);
                    if (socket_client > max_socket) {
                        max_socket = socket_client;
                    }

                    char address_buffer[100];
                    getnameinfo((struct sockaddr *)&client_address, client_len,
                            address_buffer, sizeof(address_buffer), 0, 0, NI_NUMERICHOST);
                    printf("New connection from %s\n", address_buffer);
                } else {
                    char read[1024] = {0};
                    int bytes_received = recv(i, read, 1024, 0);
                    if (bytes_received < 1) {
                        FD_CLR(i, &master);
                        CLOSESOCKET(i);
                        continue;
                    }

                    int j;
                    for(j = 0; j < bytes_received; j++) {
                        read[j] = toupper(read[j]);
                    }
                    send(i, read, bytes_received, 0);

                    printf("Sended %d bytes -> %s\n", bytes_received, read);
                }
            }
        }
    } // end while(1)

    printf("Closing listening socket...\n");
    CLOSESOCKET(socket_listen);

    printf("Finished\n");
    return 0;
}
