#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 1024
#define ERROR 4
#define NO_KEYWORD_FOUND 3
#define KEYWORD_ONE_FOUND_FIRST 2
#define KEYWORD_TWO_FOUND_FIRST 1


int parseFile(char *file_name) {

    int return_value = ERROR;
    FILE* file_pointer = 0;
    char* buffer = 0;

    if(file_name != NULL) {
        if ((file_pointer = fopen(file_name, "r")) > 0) {
            if ((buffer = malloc(BUFFER_SIZE)) > 0) {
                return_value = NO_KEYWORD_FOUND;
                while(fgets(buffer, BUFFER_SIZE, file_pointer) != NULL) {
                    if (strcmp("KEY_WORD\n", buffer) == 0) {
                        return_value = KEYWORD_ONE_FOUND_FIRST;
                        break;
                    }
                    if (strcmp("KEYWORD_TWO\n", buffer) == 0) {
                        return_value = KEYWORD_TWO_FOUND_FIRST;
                        break;
                    }
                }
                free(buffer);
            }
            fclose(file_pointer);
        }
    }
    return return_value;
}

int main() {
    int check = 0;
    check = parseFile("test.txt");
    printf("%d\n", check);
    return 0;
}
