#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <arpa/inet.h>


int main(int argc, char **argv) {

    if (argc < 2) {
        perror("argv < 2");
        exit(1);
    }

    struct sockaddr_in in;
    int fd;

    in.sin_family = AF_INET;
    in.sin_port = htons(80);
    fd = socket(AF_INET, SOCK_STREAM, 0);
    inet_aton(argv[1], &in.sin_addr);

    connect(fd, (struct sockaddr *) &in, sizeof(struct sockaddr_in));

    char request[] = "GET / HTTP/1.1\r\n\r\n";
    char respons[4096];

    send(fd, request, sizeof(request), 0);
    recv(fd, &respons, sizeof(respons), 0);

    printf("%s\n", respons);

    close(fd);

    return 0;
}
