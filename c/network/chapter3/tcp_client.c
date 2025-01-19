#include "sock.h"
#include <stdlib.h>


int main(int argc, char **argv) {

    if (argc < 3) {
        fprintf(stderr, "No input port\n");
        return EXIT_FAILURE;
    }
    printf("Configuring remote address...\n");
    struct addrinfo hints;
    memset(&hints, 0, sizeof(hints));
    hints.ai_socktype = SOCK_STREAM;
    struct addrinfo *pear_address;

    if (getaddrinfo(argv[1], argv[2], &hints, &pear_address)) {
        fprintf(stderr, "getaddrinfo failed (%d)\n", GETSOCKETERRNO);
        return EXIT_FAILURE;
    }

    printf("Remote address is: ");
    char address_buffer[100] = {0};
    char service_buffer[100] = {0};
    getnameinfo(pear_address->ai_addr, pear_address->ai_addrlen, 
            address_buffer, sizeof(address_buffer),
            service_buffer, sizeof(service_buffer), NI_NUMERICHOST);
    printf("%s %s\n", address_buffer, service_buffer);

    printf("Creating socket... \n");
    SOCKET socket_pear = socket(pear_address->ai_family, pear_address->ai_socktype, pear_address->ai_protocol);
    if (!ISVALIDSOCKET(socket_pear)) {
        fprintf(stderr, "socket() fail %d\n", GETSOCKETERRNO);
        return EXIT_FAILURE;
    }

    freeaddrinfo(pear_address);

    printf("Connected.\n");
    printf("To send data, enter text followed by enter. \n");


    while(1) {
        fd_set reads;
        FD_ZERO(&reads);
        FD_SET(socket_pear, &reads);
#if !defined(__WIN32)
        FD_SET(0, &reads);
#endif

        struct timeval timeout;
        timeout.tv_sec = 0;
        timeout.tv_usec = 100000;

        if (select(socket_pear + 1, &reads, 0, 0, &timeout) < 0) {
            fprintf(stderr, "select() failed (%d)\n", GETSOCKETERRNO);
            return EXIT_FAILURE;
        }

        if (FD_ISSET(socket_pear, &reads)) {
            char read[4096] = {0};
            if (!fgets(read, 4096, stdin)) {
                break;
            }

            printf("Sending %s\n", read);
            int bytes_sent = send(socket_pear, read, strlen(read), 0);
            printf("Sent %d bytes\n", bytes_sent);
        }
    } //end while(1)
    
    printf("Closing socket...\n");
    CLOSESOCKET(socket_pear);

    printf("Finished\n");

    return 0;
}
