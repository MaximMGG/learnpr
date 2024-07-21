#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#include <time.h>

#define ERR(msg) fprintf(stderr, "Error: line: %d, message: %s\n", __LINE__ - 1, msg)
#define LOCAL_HOST 0
#define LOG(msg) printf("%s...\n", msg)
#define BUFFER_SIZE 1024
#define SET_BUF(buf) memset(buf, 0, BUFFER_SIZE)

char PORT[16] = "6000";

typedef struct {
    char name[128];
    time_t start_time;
    time_t end_time;
} client;

static void toupper_local(char *msg) {
    int msgl = strlen(msg);

    for(int i = 0; i < msgl; i++) {
        if (msg[i] >= 'a' && msg[i] <= 'z') {
            msg[i] -= 32;
        }
    }
}


int main(int argc, char **argv) {
    if (argc > 1) {
        strcpy(PORT, argv[1]);
    }
    struct addrinfo hints = {0}, *con;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    LOG("Init");
    if (getaddrinfo(LOCAL_HOST, PORT, &hints, &con) == -1) {
        ERR("getaddrinfo");
        return 1;
    }
    LOG("Create socket");
    int listen_socket = socket(con->ai_family, con->ai_socktype, con->ai_protocol);
    if (listen_socket == -1) {
        ERR("Create socket");
        return 1;
    }
    LOG("Bind socket");
    if (bind(listen_socket, con->ai_addr, con->ai_addrlen) == -1) {
        ERR("Bind socket");
        return 1;
    }

    freeaddrinfo(con);

    LOG("Listening socket");
    if (listen(listen_socket, 10) == -1) {
        ERR("Listening");
        return 1;
    }

    fd_set master, reads;
    FD_ZERO(&master);
    FD_SET(listen_socket, &master);
    int max_socket = listen_socket;
    client c1 = {0};


    while(1) {
        reads = master;
        if (select(max_socket + 1, &reads, 0, 0, 0) < 0) {
            ERR("select");
            close(listen_socket);
            return 1;
        }
        for(int i = 0; i <= max_socket; i++) {
            if (FD_ISSET(i, &reads) > 0) {
                if (i == listen_socket) {
                    struct sockaddr_storage saddr = {0};
                    socklen_t saddrlen = sizeof(saddr);
                    int new_con = accept(i, (struct sockaddr *) &saddr, &saddrlen);
                    if (new_con == -1) {
                        printf("Error create new connection\n");
                        continue;
                    }

                    FD_SET(new_con, &master);
                    if (new_con > max_socket) {
                        max_socket = new_con;
                    }

                    char con_name[128] = {0};
                    getnameinfo((struct sockaddr *) &saddr, saddrlen, con_name, 128, 0, 0, NI_NUMERICHOST);
                    printf("New connection: %s\n", con_name);

                    strcpy(c1.name, con_name);
                    time(&c1.start_time);
                    
                } else {
                    int bc = 0;
                    char buf[BUFFER_SIZE] = {0};

                    bc = recv(i, buf, BUFFER_SIZE, 0);

                    if (bc < 1) {
                        FD_CLR(i, &master);
                        close(i);

                        time(&c1.end_time);

                        printf("Client was connected %ld ms\n", ((c1.end_time - c1.start_time) * 1000) / CLOCKS_PER_SEC);

                        continue;
                    }

                    printf("Request from client: %d bytes, text - %.*s\n", bc, bc, buf);

                    toupper_local(buf);

                    bc = send(i, buf, strlen(buf), 0);
                    printf("Sent %s\n", buf);
                }
            }
        }
    }



    close(listen_socket);

    return 0;
}
