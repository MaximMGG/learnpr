#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>


int main(int argc, char **argv) {

    if (argc == 3) {
        int fd = open(argv[1], O_CREAT | O_APPEND | O_RDWR, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
        int number_of_bytes = atol(argv[2]);
        char f[number_of_bytes];
        lseek(fd, 0, SEEK_END);
        int write_bytes = write(fd, f, number_of_bytes);
        printf("Write into file %s, %d bytes\n", argv[1], number_of_bytes);
        close(fd);
    } else if (argc == 4) {
        if (argv[3][0] == 'x' || argv[3][0] == 'X') {
            int fd = open(argv[1], O_CREAT | O_RDWR, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
            int number_of_bytes = atol(argv[2]);
            char f[number_of_bytes];
            int write_bytes = write(fd, f, number_of_bytes);
            printf("Write into file %s, %d bytes\n", argv[1], number_of_bytes);
            close(fd);
        }
    } else {
        fprintf(stderr, "Not correct usage: [PROG] [FILE_NAME] [NUMBER_OF_BYTES][x]");
        return 1;
    }


    return 0;
}
