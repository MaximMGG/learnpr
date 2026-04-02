#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <string.h>

#include <openssl/crypto.h>
#include <openssl/x509.h>
#include <openssl/pem.h>
#include <openssl/ssl.h>
#include <openssl/err.h>


#define GET_MSG "GET /api/v3/ticker?symbol=BTCUSDT HTTP1.1\r\nHost: api.binance.com\r\n\r\n"

int main() {

    SSL_library_init();
    SSL_load_error_strings();
    OpenSSL_add_ssl_algorithms();

    struct addrinfo hints = {0}, *res;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_family = AF_INET;
    hints.ai_flags = AI_PASSIVE;

    const char get_msg[] = "GET / HTTP/1.1\r\n\r\n";

    if (getaddrinfo("www.example.com", "443", &hints, &res) == -1) {
        fprintf(stderr, "getaddrinfo errro\n");
        exit(1);
    }

    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock == -1) {
        fprintf(stderr, "socket error\n");
        exit(1);
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen) < 0) {
        fprintf(stderr, "connect error\n");
        exit(1);
    }

    freeaddrinfo(res);
    char buf[1024] = {0};

    SSL_CTX *ctx = SSL_CTX_new(TLS_method());
    SSL *ssl = SSL_new(ctx);

    SSL_set_fd(ssl, sock);
    SSL_connect(ssl);

    int ssl_bytes = SSL_write(ssl, get_msg, sizeof(get_msg));
    printf("writes byte: %d\n", ssl_bytes);

    ssl_bytes = SSL_read(ssl, buf, 1023);


    printf("Response: %d\n%s\n", ssl_bytes, buf);

    SSL_clear(ssl);
    close(sock);

    return 0;
}
