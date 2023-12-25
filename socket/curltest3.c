#include <curl/curl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct memory {
    char *response;
    size_t size;
};

static size_t cb(void *data, size_t size, size_t nmemb, void *clientp) {
    size_t realsize = size * nmemb;
    struct memory *mem = (struct memory *) clientp;

    char *ptr = realloc(mem->response, mem->size + realsize + 1);
    if (!ptr) 
        return 0; // out of memory

    mem->response = ptr;
    memcpy(&(mem->response[mem->size]), data, realsize);

    mem->size += realsize;
    mem->response[mem->size] = 0;
    return realsize;
}

int main(void) {
    struct memory chunk = {0};
    CURLcode res;
    CURL *curl;
    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://api3.binance.com/api/v3/ticker?symbol=BTCUSDT");
        //send all data to this function
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, cb);

        //we pass our 'chunk' struct to the callback funciton
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *) &chunk);

        res = curl_easy_perform(curl);

        printf("%s\n", chunk.response);

        free(chunk.response);
    }

    curl_easy_cleanup(curl);

}
