#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>

#define ERR() fprintf(stderr, "Error in the line %d\n", __LINE__ - 1)
#define REQUEST "GET / HTTP/1.1\r\n\r\n"


int main() {

    struct addrinfo hints = {0}, *con;
    hints.ai_flags = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo("127.0.0.1", "7000", &hints, &con) == -1) {
        ERR();
        return 1;
    }
    puts("Creating socket...");
    int con_sock = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (con_sock == -1) {
        ERR();
        return 1;
    }
    puts("Connecting to port...");
    if (connect(con_sock, con->ai_addr, con->ai_addrlen) == -1) {
        ERR();
        return 1;
    }

    freeaddrinfo(con);
    char buf[512] = {0};
    int bytes_count = send(con_sock, REQUEST, strlen(REQUEST), 0);
    if (bytes_count < 1) {
        close(con_sock);
        ERR();
        return 1;
    }
    bytes_count = recv(con_sock, buf, 512, 0);
    printf("Response from server %d bytes: %.*s", bytes_count, bytes_count, buf);

    close(con_sock);

    return 0;
}
