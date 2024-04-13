#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/poll.h>
//#include <openssl/ssl.h>
#include <string.h>
//need to research it


#define HOST "www.youtube.com"
#define PORT "https"
#define HOST_PAGE "MaximMGG/"
#define GET_REQUEST  "GET /%s HTTP/1.1\r\nHost: %s\r\n\r\n"




int main() {

    int sockfd;
    struct addrinfo hints = {0}, *res, *p;
    int status;
    char buf[512];
    char *receve = (char *) malloc(sizeof(char) * 128);

    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;

    sockfd = socket(hints.ai_family, hints.ai_socktype, 0);
    if (sockfd < 0) {
        fprintf(stderr, "Socket not create\n");
        exit(1);
    }

    status = getaddrinfo(HOST, PORT, &hints, &res);
    if (status != 0) {
        fprintf(stderr, "host info not correct\n");
        close(sockfd);
        exit(1);
    }

    status = connect(sockfd, res->ai_addr, res->ai_addrlen);
    if (status != 0) {
        fprintf(stderr, "not connect\n");
        close(sockfd);
        exit(1);
    }

    snprintf(buf, 512, GET_REQUEST, "", HOST);
    send(sockfd, buf, strlen(buf), 0);

    struct pollfd u = {0};
    u.fd = sockfd;
    u.events = POLLIN;

    status = poll(&u, 1, 2000);
    char buf_c[2] = {0};
    char line[256] = {0};
    int line_c = 0;

    while(poll(&u, 1, 2000) > 0) {
        recv(sockfd, buf_c, 1, 0);
	if (buf_c[0] == '\n') {
	    if (strncmp("Content length", line, 14) == 0) {
		printf("%s\n", line);
            }
	    memset(line, 0, 256);
            line_c = 0;
        }
	line[line_c++] = buf_c[0];
    }

    freeaddrinfo(res);
    free(receve);

    return 0;
}
