#include "ticker.h"
#include "curl/curl.h"
#include <cstdlib>
#include <string.h>

struct mem {
    char *buf;
    int size;
};

static size_t cb(void *data, size_t size, size_t nmemb, void *clientp) {
    size_t realsize = size * nmemb;
    struct mem *m = (struct mem *) clientp;
    m->size = 0;
    char *ptr = (char *)realloc(m->buf, m->size + realsize + 1);
    if (!ptr) {
        return 0;
    }
    m->buf = ptr;
    memcpy(&(m->buf[m->size]), data, realsize);
    m->size += realsize;
    m->buf[m->size] = '\0';
    return realsize;
}


char *response() {
    CURL *curl;
    CURLcode res;
    struct mem m = {0};
    curl = curl_easy_init();

    curl_easy_setopt(curl, CURLOPT_URL, "https://api1.binance.com/api/v3/ticker?symbol=BTCUSDT");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, cb);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &m);

    res = curl_easy_perform(curl);
    if (res == CURLE_OK) {
        printf("OK");
    }

    curl_easy_cleanup(curl);

    return m.buf;
}


int main() {
    BINANCE::Ticker btc {response()};
    btc.showTicker();

    return 0;
}
