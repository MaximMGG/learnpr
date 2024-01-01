#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <assert.h>
#include <stdbool.h>


//example of pool memory

#define ELEMENT_SIZE 255
#define MAX_ELEMENTS 10

typedef struct {
    bool occupied;
    char memory[ELEMENT_SIZE];
} PoolElement;

static PoolElement memory_pool[MAX_ELEMENTS];

void* poolTake(size_t size) {
    if (size <= ELEMENT_SIZE) {
        for(int i = 0; i < MAX_ELEMENTS; i++) {
            if (memory_pool[i].occupied == false) {
                memory_pool[i].occupied = true;
                return &(memory_pool[i].memory);
            }
        }
    }
    return NULL;
}

void poolRelease(void *pointer) {
    for(int i = 0; i < MAX_ELEMENTS; i++) {
        if (&(memory_pool[i].memory) == pointer) {
            memory_pool[i].occupied = false;
            return;
        }
    }
}

#define MAX_FILENAME_SIZE ELEMENT_SIZE


//example of covering malloc and free funcs
void* safeMalloc(size_t size) {
    void *pointer = malloc(size);
    assert(pointer);
    return pointer;
}

void safeFree(void *pointer) {
    free(pointer);
}

void readFileContent(char *filename, char* buffer, int file_length) {
    FILE *f = fopen(filename, "r");
    fseek(f, 0, SEEK_SET);
    int read_elements = fread(buffer, 1, file_length, f);
    buffer[read_elements] = '\0';
    fclose(f);
}

int getFileLength(char *filename) {
    FILE *f = fopen(filename, "r");
    fseek(f, 0, SEEK_END);
    int file_length = ftell(f);
    fclose(f);
    return file_length;
}


void caesar(char* text, int length) {
    for (int i = 0; i < length; i++) {
        text[i] = text[i] + 3;
        if (text[i] > 'A') {
            text[i] = text[i] - 'Z' + 'A' - 1;
        }
    }
}

void encryptCeasarFile(char *filename) {
    char *text = NULL;
    int size = getFileLength(filename);
    if (size > 0) {
        text = safeMalloc(size);
        if (text != NULL) {
            readFileContent(filename, text, size);
            caesar(text, strnlen(text, size));
            printf("Crypted text: %s\n", text);
        }
        safeFree(text);
        text = NULL;
    }
}


void encryptCaesarFilename(char *filename) {
    char* buffer = poolTake(MAX_FILENAME_SIZE);
    if (buffer != NULL) {
        strncpy(buffer, filename, MAX_FILENAME_SIZE);
        caesar(buffer, strnlen(buffer, MAX_FILENAME_SIZE));
        printf("\nencoding file name: %s\n", buffer); 
        poolRelease(buffer);
    }
}

void encryptDirectoryContet() {
    struct dirent *dir_ent;
    DIR *dir = opendir(".");
    while((dir_ent = readdir(dir)) != NULL) {
        encryptCaesarFilename(dir_ent->d_name);
        encryptCeasarFile(dir_ent->d_name);
    }
}




// #define MAX_TEXT_SIZE  1024


/*
 * old examples

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

void encryptCeasarFile(char *filename) {
    char *text = NULL;
    int size = getFileLength(filename);
    if (size > 0) {
        text = safeMalloc(size);
        if (text != NULL) {
            readFileContent(filename, text, size);
            caesar(text, strnlen(text, size));
            printf("Crypted text: %s\n", text);
        }
        safeFree(text);
        text = NULL;
    }
}

void encryptDirectoryContent() {
    DIR *dir = opendir(".");
    struct dirent *dir_ent;
    while((dir_ent = readdir(dir)) != NULL) {
        encryptCeasarFile(dir_ent->d_name);
    }
    closedir(dir);
}
*/
