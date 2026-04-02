#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char *create_str(char *buf) {
    char *tmp = malloc(sizeof(char) * strlen(buf));
    char *p = tmp;

    while(*buf != '\0') {
        *(p)++ = *(buf)++;
    }

    return tmp;
}




int main() {

    char *str = create_str("qwer");
    printf("%s\n", str);

    int len = 4;

    char *a = str;
    char buf;

    int i = 0;
    while (i < len)  {
        a[i] = '2';
        i++;
    }


    printf("%s\n", str);

    return 0;
}
