#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>


char buf[128] = {0};


int main() {
    setenv("TZ", "Europe/Kyiv", 1);
    tzset();


    time_t timer;
    struct tm *local, *utc;
    time(&timer);

    local = localtime(&timer);
    utc = gmtime(&timer);


    strftime(buf, 128, "%Y-%m-%d %H:%M:%S %Z", local);
    printf("Local time: %s\n", buf);
    memset(buf, 0, 128);

    strftime(buf, 128, "%Y-%m-%d %H:%M:%S %Z", utc);
    printf("Local time: %s\n", buf);
}
