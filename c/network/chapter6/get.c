#include "sock.h"


void parse_url(char *url, char **hostname, char **port, char **path) {
    printf("URL: %s\n", url);
    
    char *p = strstr(url, "://");

    char *protocol = 0;
    if (p) {
        protocol = url;
        *p = 0;
        p += 3;
    } else {
        p = url;
    }

    if (protocol) {
        if (strcmp(protocol, "http")) {
            fprintf(stderr, "Unknown protocol %s, only http is supported\n", protocol);
            exit(EXIT_FAILURE);
        }
    }

    *hostname = p;

    while(*p && *p != ':' && *p != '/' && *p != '#') p++;

    *port = "80";
    if (*p == ':') {
        *(p++) = 0;
        *port = p;
    }
    while(*p && *p != '/' && *p != '#') p++;

    *path = p;
    if (*p == '/') {
        *path = p + 1;
    }
    *p = 0;

    while(*p && *p == '#') p++;
    if (*p == '#') *p = 0;

    printf("hostname: %s\n", *hostname);
    printf("port: %s\n", *port);
    printf("path: %s\n", *path);
}






int main(int argc, char **argv) {



    return 0;
}
