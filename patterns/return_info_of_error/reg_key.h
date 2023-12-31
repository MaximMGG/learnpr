
typedef enum {
    OK,
    OUT_OF_MEMORY,
    INVALID_KEY,
    INVALID_STRING,
    STRING_TOO_LONG,
    CANNOT_ADD_KEY
} RegError;

typedef struct Key* RegKey;


RegError createKey(RegKey *key, char* key_name);
RegError storeValue(RegKey key, char* value);
RegError publishKey(RegKey key);
