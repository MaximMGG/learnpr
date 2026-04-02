#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>  // For inet_pton(), sockaddr_in, etc.
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>

int main() {

    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;
    struct addrinfo *res;
    if (getaddrinfo("example.com", "http", &hints, &res)) {
        fprintf(stderr, "getaddrinfo fail\n");
        return 1;
    }

    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock < 0) {
        fprintf(stderr, "socket fail\n");
        return 1;
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen)) {
        fprintf(stderr, "connect error\n");
        close(sock);
        return 1;
    }


    freeaddrinfo(res);

    char *msg = "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n";

    int bytes = send(sock, msg, strlen(msg), 0);
    printf("sent %d bytes\n", bytes);

    printf("Wainting from received msg\n");

    char rec[4096] = {0};

    bytes = recv(sock, rec, 4096, 0);
    printf("Received %d bytes\n", bytes);
    printf("%s\n", rec);



    close(sock);

    printf("Finished\n");

    return 0;
}

