#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>



int main() {

    int status;
    struct addrinfo ai, *res;

    if((status = getaddrinfo("www.google.com", "https", &ai, &res)) != 0 ) {
        fprintf(stderr, "getaddrinfo error %s\n", gai_strerror(status));
        return 1;
    }

    status = socket(res->ai_family, res->ai_socktype, res->ai_protocol);



    freeaddrinfo(res);
}
