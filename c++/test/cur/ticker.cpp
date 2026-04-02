#include "ticker.h"
#include <cstring>
#include <iostream>


namespace BINANCE {

    std::string *Ticker::parse_ticker_string(const char *t) {
        std::string *res = new std::string[15];
        int len = strlen(t);
        int count = 0;

        for(int i = 0; i < len; i++) {
            if (t[i] == ':') {
                i++;
                if (t[i] == '"') {
                    i++;
                    while(t[i] != '"') {
                        res[count] += t[i++];
                    }
                    count++;
                } else if (t[i] != '"') {
                    i++;
                    while(t[i] != ',' && t[i] != '}') {
                        res[count] += t[i++];

                    }
                    count++;
                }
            }
        }
        return res;
    }

    Ticker::Ticker(const char *t) {
        std::string *parse_ticker = parse_ticker_string(t);
        symbol = parse_ticker[0];
        priceChange = atof(parse_ticker[1].data());
        priceChangePercent = atof(parse_ticker[2].data());
        weightedAvgPrice = atof(parse_ticker[3].data());
        openPrice = atof(parse_ticker[4].data());
        highPrice = atof(parse_ticker[5].data());
        lowPrice = atof(parse_ticker[6].data());
        lastPrice = atof(parse_ticker[7].data());
        volume = atof(parse_ticker[8].data());
        quoteVolume = atof(parse_ticker[9].data());
        openTime = atol(parse_ticker[10].data());
        closeTime = atol(parse_ticker[11].data());
        firstId = atol(parse_ticker[12].data());
        lastId = atol(parse_ticker[13].data());
        count = atol(parse_ticker[14].data());
        delete [] parse_ticker;
    }

    void Ticker::showTicker() {
        std::cout << "symbol:" << symbol << std::endl;
        std::cout << "priceChange:" << priceChange << std::endl;
        std::cout << "priceChangePercent:" << priceChangePercent << std::endl;
        std::cout << "weightedAvgPrice:" << weightedAvgPrice << std::endl;
        std::cout << "openPrice:" << openPrice << std::endl;
        std::cout << "highPrice:" << highPrice << std::endl;
        std::cout << "lowPrice:" << lowPrice << std::endl;
        std::cout << "lastPrice:" << lastPrice << std::endl;
        std::cout << "volume:" << volume << std::endl;
        std::cout << "quoteVolume:" << quoteVolume << std::endl;
        std::cout << "openTime:" << openTime << std::endl;
        std::cout << "closeTime:" << closeTime << std::endl;
        std::cout << "firstId:" << firstId << std::endl;
        std::cout << "lastId:" << lastId << std::endl;
        std::cout << "count:" << count << std::endl;
    }
    Ticker::~Ticker() {};
}
