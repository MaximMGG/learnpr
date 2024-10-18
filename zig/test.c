#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>


struct mem{
    char *data;
    size_t size;
};

static size_t write_func(void *data, size_t size, size_t nmemb, void *user_data) {
    size_t real_size = size * nmemb;
    struct mem *m = (struct mem *)user_data;

    char *ptr = realloc(m->data, m->size + real_size + 1);
    if (!ptr)
        return 0;

    m->data = ptr;
    memcpy(&(m->data[m->size]), data, real_size);
    m->size += real_size;
    m->data[m->size] = 0;

    return real_size;
}

int main() {

    CURLcode res;
    CURL *curl = curl_easy_init();

    if (!curl) {
        fprintf(stderr, "Cant init curl\n");
    }
    struct mem m = {0};
    m.data = malloc(sizeof(char) * 1);
    m.size = 0;

    curl_easy_setopt(curl, CURLOPT_URL, "https://ziglang.org");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_func);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&m);

    res = curl_easy_perform(curl);

    if (!res) {
        printf("Resieved %lu bytes\n", m.size);

        printf("%s\n", m.data);
    }

    free(m.data);

    return 0;
}
