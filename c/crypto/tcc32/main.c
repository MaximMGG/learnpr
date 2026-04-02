#include <stdio.h>
#include "encrypt.h"
#include <string.h>


#ifdef __unix__
#include <sys/mman.h>
#endif


#define BUFSIZE 8192
static void *vmalloc(int size);
static int vfree(void *buf, int size);

typedef int (*payload_t)(int x);

int main(void) {

    FILE *payload = fopen("payload.bin", "rb");
    void *exec;

    char buff[BUFSIZE];


    if(payload == NULL) {
        fprintf(stderr, "payload is null\n");
        return 1;
    }


    exec = vmalloc(BUFSIZE);
    fread(buff, sizeof(char), BUFSIZE, payload);
    fclose(payload);

    char key[] = "it's a key";
    int klen = strlen(key);

    encrypt_xor(exec, buff, BUFSIZE, key, klen);


    printf("%d\n", ((payload_t) exec)(234));

    vfree(exec, BUFSIZE);


    return 0;
}

static void *vmalloc(int size) {
#ifdef  __unix__
    return mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC, 
            MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

#elif __WIN32

#endif

}

static int vfree(void *buf, int size) {
#ifdef  __unix__
    return munmap(buf, size);

#elif __WIN32

#endif

}
