#include "sock.h"
#include <time.h>


#define TIMEOUT 5.0


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


void send_request(SOCKET s, char* hostname, char* port, char  *path) {
    char buffer[2048] = {0};

    sprintf(buffer, "GET /%s HTTP/1.1\r\n", path);
    sprintf(buffer + strlen(buffer), "Host: %s:%s\r\n", hostname, port);
    sprintf(buffer + strlen(buffer), "Connetion: close\r\n");
    sprintf(buffer + strlen(buffer), "User-Agent: honpwc web_get 1.0\r\n");
    sprintf(buffer + strlen(buffer), "\r\n");

    send(s, buffer, strlen(buffer), 0);
    printf("Sent Headers; \n%s\n", buffer);
}

SOCKET connect_to_host(char* hostname, char* port) {
    printf("Configuring remote address...\n");
    struct addrinfo hints = {0};
    hints.ai_socktype = SOCK_STREAM;
    struct addrinfo *peer_address;
    if (getaddrinfo(hostname, port, &hints, &peer_address)) {
        fprintf(stderr, "getaddrinfo() failed. (%d)\n", GETSOCKETERRNO);
        exit(EXIT_FAILURE);
    }
    printf("Remote address is: ");
    char address_buffer[100];
    char service_buffer[100];
    getnameinfo(peer_address->ai_addr, peer_address->ai_addrlen, 
                address_buffer, sizeof(address_buffer),
                service_buffer, sizeof(service_buffer), NI_NUMERICHOST);

    printf("%s %s\n", address_buffer, service_buffer);

    printf("Creating socket...\n");
    SOCKET server = socket(peer_address->ai_family, peer_address->ai_socktype, peer_address->ai_protocol);
    if (!ISVALIDSOCKET(server)) {
        fprintf(stderr, "socket() failed. (%d)\n", errno);
        freeaddrinfo(peer_address);
        exit(EXIT_FAILURE);
    }
    printf("Connecting...\n");
    if (connect(server, peer_address->ai_addr, peer_address->ai_addrlen)) {
        fprintf(stderr, "connect() failed. (%d)\n", errno);
        close(server);
        freeaddrinfo(peer_address);
        exit(EXIT_FAILURE);
    }

    freeaddrinfo(peer_address);
    return server;
}





int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: web_get url\n");
        return EXIT_FAILURE;
    }
    char *url = argv[1];
    char *hostname, *port, *path;
    parse_url(url, &hostname, &port, &path);
    SOCKET server = connect_to_host(hostname, port);
    send_request(server, hostname, port, path);

    const clock_t start_time = clock();

#define RESPONSE_SIZE 8192
    char response[RESPONSE_SIZE + 1];
    char *p = response, *q;
    char *end = response + RESPONSE_SIZE;
    char *body = 0;

    enum {length, chunked, connection};
    int encoding = 0;
    int remaining = 0;

    while(1) {
        if ((double)(clock() - start_time) / CLOCKS_PER_SEC > TIMEOUT) {
            fprintf(stderr, "timeout after %.2f seconds\n", TIMEOUT);
            close(server);
            return EXIT_FAILURE;
        }

        if (p == end) {
            fprintf(stderr, "out of buffer space\n");
            close(server);
            return EXIT_FAILURE;
        }

        fd_set reads;
        FD_ZERO(&reads);
        FD_SET(server, &reads);

        struct timeval timeout;
        timeout.tv_sec = 0;
        timeout.tv_usec = 200000;

        if (select(server + 1, &reads, 0, 0, &timeout) < 0) {
            fprintf(stderr, "select() failed. (%d)\n", errno);
            close(server);
            return EXIT_FAILURE;
        }
        if (FD_ISSET(server, &reads)) {
            int bytes_received = recv(server, p, end - p, 0);
            if (bytes_received < 1) {
                if (encoding == connection && body) {
                    printf("%.*s", (int)(end - body), body);
                }
            }
            p += bytes_received;
            *p = 0;
        }
        if (!body && (body = strstr(response, "\r\n\r\n"))) {
            *body = 0;
            body += 4;

            printf("Received Headers:\n%s\n", response);


            q = strstr(response, "\nContent-Length: ");
            if (q) {
                encoding = length;
                q = strstr(q, " ");
                q += 1;
                remaining = strtol(q, 0, 10);
            } else {
                q = strstr(response, "\nTransfer-Encoding: chunked");
                if (q) {
                    encoding = chunked;
                    remaining = 0;
                } else {
                    encoding = connection;
                }
            }
            printf("\nReceived Body:\n");
        }

        if (body) {
            if (encoding == length) {
                if ((p - body) >= remaining) {
                    printf("%.*s", remaining, body);
                    break;
                }
            } else if (encoding == chunked) {
                do {
                    if (remaining == 0) {
                        if ((q = strstr(body, "\r\n"))) {
                            remaining = strtol(body, 0, 16);
                            if (!remaining) goto finish;
                            body = q + 2;
                        } else {
                            break;
                        }

                    }
                    if (remaining && p - body >= remaining) {
                        printf("%.*s", remaining, body);
                        body += remaining + 2;
                        remaining = 0;
                    }

                } while(!remaining);

            } 

        }

    }

finish:

    printf("\nClosing socket...");
    close(server);
    printf("Finished.\n");


    return 0;
}
