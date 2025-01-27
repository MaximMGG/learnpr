#include "sock.h"


int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Neet to pass host name\n");
        return EXIT_FAILURE;
    }


    struct addrinfo hints = {0};
    hints.ai_flags = AI_ALL;
    struct addrinfo *pear_addr;

    printf("Look up at hostname - %s\n", argv[1]);


    if (getaddrinfo(argv[1], 0, &hints, &pear_addr)) {
        fprintf(stderr, "getaddrinfo fail %d\n", errno);
        return EXIT_FAILURE;
    }

    printf("Remote address\n");


    struct addrinfo *tmp = pear_addr;
    while(tmp != NULL) {
        char buf[512] = {0};
        char port[512] = {0};
        getnameinfo(tmp->ai_addr, tmp->ai_addrlen, buf, 512, port, 512, NI_NUMERICHOST | NI_NUMERICSERV);


        if (tmp->ai_family == AF_INET) {
            printf("IPv4 - %s - %s\n", buf, port);
        } else {
            printf("IPv6 - %s - %s\n", buf, port);
        }

        tmp = tmp->ai_next;
    }
    
    freeaddrinfo(pear_addr);
    return 0;
}
