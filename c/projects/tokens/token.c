#include "token.h"

Token *tokenCreate(str ticker) {
  Token *t = make(Token);
  t->token_symbol = str_copy(ticker);
  t->request = str_create_fmt(REQUEST, ticker);
  t->request_hystorical = null;
  t->response = null;
  t->ticker = null;
  t->tickerHystorical = null;

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
  SSL_set_connect_state(t->ssl); // experimental

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
  if (t->request_hystorical != null) {
    dealloc(t->request_hystorical);
  }
  if (t->tickerHystorical != null) {
    for(i32 i = 0; i < t->tickerHystorical->len; i++) {
      dealloc(list_get(t->tickerHystorical, i));
    }
    list_destroy(t->tickerHystorical);
  }

  SSL_shutdown(t->ssl);
  SSL_free(t->ssl);
  SSL_CTX_free(t->ctx);
  close(t->sock);
  EVP_cleanup();
  dealloc(t->request);
  dealloc(t->token_symbol);
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

static void tokenParseHystoricalData(Token *t, str hystoric) {
  log(INFO, "Start parsin hystorical data");
  t->tickerHystorical = list_create(PTR);
  str start_line = hystoric + 1;
  str end_line = start_line;

  while(true) {
    end_line = strstr(start_line, "],");
    if (end_line == null) break;
    end_line++;
    str new = alloc(end_line - start_line + 1);
    strncpy(new, start_line, end_line - start_line);
    TickerHystorical *th = tickerHystoricalCreate(new);
    list_append(t->tickerHystorical, th);
    dealloc(new);
    start_line = end_line + 1;
  }

  str new = alloc(strlen(start_line));
  strncpy(new, start_line, strlen(start_line) - 1);
  TickerHystorical *th = tickerHystoricalCreate(new);
  list_append(t->tickerHystorical, th);
  dealloc(new);
  log(INFO, "End parsing hystorical data");
}

static i32 tokenLoadHystricalGetContentLength(str cont) {
  str endLine = strstr(cont, "\r\n");
  cont += strlen("Content-Length: ");
  i8 buf[128] = {0};
  strncpy(buf, cont, endLine - cont);
  return atol(buf);
}

void tokenLoadHystricalData(Token *t, struct tm *startTime, struct tm *endTime) {
  if (t->request_hystorical != null) {
    dealloc(t->request_hystorical);
  }
  t->request_hystorical = str_create_fmt(REQUEST_HYSTORICAL, t->ticker->symbol, timelocal(startTime) * 1000, timelocal(endTime) * 1000);
  i32 send_bytes = SSL_write(t->ssl, t->request_hystorical, strlen(t->request_hystorical));
  if (send_bytes != strlen(t->request_hystorical)) {
    log(ERROR, "SSL_write error");
    return;
  }

  i64 total_read = 0;
  i32 read_bytes;
  i8 buf[4096] = {0};
  str_buf *hystoric = str_buf_create();
  read_bytes = SSL_read(t->ssl, buf, 4096);
  str content_length = strstr(buf, "Content-Length:");
  i32 need_to_read = tokenLoadHystricalGetContentLength(content_length);

  while(read_bytes > 0) {
    str_buf_append(hystoric, buf);
    memset(buf, 0, 4096);
    total_read += read_bytes;
    if (total_read >= need_to_read) {
      break;
    }
    read_bytes = SSL_read(t->ssl, buf, 4096);
  }

  log(INFO, "Total read %ld bytes", total_read);
  str tmp_str = str_buf_to_string(hystoric);
  str tmp = strstr(tmp_str, "\r\n\r\n");
  tmp += 4;
  tokenParseHystoricalData(t, tmp);
  dealloc(tmp_str);
  str_buf_destroy(hystoric);
}
