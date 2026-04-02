


#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0600
#endif
#include <winsock2.h>
#include <ws2tcpip.h>

#else
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <errno.h>
#endif

#ifdef _WIN32
#define ISVALIDSOCKET(s) ((s) != INVALID_SOCKET)
#define CLOSESOCKET(s) closesocket(s)
#define GETSOCKETERRNO() (WSAGetLastError())

#ifndef IPV6_V6ONLY
#define IPV6_V6ONLY 27
#endif

#else
#define ISVALIDSOCKET(s) ((s) >= 0)
#define CLOSESOCKET(s) close(s)
#define SOCKET int
#define GETSOCKETERRNO() (errno)
#endif

#include <stdio.h>
#include <string.h>


int main() {
    
#ifdef _WIN32
    WSADATA d;
    if (WSAStartup(MAKEWORD(2, 2), &d)) {
        fprintf(stderr, "Failed to initialize.\n");
        return 1;
    }
#endif

    printf("Configuring client...\n");
    struct addrinfo hints = {0};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    struct addrinfo *bind_address;
    getaddrinfo("127.0.0.1", "8080", &hints, &bind_address);

    printf("Creating client socket...\n");

    SOCKET client_sock;
    client_sock = socket(bind_address->ai_family, bind_address->ai_socktype, bind_address->ai_protocol);
    if (!ISVALIDSOCKET(client_sock)) {
        fprintf(stderr, "socket() faild. (%d)\n", GETSOCKETERRNO());
        return 1;
    }
    printf("Connectiog to server...\n");

    int con = connect(client_sock, bind_address->ai_addr, bind_address->ai_addrlen);

    const char *request = 
        "HTTP/1.1 GET /\r\n"
        "Content-Type: text/plain\r\n\r\n";

    int byte_sent = send(client_sock, request, strlen(request), 0);

    printf("Send %d of %d bytes\n", byte_sent, (int)strlen(request));

    char buf[1024];

    int receive_byte = recv(client_sock, buf, 1024, 0);
    printf("Received %d bytes.\n", receive_byte);

    printf("%.*s", 1024, buf);

    freeaddrinfo(bind_address);
    CLOSESOCKET(client_sock);

#ifdef _WIN32
    WSACleanup();
#endif

    return 0;
}

