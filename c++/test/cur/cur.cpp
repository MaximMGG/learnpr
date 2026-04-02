#include <curl/curl.h>
//{"symbol":"BTCUSDT","priceChange":"57.91000000","priceChangePercent":"0.123","weightedAvgPrice":"47373.76599466","openPrice":"47231.09000000","highPrice":"48200.00000000","lowPrice":"46765.44000000","lastPrice":"47289.00000000","volume":"44335.93530000","quoteVolume":"2100360224.05644820","openTime":1707489360000,"closeTime":1707575789674,"firstId":3408455700,"lastId":3410085249,"count":1629550}

int main() {
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();

    curl_easy_setopt(curl, CURLOPT_URL, "https://api1.binance.com/api/v3/ticker?symbol=BTCUSDT");

    res = curl_easy_perform(curl);
    if (res == CURLE_OK) {
        printf("OK");
    }

    curl_easy_cleanup(curl);

    return 0;
}
