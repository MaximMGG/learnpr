#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>
#include <time.h>


#define RED "\e[0;32m"
#define GREEN "\e[0;33m"
#define RESET "\e[0m"

void printWrites(struct stat *st) {
    if (S_ISDIR(st->st_mode)) {
        printf("d");
    } else if (S_ISLNK(st->st_mode)){
        printf("l");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IRUSR) {
        printf("r");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IWUSR) {
        printf("w");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IXUSR) {
        printf("x");
    } else {
        printf("-");
    }

    if (st->st_mode & S_IRGRP) {
        printf("r");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IWGRP) {
        printf("w");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IXGRP) {
        printf("x");
    } else {
        printf("-");
    }

    if (st->st_mode & S_IROTH) {
        printf("r");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IWOTH) {
        printf("w");
    } else {
        printf("-");
    }
    if (st->st_mode & S_IXOTH) {
        printf("x");
    } else {
        printf("-");
    }
    printf(" ");
}


void printFile(const char *path, const char *file_name) {
    char buf[PATH_MAX] = {0};
    sprintf(buf, "%s/%s", path, file_name);

    struct stat _stat;

    if (lstat(buf, &_stat)) {
        perror("lstat error");
        exit(1);
    }
    printWrites(&_stat);

    printf("%ld\t", _stat.st_nlink);

    printf("%ld\t", _stat.st_size);


    char buf_time[64] = {0};
    struct tm *timeinfo = localtime(&_stat.st_mtime);
    strftime(buf_time, 64, "%b %d %H:%M", timeinfo);
    printf("%s ", buf_time);


    if (S_ISDIR(_stat.st_mode)) {
        printf(GREEN"%s"RESET"\n", buf);
    } else if (S_ISLNK(_stat.st_mode)) {
        char link_buf[4096] = {0};
        if (readlink(buf, link_buf, 4096) == -1) {
            fprintf(stderr, "Cant read symb link\n");
            return;
        }
        printf("%s -> %s\n", buf, link_buf);
    } else {
        printf("%s\n", buf);
    }

}



void traverse(const char *path) {
    DIR *d = opendir(path);
    if (!d) {
        fprintf(stderr, "Cant open dir %s\n", path);
        exit(1);
    }

    struct dirent *_dirent;
    char buf[PATH_MAX] = {0};
    while((_dirent = readdir(d)) != NULL) {
        if (_dirent->d_name[0] == '.') {
            continue;
        }
        printFile(path, _dirent->d_name);
    }

    closedir(d);
}

int main(int argc, char **argv) {

    traverse(argc > 1 ? argv[1] : ".");


    return 0;
}
