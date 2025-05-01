#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/uio.h>

typedef struct {
    int arr[10];
    int cur_len;
    char name[64];
}list;


void print_list(list *l) {
    printf("{");
    for(int i = 0; i < l->cur_len; i++) {
        printf("%d, ", l->arr[i]);
    }
    printf("}\n");
    printf("Len - %d\n", l->cur_len);
    printf("Name - %s\n", l->name);
}



int main() {

    int fd = open("q.txt", O_RDONLY);
    if (fd == -1) {
        fprintf(stderr, "Cant open file\n");
        return -1;
    }

    list res[3];
    struct iovec s[3] = {
        {.iov_base = &res[0], .iov_len = sizeof(res)},
        {.iov_base = &res[1], .iov_len = sizeof(res)},
        {.iov_base = &res[2], .iov_len = sizeof(res)},
    };
    int bytes = readv(fd, s, 3);
    if (bytes > 0) {
        printf("Done\n");
    }

    print_list(&res[0]);
    print_list(&res[1]);
    print_list(&res[2]);

    close(fd);
    return 0;
}
