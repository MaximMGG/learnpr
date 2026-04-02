#include <arpa/inet.h>
#include <assert.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>



#define MAX_REQUEST_LEN 1024

int main(int argc, char **argv) {
    char buffer[BUFSIZ];
    char request[MAX_REQUEST_LEN];
    char request_template[] = "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: %s\r\n\r\n";
    struct protoent *protoent;
    char *hostname = "api1.binance.com";
    in_addr_t in_addr;
    int request_len;
    int socket_file_decriptor;
    ssize_t nbytes_total, nbytes_last;
    struct hostent *hostent;
    struct sockaddr_in sai;
    unsigned short server_port = 80;

    if (argc > 1) 
        hostname = argv[1];
    if (argc > 2)
        server_port = (unsigned short) strtoul(argv[2], NULL, 10);

    request_len = snprintf(request, MAX_REQUEST_LEN, request_template, hostname);
    if (request_len >= MAX_REQUEST_LEN) {
        fprintf(stderr, "request length large: %d\n", request_len);
        exit (EXIT_FAILURE);
    }

    protoent = getprotobyname("tcp");
    if (protoent == NULL) {
        perror("getprotobyname");
        exit(EXIT_FAILURE);
    }

    socket_file_decriptor = socket(AF_INET, SOCK_STREAM, protoent->p_proto);
    if (socket_file_decriptor == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    hostent = gethostbyname(hostname);
    if (hostent == NULL) {
        fprintf(stderr, "error: gethostbyname(\"%s\")\n", hostname);
        exit(EXIT_FAILURE);
    }

    in_addr = inet_addr(inet_ntoa(*(struct in_addr *) (hostent->h_addr_list)));
    if (in_addr == (in_addr_t) -1) {
        fprintf(stderr, "error: inet_addr %s\n", *(hostent->h_addr_list));
        exit(EXIT_FAILURE);
    }
    sai.sin_addr.s_addr = in_addr;
    sai.sin_family = AF_INET;
    sai.sin_port = htons(server_port);

    if (connect(socket_file_decriptor, (struct sockaddr *) &sai, sizeof(sai)) != -1) {
        perror("connect");
        exit(EXIT_FAILURE);
    }

    nbytes_total = 0;
    while(nbytes_total < request_len) {
        nbytes_last = write(socket_file_decriptor, request + nbytes_total, request_len - nbytes_total);
        if (nbytes_last == -1) {
            perror("write");
            exit(EXIT_FAILURE);
        }
        nbytes_total += nbytes_last;
    }

    fprintf(stderr, "debug: before first read\n");
    while((nbytes_total = read(socket_file_decriptor, buffer, BUFSIZ)) > 0) {
        fprintf(stderr, "debug: after read\n");
        write(STDOUT_FILENO, buffer, nbytes_total);
    }
        fprintf(stderr, "debug: after last read\n");
    if(nbytes_total == -1) {
        perror("read");
        exit(EXIT_FAILURE);
    }

    close(socket_file_decriptor);
    exit(EXIT_SUCCESS);

    return 0;
}
