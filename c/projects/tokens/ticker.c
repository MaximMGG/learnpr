#include "ticker.h"

Ticker *tickerCreate(str raw_ticker) {
  str raw_s = str_replace_any(raw_ticker, "{}", "");
  Ticker *t = make(Ticker);
  list *l = str_split(raw_ticker, ",");

  for(i32 i = 0; i < l->len; i++) {
    switch(i) {
      case 0: {
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
        t->volume = atof(tmp_d);
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
  dealloc(raw_s);

  return t;
}

void tickerDestroy(Ticker *t) {
  dealloc(t->symbol);
  dealloc(t);
}

TickerHystorical *tickerHystoricalCreate(str raw_ticker) {
  str raw_s = str_replace_any(raw_ticker, "[]", "");
  list *l = str_split(raw_s, ",");

  TickerHystorical *th = make(TickerHystorical);

  for(i32 i = 0; i < l->len; i++) {
    str cur_value = list_get(l, i);
    switch(i) {
      case 0: {
        th->openTime = atoll(cur_value);
      } break;
      case 1: {
        cur_value = str_replace(cur_value, "\"", "");
        th->openPrice = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 2: {
        cur_value = str_replace(cur_value, "\"", "");
        th->highPrice = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 3: {
        cur_value = str_replace(cur_value, "\"", "");
        th->lowPrice = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 4: {
        cur_value = str_replace(cur_value, "\"", "");
        th->lastPrice = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 5: {
        cur_value = str_replace(cur_value, "\"", "");
        th->volume = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 6: {
        th->closeTime = atof(cur_value);
      } break;
      case 7: {
        cur_value = str_replace(cur_value, "\"", "");
        th->quoteVolume = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 8: {
        th->numberOfTrades = atof(cur_value);
      } break;
      case 9: {
        cur_value = str_replace(cur_value, "\"", "");
        th->takerBuyVolume = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 10: {
        cur_value = str_replace(cur_value, "\"", "");
        th->takerBuyQuote = atof(cur_value);
        dealloc(cur_value);
      } break;
      case 11: {
        th->ignore = 0;
      } break;
    }
  }
  return th;
}

void tickerHystoricalDestroy(TickerHystorical *th) {
  dealloc(th);
}
