
typedef enum {
    OK,
    CANNOT_ADD_KEY

} RegError;

typedef struct Key* RegKey;


RegKey createKey(char* key_name);
RegError storeValue(RegKey key, char* value);
RegError publishKey(RegKey key);
