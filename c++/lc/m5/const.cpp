#include <iostream>
#include <curl/curl.h>


const int five() {
    return 5;
}



int main() {
    const int c = 123;
    constexpr int b {c};

    const std::string name {"Hello"};


    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();

    //return all http from site
    curl_easy_setopt(curl, CURLOPT_URL, "https://ru.tradingview.com/chart/mp83su2e/?symbol=HUOBI%3A18CBTC");
    curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);

    res = curl_easy_perform(curl);
    if (res == CURLE_OK) {
        std::cout << "Done\n";
    } else {
        std::cerr << "Error\n";
    }

    curl_easy_cleanup(curl);

    return 0;
}
