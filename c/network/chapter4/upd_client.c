#include "sock.h"
#include <stdlib.h>

int main() {

    struct addrinfo hints = {0};
    // hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;
    // hints.ai_flags = AI_PASSIVE;
    struct addrinfo *res;
    if (getaddrinfo("127.0.0.1", "8080", &hints, &res)) {
        fprintf(stderr, "getaddrinfo fail %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }

    int cli_sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (!ISVALIDSOCKET(cli_sock)) {
        fprintf(stderr, "socket fail %s\n", strerror(GETSOCKETERRNO));
        return EXIT_FAILURE;
    }
    printf("Enter your message bellow\n");

    while(1) {
        char buf[1024] = {0};
        if (!fgets(buf, 1024, stdin)) {
            break;
        }
        if (strcmp(buf, "quit") == 0) break;

        struct sockaddr_storage ser = {0};
        socklen_t ser_len = sizeof(ser);        
        printf("Try to send %s\n", buf);
        int bytes = sendto(cli_sock, buf, strlen(buf), 0, (struct sockaddr *)&ser, ser_len);
        if (bytes < 0) {
            fprintf(stderr, "sendto failed\n");
            continue;
        }
        memset(buf, 0, 1024);
        bytes = recvfrom(cli_sock, buf, 1024, 0, (struct sockaddr *)&ser, &ser_len);
        if (bytes < 0) {
            fprintf(stderr, "recvfrom failed\n");
            continue;
        }
        printf("Response from server %s\n", buf);

    }

    close(cli_sock);

    return 0;
}
