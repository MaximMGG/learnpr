#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>

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
        sprintf(buf, "%s/%s", path, _dirent->d_name);
        if (_dirent->d_type == DT_DIR) {
            if (!access(buf, R_OK | W_OK)) {
                printf("Dir \e[0;32m%s\e[0m\n", buf);
            } else {
                printf("Dir \e[0;31m%s\e[0m\n", buf);
            }
            traverse(buf);
        } else {
            struct stat s;
            stat(buf, &s);
            if (s.st_mode & S_IXUSR) {
                if (!access(buf, X_OK)) {
                    printf("Exe - \e[0;32m%s\e[0m\n", buf);
                } else {
                    printf("Exe - \e[0;31m%s\e[0m\n", buf);
                }
            } else {
                if (!access(buf, R_OK | W_OK)) {
                    printf("File - \e[0;32m%s\e[0m\n", buf);
                } else {
                    printf("File - \e[0;31m%s\e[0m\n", buf);
                }
            }
        }
        memset(buf, 0, 128);
    }
    closedir(d);
}

int main(int argc, char **argv) {

    traverse(argc > 1 ? argv[1] : ".");


    return 0;
}
