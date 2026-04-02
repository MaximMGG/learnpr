#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>

int (*func)(int a, int b);

int main() {

    void *handle = dlopen("./mann.so", RTLD_LAZY);

    if (!handle) {
        fprintf(stderr, "%s", dlerror());
    }

    func = dlsym(handle, "sum");

    int a = func(2, 3);

    printf("%d\b", a);

    return 0;
}
