package token

import "core:fmt"
import "core:log"
import "core:strings"
import "core:strconv"
import "core:testing"

Ticker :: struct {
    symbol: string,
    priceChange: f64,
    priceChangePercent: f64,
    weightedAvgPrice: f64,
    openPrice: f64,
    highPrice: f64,
    lowPrice: f64,
    lastPrice: f64,
    volume: f64,
    quoteVolume: f64,
    openTime: i64,
    closeTime: i64,
    firstId: i64,
    lastId: i64,
    count: i64,
}

/*
0 - {"symbol":"ETHUSDT",
1 - "priceChange":"32.73000000",
2 - "priceChangePercent":"1.065",
3 - "weightedAvgPrice":"3100.04489724",
4 - "openPrice":"3072.18000000",
5 - "highPrice":"3135.68000000",
6 - "lowPrice":"3063.57000000",
7 - "lastPrice":"3104.91000000",
8 - "volume":"148079.63130000",
9 - "quoteVolume":"459053505.39733200",
10 - "openTime":1765566600000,
11 - "closeTime":1765653050963,
12 - "firstId":3322769341,
13 - "lastId":3324954086,
14 - "count":2184746}
*/

ticker_create :: proc(s: string) -> ^Ticker {
    t: ^Ticker = new(Ticker)
    list := strings.split(s, ",")
    defer delete(list)
    for i in 0..<len(list) {
      switch i {
      case 0:
        index := strings.index(list[i], "\":\"")
        t.symbol = strings.clone(list[i][index + 3:len(list[i]) - 1])
      case 1:
        index := strings.index(list[i], "\":\"")
        t.priceChange = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 2:
        index := strings.index(list[i], "\":\"")
        t.priceChangePercent = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 3:
        index := strings.index(list[i], "\":\"")
        t.weightedAvgPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 4:
        index := strings.index(list[i], "\":\"")
        t.openPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 5:
        index := strings.index(list[i], "\":\"")
        t.highPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 6:
        index := strings.index(list[i], "\":\"")
        t.lowPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 7:
        index := strings.index(list[i], "\":\"")
        t.lastPrice = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 8:
        index := strings.index(list[i], "\":\"")
        t.volume = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 9:
        index := strings.index(list[i], "\":\"")
        t.quoteVolume = strconv.parse_f64(list[i][index + 3:len(list[i]) - 1]) or_else 0
      case 10:
        index := strings.index(list[i], "\":")
        t.openTime = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
      case 11:
        index := strings.index(list[i], "\":")
        t.closeTime = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
      case 12:
        index := strings.index(list[i], "\":")
        t.firstId = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
      case 13:
        index := strings.index(list[i], "\":")
        t.lastId = strconv.parse_i64(list[i][index + 2:len(list[i])]) or_else 0
      case 14:
        index := strings.index(list[i], "\":")
        t.count = strconv.parse_i64(list[i][index + 2:len(list[i]) - 1]) or_else 0
      }
    }
    return t
}

ticker_destroy :: proc(t: ^Ticker) {
    delete(t.symbol)
    free(t)
}

@(test)
ticker_create_test :: proc(t: ^testing.T) {
  ticker_string :=
  "{\"symbol\":\"ETHUSDT\",\"priceChange\":\"32.73000000\",\"priceChangePercent\":\"1.065\",\"weightedAvgPrice\":\"3100.04489724\",\"openPrice\":\"3072.18000000\",\"highPrice\":\"3135.68000000\",\"lowPrice\":\"3063.57000000\",\"lastPrice\":\"3104.91000000\",\"volume\":\"148079.63130000\",\"quoteVolume\":\"459053505.39733200\",\"openTime\":1765566600000,\"closeTime\":1765653050963,\"firstId\":3322769341,\"lastId\":3324954086,\"count\":2184746}"

    t := ticker_create(ticker_string)
    defer ticker_destroy(t)

  assert(t.symbol == "ETHUSDT")
  assert(t.count == 2184746)
}

