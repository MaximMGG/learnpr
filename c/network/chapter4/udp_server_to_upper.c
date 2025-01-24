#include "sock.h"
#include <ctype.h>

void _to_upper(char *buf, int size) {
    for(int i = 0; i < size; i++)
        buf[i] = toupper(buf[i]);
}

int main() {

    printf("Initialize server...\n");
    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;
    hints.ai_flags = AI_PASSIVE;
    struct addrinfo *bind_address;
    if (getaddrinfo("127.0.0.1", "8081", &hints, &bind_address)) {
        fprintf(stderr, "getaddrinfo error %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }

    printf("Create socket...\n");
    SOCKET listen_socket = socket(  bind_address->ai_family,
                                    bind_address->ai_socktype,
                                    bind_address->ai_protocol);
    if (!ISVALIDSOCKET(listen_socket)) {
        fprintf(stderr, "socket error %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }

    printf("Binding socket to local address...\n");
    if (bind(listen_socket, bind_address->ai_addr, bind_address->ai_addrlen)) {
        fprintf(stderr, "bind error %s\n", strerror(GETSOCKETERRNO));
        CLOSESOCKET(listen_socket);
        return EXIT_FAILURE;
    }

    fd_set upcomming;
    FD_ZERO(&upcomming);
    FD_SET(listen_socket, &upcomming);
    SOCKET max_socket = listen_socket;

    while(1) {
        char buf[1024] = {0};

        if (select(max_socket + 1, &upcomming, 0, 0 ,0) < 0) {
            fprintf(stderr, "select error %s\n", strerror(GETSOCKETERRNO));
            CLOSESOCKET(listen_socket);
            return EXIT_FAILURE;
        }

        if (FD_ISSET(listen_socket, &upcomming)) {
            struct sockaddr_storage client;
            socklen_t len = sizeof(client);
            int bytes = recvfrom(listen_socket, buf, 1024, 0, (struct sockaddr *)&client, &len);
            if (bytes < 0) {
                fprintf(stderr, "connection lost %s\n", strerror(GETSOCKETERRNO));
                CLOSESOCKET(listen_socket);
                return EXIT_FAILURE;
            }

            if (strcmp(buf, "exit\n") == 0) break;
            printf("Received from client -> %s\n", buf);

            _to_upper(buf, bytes);

            bytes = sendto(listen_socket, buf, bytes, 0, (struct sockaddr *)&client, len);

            if (bytes < 0) {
                fprintf(stderr, "connection lost %s\n", strerror(GETSOCKETERRNO));
                CLOSESOCKET(listen_socket);
                return EXIT_FAILURE;
            }

            printf("Sent to client -> %s\n", buf);
        }
    }

    return 0;
}
