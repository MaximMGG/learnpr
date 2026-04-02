#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>


#define PORT 80


int main(int argc, char **argv) { 
    if (argc < 2) {
        fprintf(stderr, "argc < 2\n");
        exit(1);
    }

    struct hostent *ht = gethostbyname(argv[1]);

    char *ip = inet_ntoa(*((struct in_addr *) ht->h_addr_list[0]));

    char header[512];
    int sockfd;
    struct sockaddr_in sa = {0};

    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    sa.sin_family = AF_INET;
    sa.sin_port = htons(PORT);
    inet_pton(AF_INET, ip, &(sa.sin_addr));

    printf("%d\n", sa.sin_addr.s_addr);

    if (connect(sockfd, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
        fprintf(stderr, "fail to connect\n");
        close(sockfd);
        exit(1);
    }

    snprintf(header, 512, "GET / HTTP/1.1\r\nHost: %s\r\n\r\n", argv[1]);
    printf("Header %s\n", header);

    int nr = send(sockfd, header, strlen(header), 0);

    if (nr) {
        printf("nr %d %lu\n", nr, strlen(header));
    }

    char *buf = (char *) calloc(4096, sizeof(char));
    size_t bytes_received = recv(sockfd, buf, 4096, 0);
    
    if (bytes_received > 0) {
        printf("%s\n", buf);
    }


    free(buf);
    close(sockfd);


    return 0;
}
