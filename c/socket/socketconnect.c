#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <stdio.h>



int main(int argc, char **argv) {

    struct addrinfo hints = {0}, *res;
    int sockfd;
    int status;

    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    status = getaddrinfo("www.example.com", "3490", &hints, &res);

    sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);

    if (sockfd != 0) {
        printf("Socket success!\n");
    }

    status = connect(sockfd, res->ai_addr, res->ai_addrlen);

    if (status != 0) {
        printf("Connection success!\n");
    }

    freeaddrinfo(res);
    return 0;
}
