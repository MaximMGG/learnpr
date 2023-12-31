
typedef struct Key* RegKey;


RegKey createKey(char* key_name);
void storeValue(RegKey key, char* value);
void publishKey(RegKey key);
