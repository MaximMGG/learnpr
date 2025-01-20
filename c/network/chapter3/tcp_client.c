#include "sock.h"

#if defined(_WIN32)
#include <conio.h>
#endif

int main(int argc, char *argv[]) {

#if defined(_WIN32)
    WSADATA d;
    if (WSAStartup(MAKEWORD(2, 2), &d)) {
        fprintf(stderr, "Failed to initialize.\n");
        return 1;
    }
#endif

    if (argc < 3) {
        fprintf(stderr, "usage: udp_client hostname port\n");
        return 1;
    }

    printf("Configuring remote address...\n");
    struct addrinfo hints;
    memset(&hints, 0, sizeof(hints));
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_family = AF_INET;
    hints.ai_flags = AI_PASSIVE;
    struct addrinfo *peer_address;
    if (getaddrinfo(argv[1], argv[2], &hints, &peer_address)) {
        fprintf(stderr, "getaddrinfo() failed. (%d)\n", GETSOCKETERRNO);
        return 1;
    }


    printf("Remote address is: ");
    char address_buffer[100];
    char service_buffer[100];
    getnameinfo(peer_address->ai_addr, peer_address->ai_addrlen,
            address_buffer, sizeof(address_buffer),
            service_buffer, sizeof(service_buffer),
            NI_NUMERICHOST);
    printf("%s %s\n", address_buffer, service_buffer);


    printf("Creating socket...\n");
    SOCKET socket_peer;
    socket_peer = socket(peer_address->ai_family,
            peer_address->ai_socktype, peer_address->ai_protocol);
    if (!ISVALIDSOCKET(socket_peer)) {
        fprintf(stderr, "socket() failed. (%d)\n", GETSOCKETERRNO);
        return 1;
    }


    printf("Connecting...\n");
    if (connect(socket_peer,
                peer_address->ai_addr, peer_address->ai_addrlen)) {
        fprintf(stderr, "connect() failed. (%d)\n", GETSOCKETERRNO);
        return 1;
    }
    freeaddrinfo(peer_address);

    printf("Connected.\n");
    printf("To send data, enter text followed by enter.\n");

    int ones = 1;
    int not_recv = 1;
    while(ones) {

        fd_set reads;
        fd_set writes;
        FD_ZERO(&writes);
        FD_ZERO(&reads);
        FD_SET(socket_peer, &reads);
        FD_SET(socket_peer, &writes);
#if !defined(_WIN32)
#endif

        struct timeval timeout;
        timeout.tv_sec = 0;
        timeout.tv_usec = 100000;

        int selected  = select(socket_peer + 1, &reads, &writes, 0, &timeout);
        //printf("selected - %d\n", selected);
        if (selected == -1) {
            fprintf(stderr, "select() failed. (%d)\n", GETSOCKETERRNO);
            return 1;
        }

        if (FD_ISSET(socket_peer, &reads)) {
            char read[4096];
            int bytes_received = recv(socket_peer, read, 4096, 0);
            if (bytes_received < 1) {
                printf("Connection closed by peer.\n");
                break;
            }
            printf("Received (%d bytes): %.*s",
                    bytes_received, bytes_received, read);
            not_recv = 1;
            ones = 0;
        }



#if defined(_WIN32)
        if(_kbhit()) {
#else
        if(FD_ISSET(socket_peer, &writes)) {
            //printf("Ready for sending\n");
            if (not_recv) {
#endif
                char read[4096];
                //if (!fgets(read, 4096, stdin)) break;
                strcpy(read, "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n");
                printf("Sending: %s", read);
                int bytes_sent = send(socket_peer, read, strlen(read), 0);
                printf("Sent %d bytes.\n", bytes_sent);

                // memset(read, 0, 4096);
                //
                // int bytes_recv = recv(socket_peer, read, 4096, 0);
                // printf("Bytes received %d\n", bytes_recv);
                // printf("%s\n", read);

                not_recv = 0;
            }
        }
    } //end while(1)

    printf("Closing socket...\n");
    CLOSESOCKET(socket_peer);

#if defined(_WIN32)
    WSACleanup();
#endif

    printf("Finished.\n");
    return 0;
}

