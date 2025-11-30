#ifndef TOKEN_H
#define TOKEN_H
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <time.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/list.h>
#include "ticker.h"

#define HOST "api.binance.com"
#define PORT "443"
#define REQUEST "GET /api/v3/ticker?symbol=%s HTTP/1.1\r\nHost: api.binance.com\r\nConection: open\r\n\r\n"
#define REQUEST_HYSTORICAL "GET /api/v3/klines?symbol=%s&interval=5m&startTime=%ld&endTime=%ld HTTP/1.1\r\nHost: api.binance.com\r\nConection: open\r\n\r\n"

#define EXAMPLE_FROM_HYSTORIC_DATA "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=5m&startTime=1764012189000&endTime=1764184989000"

typedef struct {
  i32 sock;
  SSL *ssl;
  SSL_CTX *ctx;
  str token_symbol;
  i32 token_id;
  str request;
  str request_hystorical;
  str response;

  Ticker *ticker;
  list *tickerHystorical;
} Token;

Token *tokenCreate(str symbol);
void tokenDestroy(Token *t);
void tokenRequest(Token *t);
void tokenLoadHystricalData(Token *t, struct tm *startTime, struct tm *endTime);


#endif //TOKEN_H
