#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/poll.h>


#define BUFLEN 1024

int main(int argc, char **argv) {
    if (argc < 3) {
        fprintf(stderr, "Not set address or port\n");
        exit(EXIT_FAILURE);
    }

    char *hostname = argv[1];
    char *port = argv[2];

    struct addrinfo hints = {0}, *res;
    int sockfd;
    int status;
    int rv;
    char buf[BUFLEN];
    int bytenums = 0;
    struct pollfd ufds;

    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if ((status = getaddrinfo(hostname, port, &hints, &res)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
        exit(EXIT_FAILURE);
    }

    sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);

    if ((status = connect(sockfd, res->ai_addr, res->ai_addrlen)) != 0) {
        fprintf(stderr, "connect error: %s\n", gai_strerror(status));
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    ufds.fd = sockfd;
    ufds.events = POLLIN;

    rv = poll(&ufds, 1, 2000);

    if (rv == -1) {
        fprintf(stderr, "pool\n");

    } else {
        bytenums = recv(sockfd, buf, BUFLEN, MSG_PEEK);
        if (bytenums == -1) {
            fprintf(stderr, "recvfrom error\n");
            close(sockfd);
            exit(1);
        }
        buf[bytenums] = '\0';

        printf("%s\n", buf);
    }

    freeaddrinfo(res);
    close(sockfd);
    return 0;
}
