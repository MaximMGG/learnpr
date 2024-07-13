#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>


#define ERR() fprintf(stderr, "Fail in %d line", __LINE__ - 1)


void *sendrecvdata(void *fd) {
    int client_socket = *(int *) fd;

    char buf[1024] = {0};
    int bytes_count = recv(client_socket, buf, 1024, 0);

    if (bytes_count < 1) {
        ERR();
        close(client_socket);
    }

    strcpy(buf, "Hello from server");

    bytes_count = send(client_socket, buf, strlen(buf), 0);

    if (bytes_count < 1) {
        ERR();
    }
}



int main() {

    struct addrinfo hints = {0}, *con;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo(0, "5000", &hints, &con) == -1) {
        ERR();
    }

    puts("Create socket");
    int listen_sock = socket(con->ai_family, con->ai_socktype, con->ai_protocol);

    if(listen_sock == -1) {
        ERR();
    }
    puts("Bind socket");
    if (bind(listen_sock, con->ai_addr, con->ai_addrlen) == -1) {
        ERR();
    }
    puts("Listen socket");
    if (listen(listen_sock, 10) == -1) {
        ERR();
    }

    while(1) {

        //int sock_f = accept(listen_sock, con->ai_addr, con->ai_addrlen);

    }



    return 0;
}
