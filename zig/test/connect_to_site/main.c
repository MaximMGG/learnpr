#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <string.h>


#define GET_MSG "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n"



int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage main <site_name>\n");
        return 1;
    }


    struct addrinfo hints, *res;
    memset(&hints, 0, sizeof(hints));
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(argv[1], "80", &hints, &res) < 0) {
        fprintf(stderr, "getaddrinfo error\n");
        return 1;
    }

    int con_sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (con_sock < 0) {
        fprintf(stderr, "socket error\n");
        return 1;
    }

    if (connect(con_sock, res->ai_addr, res->ai_addrlen) == -1) {
        fprintf(stderr, "connect error\n");
        close(con_sock);
        return 1;
    }

    int bytes = 0;

    bytes = send(con_sock, GET_MSG, strlen(GET_MSG), 0);
    if (bytes < 0) {
        fprintf(stderr, "send error\n");
        close(con_sock);
        return 1;
    }

    char buf[1024] = {0};

    while((bytes = recv(con_sock, buf, 1024, 0)) > 0) {
        printf("Received %d bytes\n%s\n", bytes, buf);
        memset(buf, 0, 1024);
        if (bytes < 1024) {
            break;
        }
    }

    freeaddrinfo(res);
    close(con_sock);

    return 0;
}
