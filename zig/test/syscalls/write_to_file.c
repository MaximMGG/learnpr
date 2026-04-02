#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

enum {BUF_SIZE = 1024};

int main(int argc, char **argv) {

    if (argc < 2) {
        fprintf(stderr, "expected filename\n");
        exit(1);
    }

    int fd = open(argv[1], O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR);
    if (fd < 0) {
        fprintf(stderr, "failed open file\n");
        exit(1);
    }
    
    char buf[BUF_SIZE] = {0};

    ssize_t input_size;
    while((input_size = read(STDIN_FILENO, buf, BUF_SIZE)) > 0) {
        if (input_size < 0) {
            fprintf(stderr, "failed read\n");
            exit(1);
        }

        ssize_t output_size = write(fd, buf, input_size);
        if (output_size < 0) {
            fprintf(stderr, "Failed write\n");
            close(fd);
            exit(1);
        }

    }

    int close_res = close(fd);
    if (close_res == -1) {
        fprintf(stderr, "failed close\n");
        exit(1);
    }

    memset(buf, 0, BUF_SIZE);
    strcpy(buf, "End of app\n");

    write(STDOUT_FILENO, buf, strlen(buf));

    return 0;
}
