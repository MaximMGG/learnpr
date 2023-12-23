#include <sys/types.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netdb.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main(void) {

    int status;
    int fd;
    struct addrinfo req, *res;
    char hostname[] = "api1.binance.com";
    char request[] = "GET /api/v3/ticket?symbol=BTCUSDT";
    char buffer[BUFSIZ];
    int request_len = sizeof(request);

    status = getaddrinfo(hostname, "https", &req, &res);
    if (status < 0) {
        fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(status));
        exit(1);
    }
    fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (fd < 0) {
        fprintf(stderr, "socket error: %s\n", gai_strerror(status));
        exit(1);
    }

    status = connect(fd, res->ai_addr, res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "connect error: %s\n", gai_strerror(status));
        exit(1);
    }

    int c = 1;
    while(c--) {
        status = send(fd, request, request_len, 0);
        if (status < 0) {
            fprintf(stderr, "send error: %s\n", gai_strerror(status));
            exit(1);
        }

        status = recv(fd, buffer, BUFSIZ, 0);
        if (status < 0) {
            fprintf(stderr, "revc error: %s\n", gai_strerror(status));
            exit(1);
        }

        printf("%s\n", buffer);
    }

    close(fd);
    freeaddrinfo(res);
    return 0;
}
