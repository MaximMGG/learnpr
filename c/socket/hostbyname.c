#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>


#define POSRT 4950

int main() {
    
    int sockfd;
    struct sockaddr_in t_addr;
    struct hostent *he;

    int numbytes = 0;
    int broadcast = 1;

    if ((he = gethostbyname("www.google.com")) == NULL) {
        perror("gethostbyname");
        exit(1);
    }

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("sockfd");
        exit(1);
    }

    if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast)) == -1) {
        perror("setsockopt (SO_BROADCAST)");
        exit(1);
    }

    t_addr.sin_family = AF_INET;
    t_addr.sin_port = htons(POSRT);
    t_addr.sin_addr = *((struct in_addr *)he->h_addr);
    memset(t_addr.sin_zero, '\0', sizeof(t_addr.sin_zero));

    printf("%s\n", he->h_name);

    close(sockfd);

    return 0;
}
