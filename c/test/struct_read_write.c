#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/uio.h>
#include <cstdext/container/list.h>


#define FILE_NAME "test.inc"


typedef struct {
    char name[64];
    u32 current_consumption; 
    u32 limits;
    i32 difference;
} item;

void item_print(item *i) {
    printf("name: %s\n", i->name);
    printf("current_consumption: %d\n", i->current_consumption);
    printf("limits: %d\n", i->limits);
    printf("difference: %d\n", i->difference);
}


int main(int argc, char **argv) {
   (argc == 1) {
        fprintf(stderr, "Bad useage\n");
        return 1;
    }

    if (argv[1][0] == 'r') {

        list *l = list_create(STRUCT);

        int fd = open(FILE_NAME, O_RDONLY);
        if (fd == -1) {
            fprintf(stderr, "File does not exists\n");
            return 1;
        }

        item i_tmp = {0};
        struct iovec io[1] = {0};
        io[0].iov_len = sizeof(item);
        io[0].iov_base = &i_tmp;

        while(readv(fd, io, 1) == sizeof(item)) {
            item *tmp = make(item);
            memcpy(tmp, &i_tmp, sizeof(item));
            list_append(l, tmp);
        }

        for(int i = 0; i < l->len; i++) {
            item *tmp = list_get(l, i);
            item_print(tmp);
            free(tmp);
        }

        list_destroy(l);
    } else if (argv[1][0] == 'w') {

        setbuf(stdin, NULL);
        int fd = open(FILE_NAME, O_CREAT | O_RDWR | O_APPEND, S_IRUSR | S_IWUSR | S_IXUSR);
        if (fd == -1) {
            fprintf(stderr, "Cant open or create file\n");
            return 1;
        }

        item i = {0};

        byte buf[128] = {0};

        printf("Enter name if item: \n");
        int read_b = read(STDIN_FILENO, buf, 128);
        strcpy(i.name, buf);
        memset(buf, 0, 128);
        printf("Enter current consumption: ");
        read_b = read(STDIN_FILENO, buf, 128);
        i.current_consumption = (u32)atol(buf);
        memset(buf, 0, 128);
        printf("Enter limits: ");
        read_b = read(STDIN_FILENO, buf, 128);
        i.limits = (u32)atol(buf);
        i.difference = i.limits - i.current_consumption;


        struct iovec tmp = {0};
        tmp.iov_base = &i;
        tmp.iov_len = sizeof(i);

        writev(fd, &tmp, 1);

    } else {
        fprintf(stderr, "Not support option %c\n", argv[1][0]);
        return 1;
    }


    return 0;
}
