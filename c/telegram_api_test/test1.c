#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>

#define TOKEN "7822096798:AAEBztEDKoWcYQnn-UgEBu8Kn7Uiywr3dmk"




int main() {
    struct addrinfo hints = {0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if (getaddrinfo("api.telegram.org", "8080", &hints, &res) != 0) {
        fprintf(stderr, "getaddrinfo error\n");
        return 1;
    }

    int s = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (s < 1) {
        fprintf(stderr, "socket error\n");
        return 1;
    }

    if (connect(s, res->ai_addr, res->ai_addrlen) < 0) {
        fprintf(stderr, "connect error");
    }

    freeaddrinfo(res);

    char buf[512] = {0};
    sprintf(buf, "GET /bot%s/getMe HTTP/1.1\r\n\r\n", TOKEN);

    int send_bytes = send(s, buf, 512, 0);
    if (send_bytes < 1) {
        fprintf(stderr, "send error\n");
        close(s);
        return 1;
    }

    char resive[2048] = {0};
    int bytes_resv = recv(s, resive, 2048, 0);
    if (bytes_resv < 1) {
        fprintf(stderr, "recv error\n");
        close(s);
        return 1;
    }

    printf("%s\n", resive);

    return 0;
}
