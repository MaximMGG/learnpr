#include <sys/socket.h>
#include <unistd.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>

#define HOST "www.google.com"
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
        if (p->ai_family == AF_INET) {
            char buf[INET_ADDRSTRLEN];
            struct sockaddr_in *sa = (struct sockaddr_in *)p->ai_addr;
            inet_ntop(AF_INET, &sa->sin_addr, buf, INET_ADDRSTRLEN);
            printf("%s\n", buf);
        } else {
            char buf[INET6_ADDRSTRLEN];
            struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)p->ai_addr;
            inet_ntop(AF_INET6, &in6->sin6_addr, buf, INET6_ADDRSTRLEN);
            printf("%s\n", buf);
        }
    }

    status = connect(sockfd, res->ai_addr, res->ai_addrlen);

    // if (status != 0) {
    //     fprintf(stderr, "connect error\n");
    //     exit(1);
    // }

    ipv4 = *(struct sockaddr_in *) res->ai_addr; 
    ipv6 = *(struct sockaddr_in6 *) res->ai_addr; 

    printf("IPv4 -> %s\n", inet_ntoa(ipv4.sin_addr));
    printf("IPv6 -> %s\n", inet_ntoa(*(struct in_addr *)&ipv6.sin6_addr));

    freeaddrinfo(res);
    close(sockfd);

    return 0;
}
