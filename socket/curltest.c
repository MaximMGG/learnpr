#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netdb.h>


int main() {
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://api1.binance.com/api/v3/ticker?symbol=BTCUSDT");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        int c = 10;
        res = curl_easy_perform(curl);
        puts("");
        res = curl_easy_perform(curl);
        puts("");
        res = curl_easy_perform(curl);
        puts("");
        res = curl_easy_perform(curl);
        puts("");
        res = curl_easy_perform(curl);
        puts("");
        res = curl_easy_perform(curl);
        puts("");

        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform error %s\n", curl_easy_strerror(res));
        }
        curl_easy_cleanup(curl);
    }

    return 0;
}
