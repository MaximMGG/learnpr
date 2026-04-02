#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define BUFFER_SIZE 1024
#define ERROR 4
#define NO_KEYWORD_FOUND 3
#define KEYWORD_ONE_FOUND_FIRST 2
#define KEYWORD_TWO_FOUND_FIRST 1


typedef struct {
    FILE *file_pointer;
    char *buffer;
} FileParser; 


FileParser *createParser(char *file_name);
int searchFileForKeywords(FileParser *parser);
void cleanupParser(FileParser *parser);



int parseFile(char *file_name) {
    int return_value;
    FileParser *parser = createParser(file_name);
    return_value = searchFileForKeywords(parser);
    cleanupParser(parser);
    return return_value;
}

int searchFileForKeywords(FileParser *parser) {
    if (parser == NULL) {
        return ERROR;
    }

    while (fgets(parser->buffer, BUFFER_SIZE, parser->file_pointer) != NULL) {
        if (strcmp("KEYWORD_ONE\n", parser->buffer) == 0) {
            return KEYWORD_ONE_FOUND_FIRST;
        }
        if (strcmp("KEYWORD_TWO\n", parser->buffer) == 0) {
            return KEYWORD_TWO_FOUND_FIRST;
        }
    }
    return NO_KEYWORD_FOUND;
}

FileParser *createParser(char *file_name) {
    assert(file_name != NULL && "Incorrect file name");
    FileParser *parser = malloc(sizeof(FileParser));
    if (parser) {
        parser->file_pointer = fopen(file_name, "r");
        parser->buffer = malloc(BUFFER_SIZE);
    }
    if (!parser->file_pointer || !parser->buffer) {
        cleanupParser(parser);
        return NULL;
    }
    return parser;
}

void cleanupParser(FileParser *parser) {
    if (parser) {
        if (parser->file_pointer) {
            fclose(parser->file_pointer);
        }
        if (parser->buffer) {
            free(parser->buffer);
        }
    }
    free(parser);
}




/*
 * rewrite with struct and free memory in anather function
int parseFile(char* file_name) {
    int return_value = ERROR;
    FILE *file_pointer = 0;
    char *buffer = 0;

    assert(file_name != NULL && "Incorrect file name");
    if ((file_pointer = fopen(file_name, "r")) && (buffer = malloc(BUFFER_SIZE))) {
        return_value = searchFileForKeywords(buffer, file_pointer);
    }

    if (file_pointer) fclose(file_pointer);
    if (buffer) free(buffer);

    return return_value;
}
*/

/*
 * rewrite without goto and use if's agane

int parseFile(char* file_name) {
    int return_value = ERROR;
    FILE *file_pointer = 0;
    char *buffer = 0;

    assert(file_name != NULL && "Incorrect file name");
    if (!(file_pointer = fopen(file_name, "r"))) goto error_fileopen;
    if (!(buffer = malloc(BUFFER_SIZE))) goto error_malloc;

    return_value = searchFileForKeywords(buffer, file_pointer);
    free(buffer);

error_malloc:
    fclose(file_pointer);
error_fileopen:
    return return_value;


    return return_value;
}
*/


/*
 * rewrite with goto use
int parseFile(char* file_name) {
    int return_value = ERROR;
    FILE *file_pointer = 0;
    char *buffer = 0;

    assert(file_name != NULL && "Incorrect file name");
    if ((file_pointer = fopen(file_name, "r")) > 0) {
        if ((buffer = malloc(BUFFER_SIZE)) != NULL) {
            return_value = searchFileForKeywords(buffer, file_pointer);
            free(buffer);
        }
        fclose(file_pointer);
    }
    return return_value;
}

*/

/*
 * add more checking

int parseFile(char *file_name) {
    int return_value = ERROR;
    FILE *file_pointer = 0;
    char *buffer = 0;

    if (file_name == NULL) {
        return ERROR;
    }
    if ((file_pointer = fopen(file_name, "r")) > 0) {
        if ((buffer = malloc(BUFFER_SIZE)) != NULL) {
            return_value = searchFileForKeywords(buffer, file_pointer);
            free(buffer);
        }
        fclose(file_pointer);
    }
    return return_value;
}
*/

/*
 * this function better, but still we can improve thet
int parseFile(char *file_name) {
    int return_value = ERROR;
    FILE *file_pointer = 0;
    char *buffer = 0;

    if (file_name != NULL) {
        if ((file_pointer = fopen(file_name, "r")) > 0) {
            if ((buffer = malloc(BUFFER_SIZE)) != NULL) {
                return_value = searchFileForKeywords(buffer, file_pointer);
                free(buffer);
            }
            fclose(file_pointer);
        }
    }
    return return_value;
}
*/



/*
 * this is problem function, bicouse a lot of if's and all realisation in the
 * same function
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
*/

int main() {
    int check = 0;
    check = parseFile("test.txt");
    printf("%d\n", check);
    return 0;
}
