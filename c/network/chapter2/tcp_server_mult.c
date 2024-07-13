#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <errno.h>
#include <ctype.h>

#define ERR(...) fprintf(stderr, __VA_ARGS__)
#define SOCK_ERR -1


int main() {

    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    struct addrinfo *con;

    if (getaddrinfo("127.0.0.1", "8080", &hints, &con) == -1) {
        ERR("getaddr info fail %d\n", errno);
        return 1;
    }
    puts("Creating socket...");

    int listen_s = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (listen_s <= 0) {
        ERR("Create socket fail %d", errno);
        return 1;
    }
    puts("Binding socket to lokal addres...");
    if (bind(listen_s, con->ai_addr, con->ai_addrlen) == SOCK_ERR) {
        ERR("Binding error %d\n", errno);
        return 1;
    }
    puts("Listening socket...");
    if (listen(listen_s, 10) == SOCK_ERR) {
        ERR("listen error %d\n", errno);
        return 1;
    }

    fd_set set;
    FD_ZERO(&set);
    FD_SET(listen_s, &set);
    int max_socket = listen_s;

    while(1) {
        fd_set reads;
        reads = set;
        if (select(max_socket + 1, &reads, 0, 0, 0) < 0) {
            ERR("Select error %d\n", errno);
            return 1;
        }

        for(int i = 0; i < max_socket; i++) {
            if (FD_ISSET(i, &reads)) {
                printf("Find socket %d", i);
                if (i == listen_s) {
                    struct sockaddr_storage client_addres;
                    socklen_t addrlen = sizeof(client_addres);
                    int client_ac = accept(i, (struct sockaddr *) &client_addres, &addrlen);
                    if (client_ac < 0) {
                        ERR("accept error %d\n", errno);
                        return 1;
                    }

                    FD_SET(client_ac, &set);
                    if (client_ac > max_socket) {
                        max_socket = client_ac;
                    }
                    char buf[1024];
                    getnameinfo((struct sockaddr *) &client_addres, addrlen, buf, 1024, 0, 0, NI_NUMERICHOST);
                    printf("New connection %s\n", buf);
                } else {
                    char buf[1024];
                    int recvlen = recv(i, buf, 1024, 0);

                    if (recvlen <= 0) {
                        FD_CLR(i, &set);
                        close(i);
                        continue;
                    } else {
                        for(int j = 0; j < recvlen; j++) {
                            buf[j] = toupper(buf[j]);
                        }

                        send(i, buf, recvlen, 0);

                    }
                }
            }
        }
    }

    puts("Closing conection");
    close(listen_s);

    return 0;
}

