#include <unistd.h>
#include <stdio.h>
#include <cstdext/core.h>

extern char **environ;

int main() {

    for(i32 i = 0; environ[i] != null; i++) {
        printf("%s\n", environ[i]);
    }

    return 0;
}
