#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>


int main() {

    int status;
    struct addrinfo req;
    struct addrinfo *pai;

    if((status = getaddrinfo(NULL, "3490", &req, &pai)) != 0) {
        fprintf(stderr, "getaddrinfo error %s\n", gai_strerror(status));
        exit(1);
    };

    printf("All good");
    printf("Address name is %s\n", pai->ai_canonname);
    printf("Data is %s\n", pai->ai_addr->sa_data);
    printf("%d %d\n", pai->ai_protocol, pai->ai_flags);

    freeaddrinfo(pai);
}
