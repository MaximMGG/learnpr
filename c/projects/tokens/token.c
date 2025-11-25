#include "token.h"

Token *tokenCreate(str ticker) {
  Token *t = make(Token);
  t->request = str_create_fmt(REQUEST, ticker);
  t->response = null;

  SSL_library_init();
  SSL_load_error_strings();
  OpenSSL_add_ssl_algorithms();

  t->ctx = SSL_CTX_new(TLS_client_method());
  if (!t->ctx) {
    log(ERROR, "SSL_CTX_new error");
    dealloc(t->request);
    dealloc(t);
    return null;
  }

  struct addrinfo hints = {0}, *res;
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_STREAM;
  if (getaddrinfo(HOST, PORT, &hints, &res) != 0) {
    log(ERROR, "getaddrinfo error");
    dealloc(t->request);
    dealloc(t);
    return null;
  }

  t->sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (t->sock < 0) {
    log(ERROR, "socket error");
    dealloc(t->request);
    dealloc(t);
    return null;
  }

  if (connect(t->sock, res->ai_addr, res->ai_addrlen) != 0) {
    close(t->sock);
    log(ERROR, "connect error");
    dealloc(t->request);
    dealloc(t);
    return null;
  }
  t->ssl = SSL_new(t->ctx);
  SSL_set_fd(t->ssl, t->sock);

  if (SSL_connect(t->ssl) <= 0) {
    close(t->sock);
    log(ERROR, "SSL_connect error");
    dealloc(t->request);
    dealloc(t);
    return null;
  }
  return t;
}

void tokenDestroy(Token *t) {
  if (t->response != null) {
    SSL_shutdown(t->ssl);
    SSL_free(t->ssl);
    SSL_CTX_free(t->ctx);
    close(t->sock);
    EVP_cleanup();
    dealloc(t->response);
    dealloc(t->request);
    dealloc(t);
  }
}


static list *tokenSplitResponse(Token *t) {
  return null;
}

void tekenRequest(Token *t) {

}
