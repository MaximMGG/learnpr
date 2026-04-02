#include <stdio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <netdb.h>
#include <unistd.h>
#include <string.h>


#define TOKEN "7822096798:AAEBztEDKoWcYQnn-UgEBu8Kn7Uiywr3dmk"
#define CHAT_ID "719439900"

#define REQUEST "GET /bot%s/%s HTTP/1.1\r\nContent-Type: application/json\r\n"\
    "Host: api.telegram.org\r\n"\
    "{\"chat_id\": \"%s\", \"text\": \"%s\"}"

#define TEST_REQUEST "POST /bot7822096798:AAEBztEDKoWcYQnn-UgEBu8Kn7Uiywr3dmk/sendMessage HTTP/1.1\r\n"\
    "Host: api.telegram.org\r\nContent-Type: application/json\r\nContent-Length: %d\r\n\r\n%s"

#define CONTENT  "{\"chat_id\": \"719439900\", \"text\": \"Greatings!!!\"}"

int main() {

    const char *message = "Hello my dear friends!!!";
    char request_buf[1024] = {0};

    OPENSSL_init_ssl(0, NULL);

    SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());

    if (ctx == NULL) {
        fprintf(stderr, "SSL_CTX_new() error\n");
        return 1;
    }
    struct addrinfo hints = {0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo("api.telegram.org", "443", &hints, &res) != 0) {
        fprintf(stderr, "getaddrinfo() error\n");
    }

    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock < 1) {
        fprintf(stderr, "socket() error\n");
        return 1;
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen) < 0) {
        fprintf(stderr, "connect() error\n");
        close(sock);
        return 1;
    }

    freeaddrinfo(res);

    SSL *ssl = SSL_new(ctx);
    if (ssl == NULL) {
        fprintf(stderr, "SSL_new() error\n");
        close(sock);
        return 1;
    }

    SSL_set_fd(ssl, sock);
    
    if (SSL_connect(ssl) <= 0) {
        ERR_print_errors_fp(stderr);
        close(sock);
        return 1;
    }

    //int message_len = sprintf(request_buf, REQUEST, TOKEN, "sendMessage", CHAT_ID, message);
    //int write_bytes = SSL_write(ssl, request_buf, strlen(request_buf));
    int content_len = strlen(CONTENT);
    int m_len = sprintf(request_buf, TEST_REQUEST, content_len, CONTENT);
    printf("%s\n", request_buf);
    int write_bytes = SSL_write(ssl, request_buf, strlen(request_buf));
    printf("Write bytes: %d\n", write_bytes);

    char response_buf[4096] = {0};
    int read_bytes = SSL_read(ssl, response_buf, 4096);
    printf("read bytes: %d\n", read_bytes);

    printf("%s\n", response_buf);

    SSL_shutdown(ssl);
    SSL_free(ssl);
    close(sock);
    SSL_CTX_free(ctx);

    return 0 ;
}
