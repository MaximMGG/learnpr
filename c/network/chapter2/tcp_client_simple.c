#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

#include <stdio.h>

#define ERR() fprintf(stderr, "Error in the line %d\n", __LINE__ - 1); return 1

char PORT[16] = "6000";


int main(int argc, char **argv) {

    if (argc > 1) {
        strcpy(PORT, argv[1]);
    }

    struct addrinfo hints = {0}, *con;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo("127.0.0.1", PORT, &hints, &con) == -1) {
        ERR();
    }

    int con_sock = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (con_sock == -1) {
        ERR();
    } 

    if (connect(con_sock, con->ai_addr, con->ai_addrlen) == -1) {
        ERR();
    }

    freeaddrinfo(con);


    int ddos_server = 3;
    if (argc > 1) {
        if (strcmp(argv[1], "-d") == 0) {
            ddos_server = atoi(argv[2]);
        }
    }

    while(ddos_server--) {
        char msg[100] = "Hello from client";
        char buf[512] = {0};
        int bc = send(con_sock, msg, strlen(msg), 0);
        if (bc < 1) {
            ERR();
        }

        bc = recv(con_sock, buf, 512, 0);
        if (bc < 1) {
            close(con_sock);
            ERR();
        }

        printf("Response from server is %.*s\n", bc, buf);
    }


    close(con_sock);
    return 0;
}
