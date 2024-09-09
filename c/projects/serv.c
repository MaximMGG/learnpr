#include <sys/socket.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


#define PROXY "127.0.0.1"
#define PROXYPORT 9050


int main() {

    int s;
    struct sockaddr_in sock = {0};

    sock.sin_family = AF_INET;
    sock.sin_port = htons(PROXYPORT);
    sock.sin_addr.s_addr = inet_addr(PROXY);

    s = socket(AF_INET, SOCK_STREAM, 0);
    
    if (bind(s, (struct sockaddr *) &sock, sizeof(sock))) {
        perror("bind");

        close(s);
        return 1;
    }
    if (listen(s, 10)) {
        perror("listen");
    };
    socklen_t socksize = sizeof(sock);
    int new = accept(s, (struct sockaddr *) &sock, &socksize);

    printf("New connection -> %d\n", new);


    char buf[512] = {0};

    recv(new, buf, 512, 0);
    close(new);
    close(s);

    return 0;
}
