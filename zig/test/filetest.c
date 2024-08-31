#include <stdio.h>
#include <dirent.h>


int main() {

    DIR *d = opendir("../");
    struct dirent *dd;

    while((dd = readdir(d)) != NULL) {
        printf("file -> %s\n", dd->d_name);
    }

    closedir(d);

    return 0;
}
