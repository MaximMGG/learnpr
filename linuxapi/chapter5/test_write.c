#include <stdio.h>
#include <sys/stat.h>
#include <sys/uio.h>
#include <fcntl.h>
#include <unistd.h>

typedef struct {
    int arr[10];
    int cur_len;
    char name[64];
}list;


int main() {

    int fd = open("q.txt", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    if (fd == -1) {
        fprintf(stderr, "Cant open file\n");
        return -1;
    }

    list l1 = {.arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, .cur_len = 10, .name = "Super_duper"};
    list l2 = {.arr = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20}, .cur_len = 10, .name = "Super_duper_camasuer 3"};
    list l3 = {.arr = {8, 7, 9, 11}, .cur_len = 4, .name = "Super_duper"};
    struct iovec s[3] = {
        {.iov_base = &l1, .iov_len = sizeof(list)},
        {.iov_base = &l2, .iov_len = sizeof(list)},
        {.iov_base = &l3, .iov_len = sizeof(list)},
    };
    int bytes = 0;

    bytes = writev(fd, s, 3);
    if (bytes > 0) {
        printf("Done\n");
    }
    close(fd);

	return 0;
}
