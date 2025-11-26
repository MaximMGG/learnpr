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
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/list.h>

#define HOST "api.binance.com"
#define PORT "443"
#define REQUEST "GET /api/v3/ticker?symbol=%s HTTP/1.1\r\nHost: api.binance.com\r\nConection: open\r\n\r\n"


#define EXAMPLE_FROM_HYSTORIC_DATA "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=5m&startTime=1764012189000&endTime=1764184989000"

typedef struct {
  i32 sock;
  SSL *ssl;
  SSL_CTX *ctx;
  str request;
  str response;

  str symbol;
  f64 priceChange;
  f64 priceChangePercent;
  f64 weightedAvgPrice;
  f64 openPrice;
  f64 highPrice;
  f64 lowPrice;
  f64 lastPrice;
  f64 valume;
  f64 quoteVolume;
  i64 openTime;
  i64 closeTime;
  i64 firstId;
  i64 lastId;
  i64 count;
} Token;

Token *tokenCreate(str ticker);
void tokenDestroy(Token *t);
void tokenRequest(Token *t);
str tokenToString(Token *t);



#endif //TOKEN_H
