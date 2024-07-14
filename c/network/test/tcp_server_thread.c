#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>
#include <pthread.h>

#define SOCKET int
#define ERR(msg) fprintf(stderr, "ERROR: %s %d\n", msg, __LINE__)

#define RESPONSE "OK 200 HTTP/1.1\r\n\r\n"

void *connection_work(void *fd) {
    SOCKET new_s = *(int *) fd;
    char buf[512];
    int b_c = recv(new_s, buf, 512, 0);
    if (b_c < 1) {
        close(new_s);
        return NULL;
    } 
    printf("Received %d bytes: %.*s\n", b_c, b_c, buf);

    b_c = send(new_s, RESPONSE, strlen(RESPONSE), 0);

    printf("Sended %d bytes\n", b_c);
    return NULL;
}



int main() {

    pthread_t worker;
    struct addrinfo hints = {0}, *con;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;
    if (getaddrinfo(0, "7000", &hints, &con)) {
        ERR("getaddrifno error");
        return 1;
    }
    puts("Create socket...");
    SOCKET listen_socket = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (listen_socket == -1) {
        ERR("socket() error");
        return 1;
    }
    puts("Binding socket...");
    if (bind(listen_socket, con->ai_addr, con->ai_addrlen) == -1) {
        ERR("bind() error");
        return 1;
    }
    puts("Listening connections...");
    if(listen(listen_socket, 10) == -1) {
        ERR("listen() error");
        return 1;
    }
    freeaddrinfo(con);

    while(1) {
        struct sockaddr_storage new_addr = {0};
        socklen_t addrlen = sizeof(new_addr);
        SOCKET new_s = accept(listen_socket, (struct sockaddr *) &new_addr, &addrlen);

        pthread_create(&worker, NULL, connection_work, &new_s);
        pthread_detach(worker);
    }

    close(listen_socket);

    return 0;
}
