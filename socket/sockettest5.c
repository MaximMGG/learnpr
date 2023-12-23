#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>



int main() {

    int status;
    int FD;
    struct addrinfo req, *res;

    memset(&req, 0, sizeof(req));
    req.ai_flags = AF_UNSPEC;
    req.ai_socktype = SOCK_STREAM;

    status = getaddrinfo("api1.binance.com", "3490", &req, &res);
    if (status < 0) {
        fprintf(stderr, "getaddrinfo error %s\n", gai_strerror(status));
    }
    FD = socket(res->ai_family, res->ai_socktype, res->ai_protocol);


    status = connect(FD, res->ai_addr, res->ai_addrlen);

    if (status < 0) {
        fprintf(stderr, "connection error %s\n", gai_strerror(status));
    }


    freeaddrinfo(res);

    return 0;
}
