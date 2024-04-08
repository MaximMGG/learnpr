#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>


char *hosts[5] = {"www.google.com", "www.example.com", "www.youtube.com", "www.twitter.com", "www.github.com"};


int main() {

    int sockfd;
    int status;
    struct addrinfo hints = {0}, *res, *p;

    for(int i = 0; i < 5; i++) {
        hints.ai_family = AF_UNSPEC;
        hints.ai_socktype = SOCK_STREAM;

        status = getaddrinfo(hosts[i], "http", &hints, &res);

        printf("IP address for %s\n", hosts[i]);
        

        char bufv4[INET_ADDRSTRLEN];
        char bufv6[INET6_ADDRSTRLEN];
        for(p = res; p; p = p->ai_next) {
            if (p->ai_family == AF_INET) {
                struct sockaddr_in *in4 = (struct sockaddr_in *) p->ai_addr;
                inet_ntop(AF_INET, &in4->sin_addr, bufv4, INET_ADDRSTRLEN);
                printf("IPv4 - %s\n", bufv4);
            } else {
                struct sockaddr_in6 *in6 = (struct sockaddr_in6 *) p->ai_addr;
                inet_ntop(AF_INET6, &in6->sin6_addr, bufv6, INET6_ADDRSTRLEN);
                printf("IPv6 - %s\n", bufv6);
            }
        }
        freeaddrinfo(res);
        puts("");
    }

    return 0;
}
