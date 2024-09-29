#include <stdio.h>
#include <unistd.h>
#include <string.h>

char password[128] = {0};


void loadPassword() {
    FILE *F = fopen("pass.txt", "r");
    fread(password, 1, 128, F);
    fclose(F);
}

char validatePasswrod(char *attemt) {
    if (strcmp(password, attemt) == 0) return 1;
    else return 0;
}


int main() {

    char buf[512] = {0};
    loadPassword();

    setbuf(stdout, NULL);
    printf("Hello in our app!!!\n");
    printf("Please anter the password: ");

    while(1) {
        read(STDIN_FILENO, buf, 512);
        if (validatePasswrod(buf)) break;
        printf("Wrong password, try agane\n");
        memset(buf, 0, 512);
    }
    printf("Walcome from inside\n");

    return 0;
}
