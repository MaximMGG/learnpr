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
    struct addrinfo hints = {0};
    hints.ai_flags = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    struct addrinfo *con;

    if(getaddrinfo("127.0.0.1", "8080", &hints, &con) == -1) {
        ERR("Getaddrifno error %d\n", errno);
        return 1;
    }


    char address_buffer[100];
    char service_buffer[100];

    getnameinfo(con->ai_addr, con->ai_addrlen, address_buffer, 100, service_buffer, 100, NI_NUMERICHOST);

    printf("%s %s\n", address_buffer, service_buffer);


    printf("Creating socket...\n");

    int con_socket = socket(con->ai_family, con->ai_socktype, con->ai_protocol);

    if (con_socket == -1) {
        ERR("Creating socket error %d\n", errno);
        return 1;
    }

    puts("Connecting...");
    if (connect(con_socket, con->ai_addr, con->ai_addrlen) == -1) {
        ERR("Connecting error %d\n", errno);
        return 1;
    }

    freeaddrinfo(con);

    puts("Connected");

    //-------------------

    while(1) {
        fd_set reads;
        FD_ZERO(&reads);
        FD_SET(con_socket, &reads);


        struct timeval timeout;
        timeout.tv_sec = 0;
        timeout.tv_usec = 100000;

        if (select(con_socket + 1, &reads, 0, 0, &timeout) < 0) {
            ERR("select() error %d\n", errno);
            return 1;
        }


        if (FD_ISSET(con_socket, &reads)) {
            char read[64] = "Hello from client!!!";

            int send_bytes = send(con_socket, read, strlen(read), 0);
            if (send_bytes < 1) {
                ERR("send error %d\n", errno);
                return 1;
            }

            char buf[1024] = {0};

            recv(con_socket, buf, 1024, 0);

            printf("Server response is %.*s\n", (int) strlen(buf), buf);


        }


        // if (FD_ISSET(con_socket, &reads)) {
        //     char read[4096];
        //     int bytes_reseived = recv(con_socket, read, 4096, 0);
        //
        //     if (bytes_reseived < 1) {
        //         printf("Connection closed by peer.\n");
        //         break;
        //     }
        //     printf("Reveived %d bytes: %.*s", bytes_reseived, bytes_reseived, read);
        //
        // }
        //
        // if (FD_ISSET(0, &reads)) {
        //     char read[4096];
        //     strcpy(read, "Hello from client");
        //
        //     int bytes_sent = send(con_socket, read, strlen(read), 0);
        //
        // }

    }

    printf("Closing socket...\n");


    //--------------

    close(con_socket);


    return 0;
}
