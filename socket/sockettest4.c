#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <string.h>



int main() {

    int status;
    int FD;
    struct addrinfo req, *res;
    memset(&req, 0, sizeof(req));

    req.ai_family = AF_UNSPEC;
    req.ai_socktype = SOCK_STREAM;
    req.ai_flags = AI_PASSIVE; // host IP


    if ((status = getaddrinfo(NULL, "3490", &req, &res))) {
        fprintf(stderr, "getaddrinfo fail %s\n", gai_strerror(status));
        return 1;
    }

    FD = socket(res->ai_family, res->ai_socktype, res->ai_protocol);

    status = bind(FD, res->ai_addr, res->ai_addrlen);
    if (status < 0) {
        fprintf(stderr, "bind error %s\n", gai_strerror(status));
    }

    freeaddrinfo(res);
}
