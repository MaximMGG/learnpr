#include <stdio.h>
#include <curl/curl.h>


int main() {
    CURL *curl;
    CURLcode res;

    curl_global_init(CURL_GLOBAL_DEFAULT);

    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://api3.binance.com/api/v3/ticker?symbol=BTCUSDT");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);

        // curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
        // curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
        //
        // curl_easy_setopt(curl, CURLOPT_VERBOSE, 0L);
        // curl_easy_setopt(curl, CURLOPT_CERTINFO, 0L);

        int c = 30;
        while (c--) {
            res = curl_easy_perform(curl);
            puts("");
        }

        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform error %s\n", curl_easy_strerror(res));
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
}
