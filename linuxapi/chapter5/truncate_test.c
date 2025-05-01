#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>


int main() {

    const char *file_name = "tt.txt";
    struct stat _stat;
    if (stat(file_name, &_stat) != -1) {
        long file_size = _stat.st_size;
        printf("Old file size - %ld\n", file_size);
        file_size <<= 1;

        truncate(file_name, file_size);
    }


    return 0;
}
