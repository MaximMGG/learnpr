#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>

//craftinginterpreters.com contents.html

#define MSG "GET /contents.html HTTP/1.1\r\nHost: craftinginterpreters.com\r\n\r\n"

int main() {

    struct addrinfo hints, *res;
    hints.ai_socktype = SOCK_STREAM;
    if (getaddrinfo("craftinginterpreters.com", "80", &hints, &res) == -1) {
        fprintf(stderr, "getaddrinfo error\n");
        return EXIT_FAILURE;
    }

    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock == -1) {
        fprintf(stderr, "socket error\n");
        return EXIT_FAILURE;
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen) < 0) {
        fprintf(stderr, "connect error\n");
        close(sock);
        return EXIT_FAILURE;
    }

    freeaddrinfo(res);

    int bytes = send(sock, MSG, strlen(MSG), 0);

    if (bytes < 0) {
        fprintf(stderr, "send error 0 bytes\n");
        close(sock);
        return EXIT_FAILURE;
    }

    char buf[4096] = {0};

    while(bytes > 0) {
        bytes = recv(sock, buf, 4096, MSG_WAITALL);

        if (bytes == -1) {
            fprintf(stderr, "error recv %s\n", strerror(errno));
            close(sock);
        }

        if (bytes < 4096) {
            printf("Recv less bytes this buf_size %d\n", 4096);
            printf("%s", buf);
            break;
        }

        printf("%s", buf);
        memset(buf, 0, 4096);
    }

    printf("End of client\n");
    close(sock);

    return 0;
}
