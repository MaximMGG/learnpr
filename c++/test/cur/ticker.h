#ifndef TICKER_H_
#define TICKER_H_
#include <string>
//{"symbol":"BTCUSDT","priceChange":"57.91000000","priceChangePercent":"0.123","weightedAvgPrice":"47373.76599466","openPrice":"47231.09000000","highPrice":"48200.00000000","lowPrice":"46765.44000000","lastPrice":"47289.00000000","volume":"44335.93530000","quoteVolume":"2100360224.05644820","openTime":1707489360000,"closeTime":1707575789674,"firstId":3408455700,"lastId":3410085249,"count":1629550}
namespace BINANCE {
    class Ticker {
        private:
            std::string symbol;
            double priceChange;
            double priceChangePercent;
            double weightedAvgPrice;
            double openPrice;
            double highPrice;
            double lowPrice;
            double lastPrice;
            double volume;
            double quoteVolume;
            long openTime;
            long closeTime;
            long firstId;
            long lastId;
            long count;
            std::string *parse_ticker_string(const char *t);
        public:
            Ticker(const char *t);
            ~Ticker();
            std::string getSymbol();
            double getPriceChange();
            double getWeightAvgPrice();
            double getOpenPrice();
            double getHighPrice();
            double getLowPrice();
            double getLastPrice();
            double getVolume();
            double getQuoteVolum();
            long getOpenTime();
            long getCloseTime();
            long getFirstId();
            long getLastId();
            long getCount();
            void showTicker();
    };
}

#endif //TICKER_H_
