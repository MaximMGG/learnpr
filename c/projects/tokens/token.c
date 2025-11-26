#include "token.h"

Token *tokenCreate(str ticker) {
  Token *t = make(Token);
  t->request = str_create_fmt(REQUEST, ticker);
  t->response = null;
  t->symbol = null;

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
  if (t->symbol != null) {
    dealloc(t->symbol);
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
  list *l = str_split(t->response, ",");
  // str symbol; 0
  // f64 priceChange; 1
  // f64 priceChangePercent; 2
  // f64 weightedAvgPrice; 3
  // f64 openPrice; 4
  // f64 highPrice; 5
  // f64 lowPrice; 6
  // f64 lastPrice; 7
  // f64 valume; 8
  // f64 quoteVolume; 9
  // i64 openTime; 10
  // i64 closeTime; 11
  // i64 firstId; 12
  // i64 astId; 13
  // i64 count; 14

  for(i32 i = 0; i < l->len; i++) {
    switch(i) {
      case 0: {
        if (t->symbol != null) {
          dealloc(t->symbol);
        }
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        t->symbol = str_replace(tmp, "\"", "");
      } break;
      case 1: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->priceChange = atof(tmp_d);
      } break;
      case 2: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->priceChangePercent = atof(tmp_d);
      } break;
      case 3: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->weightedAvgPrice = atof(tmp_d);
      } break;
      case 4: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->openPrice = atof(tmp_d);
      } break;
      case 5: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->highPrice = atof(tmp_d);
      } break;
      case 6: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->lowPrice = atof(tmp_d);
      } break;
      case 7: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->lastPrice = atof(tmp_d);
      } break;
      case 8: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->valume = atof(tmp_d);
      } break;
      case 9: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 2;
        i8 *tmp_d = str_replace(tmp, "\"", "");
        t->quoteVolume = atof(tmp_d);
      } break;
      case 10: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 1;
        t->openTime = atoll(tmp);
      } break;
      case 11: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 1;
        t->closeTime = atoll(tmp);
      } break;
      case 12: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 1;
        t->firstId = atoll(tmp);
      } break;
      case 13: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 1;
        t->lastId = atoll(tmp);
      } break;
      case 14: {
        i8 *tmp = list_get(l, i);
        tmp = strstr(tmp, ":");
        tmp += 1;
        t->count = atoll(tmp);
      } break;
    }
  }
  for(i32 i = 0; i < l->len; i++) {
    dealloc(list_get(l, i));
  }
  list_destroy(l);
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
  t->response = str_replace_any(tmp, "{}", "");
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
  "valume %lf\n"              \
  "quoteVolume %lf\n"         \
  "openTime %ld\n"            \
  "closeTime %ld\n"           \
  "firstId %ld\n"             \
  "lastId %ld\n"               \
  "count %ld\n"
str tokenToString(Token *t) {
  str s = str_create_fmt(TOKEN_TO_STRING, t->symbol,
                                t->priceChange,
                                t->priceChangePercent,
                                t->weightedAvgPrice,
                                t->openPrice,
                                t->highPrice,
                                t->lowPrice,
                                t->lastPrice,
                                t->valume,
                                t->quoteVolume,
                                t->openTime,
                                t->closeTime,
                                t->firstId,
                                t->lastId,
                                t->count);

  return s;
  // str symbol; 0
  // f64 priceChange; 1
  // f64 priceChangePercent; 2
  // f64 weightedAvgPrice; 3
  // f64 openPrice; 4
  // f64 highPrice; 5
  // f64 lowPrice; 6
  // f64 lastPrice; 7
  // f64 valume; 8
  // f64 quoteVolume; 9
  // i64 openTime; 10
  // i64 closeTime; 11
  // i64 firstId; 12
  // i64 lastId; 13
  // i64 count; 14
}
