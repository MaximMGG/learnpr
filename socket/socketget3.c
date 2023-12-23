#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>

#define MAX_BUFFER_SIZE 1024

// Function to create a socket, connect to the server, and send a GET request
void perform_get_request(const char *host, const char *path) {
    int status;
    struct addrinfo req, *res;
    memset(&req, 0, sizeof(req));
    req.ai_flags = AF_UNSPEC;
    req.ai_socktype = SOCK_STREAM;
    req.ai_flags = AI_CANONNAME;
    int fd;
    // char request[MAX_BUFFER_SIZE];
    char request[] = "GET https://api1.binance.com/api/v3/ticker\n" 
                        "Content-Type: application/json\n" 
                        "{\n\"symbol\":\"BTCUSDT\"\n}";
    char buffer[MAX_BUFFER_SIZE];

    status = getaddrinfo(host, "443", &req, &res);
    if (status < 0) {
        fprintf(stderr, "getaddrinfo error %s\n", gai_strerror(status));
        exit(1);
    }

    fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (fd < 0) {
        fprintf(stderr, "socket init error %s\n", gai_strerror(status));
        exit(1);
    }

    // sprintf(request, "GET %s HTTP/1.1\r\nHost %s\r\n\r\n", path, host);
    status = connect(fd, res->ai_addr, res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "connect error %s\n", gai_strerror(status));
        exit(1);
    }

    status = sendto(fd, request, sizeof(request), 0, res->ai_addr, res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "sendto error %s\n", gai_strerror(status));
        exit(1);
    }

    status = recvfrom(fd, buffer, MAX_BUFFER_SIZE, 0, res->ai_addr, &res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "recv error %s\n", gai_strerror(status));
        exit(1);
    }

    printf("%s\n", buffer);

    close(fd);
    freeaddrinfo(res);
}

int main() {
    const char *host = "api1.binance.com";
    const char *path = "/api/v3/ticker?symbol=BTCUSDT";

    perform_get_request(host, path);

    return 0;
}
