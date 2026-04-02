#include <stdio.h>
#include <string.h>


#define CMD(name) \
    char name ## _cmd[256] = ""; \
    strcpy(name ## _cmd, #name);


int main() {

    CMD(copy);
    CMD(paste);
    CMD(cut);

    char cmd[256];
    scanf("%s", cmd);

    if (strcmp(cmd, copy_cmd) == 0) {
        printf("copy\n");
    }
    if (strcmp(cmd, paste_cmd) == 0) {
        printf("paste\n");
    }
    if (strcmp(cmd, cut_cmd) == 0) {
        printf("cut\n");
    }


    return 0;
}
