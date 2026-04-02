#include "reg_key.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>


#define STRING_SIZE 100
#define MAX_KEYS 40
#define false 0

#define logAssert(x)                            \
    if (!(x)) {                                 \
        printf("Error at line %i\n", __LINE__); \
        assert(false);                          \
    }


struct Key {
    char key_name[STRING_SIZE];
    char key_value[STRING_SIZE];
};

static struct Key* key_list[MAX_KEYS];

RegKey createKey(char *key_name) {

    logAssert(key_name != NULL);
    logAssert(STRING_SIZE > strlen(key_name));

    RegKey newKey = calloc(1, sizeof(struct Key));
    if (newKey == NULL) {
        return NULL;
    }
    strcpy(newKey->key_name, key_name);
    return newKey;
}

RegError storeValue(RegKey key, char* value) {
    logAssert(key != NULL && value != NULL);
    logAssert(STRING_SIZE > strlen(value));
    strcpy(key->key_value, value);
    return OK;
}

RegError publishKey(RegKey key) {
    int i;
    logAssert(key != NULL);
    for (i = 0; i < MAX_KEYS; i++) {
        if (key_list[i] == NULL) {
            key_list[i] = key;
            return OK;
        }
    }
    return CANNOT_ADD_KEY;
}
