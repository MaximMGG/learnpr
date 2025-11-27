#include "token.h"

Token *tokenCreate(str ticker) {
  Token *t = make(Token);
  t->request = str_create_fmt(REQUEST, ticker);
  t->response = null;
  t->ticker = null;

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
    dealloc(t->response);
  }
  if (t->ticker != null) {
    tickerDestroy(t->ticker);
  }
  SSL_shutdown(t->ssl);
  SSL_free(t->ssl);
  SSL_CTX_free(t->ctx);
  close(t->sock);
  EVP_cleanup();
  dealloc(t->request);
  dealloc(t);
}

static void tokenParseResponse(Token *t) {
  if (t->ticker != null) {
    tickerDestroy(t->ticker);
  }
  t->ticker = tickerCreate(t->response);
}

void tokenRequest(Token *t) {
  i32 write_bytes = SSL_write(t->ssl, t->request, strlen(t->request));
  if (write_bytes != strlen(t->request)) {
    log(ERROR, "SSL_write error");
    return;
  }

  i8 buf[4096] = {0};
  i32 read_bytes = SSL_read(t->ssl, buf, 4096);
  if (read_bytes <= 0) {
    log(ERROR, "SSL_read error");
    return;
  }
  if (t->response != null) {
    dealloc(t->response);
  }

  i8 *tmp = strstr(buf, "\r\n\r\n");
  tmp += 4;
  t->response = str_copy(tmp);
  tokenParseResponse(t);
}

#define TOKEN_TO_STRING       \
  "symbol %s\n"               \
  "priceChange %lf\n"         \
  "priceChangePercent %lf\n"  \
  "weightedAvgPrice %lf\n"    \
  "openPrice %lf\n"           \
  "highPrice %lf\n"           \
  "lowPrice %lf\n"            \
  "lastPrice %lf\n"           \
  "volume %lf\n"              \
  "quoteVolume %lf\n"         \
  "openTime %ld\n"            \
  "closeTime %ld\n"           \
  "firstId %ld\n"             \
  "lastId %ld\n"               \
  "count %ld\n"
str tokenToString(Token *t) {
  str s = str_create_fmt(TOKEN_TO_STRING, 
                                t->ticker->symbol,
                                t->ticker->priceChange,
                                t->ticker->priceChangePercent,
                                t->ticker->weightedAvgPrice,
                                t->ticker->openPrice,
                                t->ticker->highPrice,
                                t->ticker->lowPrice,
                                t->ticker->lastPrice,
                                t->ticker->volume,
                                t->ticker->quoteVolume,
                                t->ticker->openTime,
                                t->ticker->closeTime,
                                t->ticker->firstId,
                                t->ticker->lastId,
                                t->ticker->count);

  return s;
}

void tokenLoadHystricalData(Token *t, struct tm *startTime, struct tm endTime) {

}
