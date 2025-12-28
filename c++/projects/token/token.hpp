#ifndef TOKEN_TOKEN_HPP
#define TOKEN_TOKEN_HPP
#include <string>
#include "types.hpp"
#include <openssl/ssl.h>
#include <openssl/err.h>


struct Ticker {
  u64 id;
  f64 priceChange;
  f64 priceChangePercent;
  f64 weightedAvgPrice;
  f64 openPrice;
  f64 highPrice;
  f64 lowPrice;
  f64 lastPrice;
  f64 volume;
  f64 quoteVolume;
  u64 openTime;
  u64 closeTime;
  u64 firstId;
  u64 lastId;
  u64 count;

  Ticker(std::string parse_symbol);
  ~Ticker();
};

class Token {
public:
  Ticker &ticker;
  std::string symbol;
  i64 id;

  Token(std::string symbol, u64 id);
  ~Token();
  void request();

private:
  std::string req;
  SSL *ssl;
  SSL_CTX *ctx;
  i32 socket;
};


#endif //TOKEN_TOKEN_HPP
