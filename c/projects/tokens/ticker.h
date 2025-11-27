#ifndef TICKER_H
#define TICKER_H
#include <cstdext/core.h>
#include <cstdext/container/list.h>
#include <string.h>

typedef struct {
  str symbol;
  f64 priceChange;
  f64 priceChangePercent;
  f64 weightedAvgPrice;
  f64 openPrice;
  f64 highPrice;
  f64 lowPrice;
  f64 lastPrice;
  f64 volume;
  f64 quoteVolume;
  i64 openTime;
  i64 closeTime;
  i64 firstId;
  i64 lastId;
  i64 count;
} Ticker;

Ticker *tickerCreate(str raw_ticker);
void tickerDestroy(Ticker *ticker);

typedef struct {
  i64 openTime;
  f64 openPrice;
  f64 highPrice;
  f64 lowPrice;
  f64 lastPrice;
  f64 volume;
  i64 closeTime;
  f64 quoteVolume;
  i64 numberOfTrades;
  f64 takerBuyVolume;
  f64 takerBuyQuote;
  f64 ignore;
} TickerHystorical;

TickerHystorical *tickerHystoricalCreate(str raw_ticker);
void tickerHystoricalDestroy(TickerHystorical *th);

#endif //TICKER_H
