#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <stdio.h>


#define MY_PORT "3490"   // the  port users will be connection to
#define BACKLOG 10      // how many pending connections queue will hold

int main (void) {

    int status;
    int fd;
    int new_fd;
    socklen_t addr_size;
    struct addrinfo req, *res;
    struct sockaddr_storage their_addr;

    memset(&req, 0, sizeof(req));
    req.ai_family = AF_UNSPEC;
    req.ai_socktype = SOCK_STREAM;
    req.ai_flags = AI_PASSIVE;

    status = getaddrinfo(NULL, MY_PORT, &req, &res);
    if (status < 0) {
        fprintf(stderr, "getaddrinfo error %s\n", gai_strerror(status));
    }
    // make a socket, bind it and listen on it
    
    fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (fd < 0) {
        fprintf(stderr, "socket init error %s\n", gai_strerror(fd));
    }

    status = bind(fd, res->ai_addr, res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "bind init error %s\n", gai_strerror(status));
    }

    listen(fd, BACKLOG);

    //now accept an incoming connection;

    addr_size = sizeof(their_addr);

    new_fd = accept(fd, (struct sockaddr *) &their_addr, &addr_size);
    //ready to communicate on socket descriptor new_fd!

    freeaddrinfo(res);

    return 0;
}
