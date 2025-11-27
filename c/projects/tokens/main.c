#include <stdio.h>
#include "token.h"


int main() {
  Token *t = tokenCreate("BTCUSDT");

  i32 iter = 1;
  while(iter > 0) {
    tokenRequest(t);
    str s = tickerToString(t->ticker);
    printf("%s\n", s);
    dealloc(s);
    iter--;
  }

  struct tm startTime = {
    .tm_year = 2025 - 1900, .tm_mon = 10, .tm_mday = 25, .tm_hour = 20, .tm_min = 30
  };
  struct tm endTime = {
    .tm_year = 2025 - 1900, .tm_mon = 10, .tm_mday = 27, .tm_hour = 20, .tm_min = 30
  };

  tokenLoadHystricalData(t, &startTime, &endTime);

  for(i32 i = 0; i < t->tickerHystorical->len; i++) {
    TickerHystorical *tmp = list_get(t->tickerHystorical, i);
    str s = tickerHystoricalToString(tmp);
    printf("%d - %s\n", i, s);
    dealloc(s);
  }

  tokenDestroy(t);
  return 0;
}
