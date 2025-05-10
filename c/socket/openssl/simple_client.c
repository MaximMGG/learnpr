#include <sys/socket.h>
#include <netdb.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <openssl/ssl.h>
#include <openssl/err.h>


#define HOST "api.binance.com"
#define PORT "443"
#define REQUEST "GET /api/v3/ticker?symbol=BTCUSDT HTTP/1.1\r\nHost: api.binance.com\r\nConnection: close\r\n\r\n"


int main() {

    SSL_library_init();
    SSL_load_error_strings();
    OpenSSL_add_ssl_algorithms();

    SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
    if (!ctx) {
        perror("Unable to create SSL context");
        return 1;
    }

    struct addrinfo hints = {0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    if (getaddrinfo(HOST, PORT, &hints, &res) != 0) {
        perror("getaddrinfo");
        return 1;
    }
    
    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (connect(sock, res->ai_addr, res->ai_addrlen) != 0) {
        perror("connect");
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
    char buf[4096] = {0};
    int bytes;


    bytes = SSL_read(ssl, buf, 4095);

    char *s = strstr(buf, "\r\n\r\n");
    printf("%s\n", s + 4);


    // while((bytes = SSL_read(ssl, buf, 4095)) > 0) {
    //     buf[bytes] = 0;
    //     printf("%s", buf);
    // }

    SSL_shutdown(ssl);
    SSL_free(ssl);
    close(sock);
    SSL_CTX_free(ctx);
    EVP_cleanup();

    return 0;
}
