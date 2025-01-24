#include "sock.h"
#include <stdlib.h>



int main() {
    printf("Init server...\n");
    struct addrinfo hints = {0};
//    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;
 //   hints.ai_flags = AI_PASSIVE;
    struct addrinfo *bindings;
    if (getaddrinfo(0, "8080", &hints, &bindings)) {
        fprintf(stderr, "getaddrinfo failed %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }
    SOCKET sock_listen = socket(bindings->ai_family, bindings->ai_socktype, bindings->ai_protocol);
    if (!ISVALIDSOCKET(sock_listen)) {
        fprintf(stderr, "socket failed %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }

    if (bind(sock_listen, bindings->ai_addr, bindings->ai_addrlen)) {
        fprintf(stderr, "bind failed %s\n", strerror(GETSOCKETERRNO));
        close(sock_listen);
        return EXIT_FAILURE;
    }

    char *msg = "Hello from server";

    while(1) {
        char buf[1024] = {0};
        struct sockaddr_storage cli;
        socklen_t len = sizeof(cli);
        int bytes = recvfrom(sock_listen, buf, 1024, 0, (struct sockaddr *)&cli, &len);
        if (bytes < 0) {
            fprintf(stderr, "Do not receved from client\n");
            continue;
        }


        char cli_name[512] = {0};
        char cli_serv[512] = {0};
        getnameinfo((struct sockaddr *)&cli, len, cli_name, 512, cli_serv, 512, NI_NUMERICHOST | NI_NUMERICSERV);
        printf("New msg from %s\n", cli_name);
        printf("%s\n", buf);


        if (strcmp(buf, "exit") == 0) break;


        bytes = sendto(sock_listen, buf, strlen(buf), 0, (struct sockaddr *)&cli, len);
        if (bytes < 0) {
            fprintf(stderr, "sendto %s failed\n", cli_name);
            continue;
        }
    }

    close(sock_listen);

    return 0;
}
