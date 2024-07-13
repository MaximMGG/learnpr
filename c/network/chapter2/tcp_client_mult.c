#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>


#include <stdio.h>
#include <errno.h>
#include <string.h>


#define ERR(...) fprintf(stderr, __VA_ARGS__)


int main() {
    struct addrinfo hints;
    hints.ai_flags = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    struct addrinfo *con;

    if(getaddrinfo("127.0.0.1", "8080", &hints, &con) == -1) {
        ERR("Getaddrifno error %d\n", errno);
        return 1;
    }

    int con_socket = socket(con->ai_family, con->ai_socktype, con->ai_protocol);

    if (con_socket == -1) {
        ERR("Creating socket error %d\n", errno);
        return 1;
    }

    if (connect(con_socket, con->ai_addr, con->ai_addrlen) == -1) {
        ERR("Connecting error %d\n", errno);
        return 1;
    }

    char buf[1024] = {0};
    sprintf(buf, "%s", "Hello from client\n");
    int sent_byte = send(con_socket, buf, 1024, 0);
    if (sent_byte <= 0) {
        ERR("send error %d\n", errno);
        return 1;
    }

    memset(buf, 0, 1024);

    sent_byte = recv(con_socket, buf, 1024, 0);
    if (sent_byte <= 0) {
        ERR("Recv error %d\n", errno);
        return 1;
    } else {
        printf("Server response if %s\n", buf);
    }


    close(con_socket);


    return 0;
}
