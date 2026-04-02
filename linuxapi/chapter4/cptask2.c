#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char **argv) {
    if (argc < 3)
        fprintf(stderr, "do not setup file\n");

    char *fileFrom = argv[1];
    char *fileTo = argv[2];
    int froms = open(fileFrom, O_RDONLY);
    if (froms == -1)
        fprintf(stderr, "cant open file %s\n", fileFrom);
    int tos = open(fileTo, O_RDWR | O_CREAT, S_IWUSR | S_IRUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
    if (tos == -1)
        fprintf(stderr, "Cant create file %s\n", fileTo);
    int sizeOfFrom = lseek(froms, 0, SEEK_END);
    lseek(froms, 0, SEEK_SET);

    char buf[sizeOfFrom]; 
    memset(buf, 0, sizeOfFrom);
    int readBytes = read(froms, buf, sizeOfFrom);
    if (readBytes < 0) {
        fprintf(stderr, "cant read bytes from file %s\n", fileFrom);
    }
    int writeBytes = write(tos, buf, readBytes);
    if (writeBytes < readBytes) {
        fprintf(stderr, "write{%d} less bytes then read{%d}\n", writeBytes, readBytes);
    } 

    printf("Success\n");
    close(froms);
    close(tos);

    return 0;
}
