#include <curl/curl.h>

int main(void) {
    CURL *curl = curl_easy_init();
    if (curl) {
        const char *url = "https://api.telegram.org/bot7822096798:AAEBztEDKoWcYQnn-UgEBu8Kn7Uiywr3dmk/sendMessage";
        const char *data = "{\"chat_id\": \"719439900\", \"text\": \"Hello from C!\"}";

        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/json");

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, data);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);

        CURLcode res = curl_easy_perform(curl);

        if (res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));

        curl_easy_cleanup(curl);
    }
    return 0;
}

