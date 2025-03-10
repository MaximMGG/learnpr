#include "sock.h"
#include <stdlib.h>

int main() {

    struct addrinfo hints = {0};
    // hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;
    // hints.ai_flags = AI_PASSIVE;
    struct addrinfo *res;
    if (getaddrinfo("127.0.0.1", "8081", &hints, &res)) {
        fprintf(stderr, "getaddrinfo fail %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }

    printf("Target server : ");
    char address[512] = {0};
    char servece[512] = {0};

    getnameinfo(res->ai_addr, res->ai_addrlen, address, 512, servece, 512, NI_NUMERICHOST | NI_NUMERICSERV);

    printf("%s - %s\n", address, servece);


    int cli_sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (!ISVALIDSOCKET(cli_sock)) {
        fprintf(stderr, "socket fail %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }
    printf("Enter your message bellow\n");


    while(1) {
        char msg[512];
        printf("Enter message to server: ");
        if (!fgets(msg, 512, stdin)) break;
        int bytes = sendto(cli_sock, msg ,strlen(msg), 0, res->ai_addr, res->ai_addrlen);
        
        printf("Sent %d bytes\n", bytes);

        if (strcmp(msg, "exit!\n") == 0 || strcmp(msg, "exit!") == 0) break;

        bytes = recvfrom(cli_sock, msg, 512, 0, res->ai_addr, &res->ai_addrlen);
        if (bytes < 0) {
            fprintf(stderr, "bytes < 0\n");
            break;
        }

        printf("Receive from server -> %s\n", msg);

    }


    close(cli_sock);

    return 0;
}
