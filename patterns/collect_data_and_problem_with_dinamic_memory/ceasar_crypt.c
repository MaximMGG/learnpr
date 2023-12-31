#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void caesar(char* text, int length) {
    for (int i = 0; i < length; i++) {
        text[i] = text[i] + 3;
        if (text[i] > 'A') {
            text[i] = text[i] - 'Z' + 'A' - 1;
        }
    }
}



#define MAX_TEXT_SIZE  1024

int getFileLength(char *filename) {
    FILE *f = fopen(filename, "r");
    fseek(f, 0, SEEK_END);
    int file_length = ftell(f);
    fclose(f);
    return file_length;
}

void readFileContent(char *filename, char* buffer, int file_length) {
    FILE *f = fopen(filename, "r");
    fseek(f, 0, SEEK_SET);
    int read_elements = fread(buffer, 1, file_length, f);
    buffer[read_elements] = '\0';
    fclose(f);
}

void encryptCeasarText() {
    char *text;
    int size = getFileLength("test.txt");
    if (size > 0) {
        text = malloc(size);
        readFileContent("test.txt", text, size);
        caesar(text, strnlen(text, size));
        printf("Crypted text: %s\n", text);
    }
}
