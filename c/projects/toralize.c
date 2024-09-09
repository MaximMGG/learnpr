#include "toralize.h"


int main(int argc, char **argv) {
    struct addrinfo hints = {0};
    char *host;
    int port, s;
    struct sockaddr_in sock = {0};
    struct addrinfo *con;
    hints.ai_flags = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (argc < 3) {
        fprintf(stderr, "Usage %s: <host> <port>\n", argv[0]);

        return EXIT_FAILURE;
    }


    int addrres = getaddrinfo(PROXY, PROXYPORT, &hints, &con);


    host = argv[1];
    port = atoi(argv[2]);

    s = socket(con->ai_family, con->ai_socktype, con->ai_protocol);

    if (s < 0) {
        perror("socket");

        return EXIT_FAILURE;
    }

    int res = connect(s, con->ai_addr, con->ai_addrlen);
    // if (connect(s, (struct sockaddr *) &sock, sizeof(sock))) {
    //     perror("connect");
    //     close(s);
    //
    //     return -1;
    // }
    printf("Connect to proxy\n");
    close(s);
}
