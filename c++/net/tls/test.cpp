#include <iostream>
#include <openssl/ssl.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <openssl/err.h>
#include <unistd.h>


#define HOST "google.com"
#define PORT "443"
#define REQUEST "GET / HTTP/1.1\r\nHost: google.com\r\nConnection: close\r\n\r\n"

int main() {
    SSL_library_init();
    SSL_load_error_strings();
    OpenSSL_add_ssl_algorithms();

    SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
    if (!ctx) {
        std::cerr << "Create new CTX error\n";
        return 1;
    }

    struct addrinfo hints{0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    if (getaddrinfo(HOST, PORT, &hints, &res) != 0) {
        std::cerr << "getaddrinfo failed\n";
        return 1;
    }

    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock < 0) {
        std::cerr << "socket error\n";
        return 1;
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen) != 0) {
        std::cerr << "connect error\n";
        close(sock);
        return 1;
    }
    
    SSL *ssl = SSL_new(ctx);
    SSL_set_fd(ssl, sock);

    if (SSL_connect(ssl) <= 0) {
        ERR_print_errors_fp(stderr);
        close(sock);
        return 1;
    }

    SSL_write(ssl, REQUEST, strlen(REQUEST));
    char buf[4096]{0};
    int bytes{};

    bytes = SSL_read(ssl, buf, 4096);

    char *s = strstr(buf, "\r\n\r\n");

    std::cout << "Read bytes: " << bytes << "\n" << s << '\n';

    SSL_shutdown(ssl);
    SSL_free(ssl);
    close(sock);
    SSL_CTX_free(ctx);
    EVP_cleanup();
    

    return 0;
}
