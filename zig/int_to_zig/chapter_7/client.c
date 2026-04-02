#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define REQUEST "GET /usr/lists/ HTTP/1.1\n\r\n\r"

int main() {
    struct addrinfo hints;
    struct addrinfo *res;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo("127.0.0.1", "3490", &hints, &res) == -1) {
        exit(1);
    }

    int soc = socket(res->ai_family, res->ai_socktype, res->ai_protocol);

    if (connect(soc, res->ai_addr, res->ai_addrlen) == -1) {
        close(soc);
        exit(1);
    }

    int send_bytes = send(soc, REQUEST, strlen(REQUEST), 0);
    printf("Sending %d bytes\n", send_bytes);

    return 0;
}
