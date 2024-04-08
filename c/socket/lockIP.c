#include <sys/socket.h>
#include <unistd.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>

#define HOST "www.example.com"
#define PORT "http"

int main() {
    struct sockaddr_in ipv4;
    struct sockaddr_in6 ipv6;
    struct addrinfo hints = {0}, *res, *p;
    int sockfd;
    int status;

    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    sockfd = socket(hints.ai_family, hints.ai_socktype, 0);

    status = getaddrinfo(HOST, PORT, &hints, &res);
    if (status != 0) {
        fprintf(stderr, "addrinfo error\n");
        exit(1);
    }

    for(p = res; p; p = p->ai_next) {
        if (p->ai_family & AF_INET) {
            printf("%s\n", inet_ntoa(((struct sockaddr_in *) p->ai_addr)->sin_addr));
        } else {
            printf("%s\n", inet_ntoa(((struct sockaddr_in *) p->ai_addr)->sin_addr));
        }
    }

    status = connect(sockfd, res->ai_addr, res->ai_addrlen);

    if (status != 0) {
        fprintf(stderr, "connect error\n");
        exit(1);
    }

    ipv4 = *(struct sockaddr_in *) res->ai_addr; 
    ipv6 = *(struct sockaddr_in6 *) res->ai_addr; 

    printf("IPv4 -> %s\n", inet_ntoa(ipv4.sin_addr));
    printf("IPv6 -> %s\n", inet_ntoa(*(struct in_addr *)&ipv6.sin6_addr));

    freeaddrinfo(res);
    close(sockfd);

    return 0;
}
