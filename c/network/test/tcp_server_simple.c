#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>

#define ERR() fprintf(stderr, "Error in the line %d\n", __LINE__ - 1)
#define RESPONSE "OK 200 HTTP/1.1\r\n\r\n"

int main() {

    struct addrinfo hints = {0}, *connections;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo(0, "7000", &hints, &connections) == -1) {
        ERR();
        return 1;
    }
    puts("Creating socket...");
    int listen_socket = socket(connections->ai_family, connections->ai_socktype, connections->ai_protocol);
    if (listen_socket == -1) {
        ERR();
        return 1;
    }
    puts("Binding socket...");
    if (bind(listen_socket, connections->ai_addr, connections->ai_addrlen) == -1) {
        ERR();
        return 1;
    }
    puts("Listening socket...");
    if (listen(listen_socket, 10) == -1) {
        ERR();
        return 1;
    }

    freeaddrinfo(connections);

    puts("Accepting new connection");
    struct sockaddr_storage addr_in = {0};
    socklen_t addrlen = sizeof(addr_in);
    int new_s = accept(listen_socket, (struct sockaddr *) &addr_in, &addrlen);
    if (new_s == -1) {
        ERR();
        return 1;
    }
    char buf[512] = {0};
    getnameinfo((struct sockaddr *) &addr_in, addrlen, buf, 512, 0, 0, NI_NUMERICHOST);
    printf("New incoming connection %s\n", buf);

    memset(buf, 0, 512);
    int bytes_count = recv(new_s, buf, 512, 0);
    if (bytes_count < 1) {
        close(new_s);
        puts("Not recv from incoming connection");
    }
    printf("Received %d bytes: %.*s\n", bytes_count, bytes_count, buf);

    send(new_s, RESPONSE, strlen(RESPONSE), 0);

    close(new_s);
    close(listen_socket);

    return 0;
}
