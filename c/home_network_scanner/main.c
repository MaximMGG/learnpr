#include <stdio.h>
#include <string.h>
#include <unistd.h>
//#include <pthread.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <limits.h>
#include <stdint.h>


#define GET_MSG "GET / HTTP/1.1\r\n\r\n"


void try_connect(struct addrinfo *hints, char *ip, unsigned short port) {
    char buf_port[32] = {0};
    sprintf(buf_port, "%d", port);
    struct addrinfo *res;

    if (getaddrinfo(ip, buf_port, hints, &res) < 0) {
        //fprintf(stderr, "Cant getaddrinfo to ip - %s, port %s\n", ip, buf_port);
        return;
    }

    int con_sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (con_sock == -1) {
        //fprintf(stderr, "Cant create socket ip - %s, port %s\n", ip, buf_port);
        return;
    }

    if (connect(con_sock, res->ai_addr, res->ai_addrlen) == -1) {
        //fprintf(stderr, "Cant connected to sock - %d ip - %s, por - %s\n", con_sock, ip, buf_port);
        close(con_sock);
        return;
    }

    int sent_bytes = send(con_sock, GET_MSG, strlen(GET_MSG), 0);
    if (sent_bytes != -1) {
        printf("Sent %d bytes to %s:%s\n", sent_bytes, ip, buf_port);

        char rec_buf[1024] = {0};

        int received_bytes = recv(con_sock, rec_buf, 1024, 0);
        if (received_bytes > 0) {
            printf("Answer from server - %d bytes %s\n", received_bytes, rec_buf);
        }
    }
    close(con_sock);
    freeaddrinfo(res);
}




int main() {
    printf("Start scanning\n");
    unsigned short port = 0;

    // while(port < 1) {
    //     struct addrinfo hints = {0};
    //     hints.ai_socktype = SOCK_STREAM;
    //     hints.ai_family = AF_INET;
    //     hints.ai_flags = AI_PASSIVE;
    //     try_connect(&hints, "192.168.0.1", 1900);
    //     port++;
    // }

    while(port != UINT16_MAX) {
        struct addrinfo hints = {0};
        hints.ai_socktype = SOCK_STREAM;
        hints.ai_family = AF_INET;
        hints.ai_flags = AI_PASSIVE;
        try_connect(&hints, "192.168.0.1", port);
        port++;
    }


    printf("End scanning\n");
    return 0;
}
