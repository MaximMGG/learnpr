#include "payload.h"
#include "encrypt.h"
#include <stdio.h>
#include <string.h>

int main(void) {

    FILE *payload = fopen("payload.bin", "wb");
    int nbytes = 0;

    if (payload == NULL) {
        fprintf(stderr, "Error payload.bin\n");
        return 1;
    }

    nbytes = (unsigned long)_end - (unsigned long)_payload;
    char buff[nbytes];

    char key[] = "it's a key";
    int klen = strlen(key);

    encrypt_xor(buff, (char *)_payload, nbytes, key, klen);

    fwrite((char *)buff, sizeof(char), nbytes, payload);
    fclose(payload);

    return 0;
}

