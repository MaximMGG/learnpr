#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>



char *get_local_dir() {
    char *cwd = malloc(sizeof(char) * 512);
    getcwd(cwd, 512);
    if (cwd != NULL) {
        return cwd;
    } else {
        fprintf(stderr, "Cwd is null\n");
        fflush(stderr);
        return NULL;
    }
}

void remove_exe(char *path) {
    struct stat sb;
    if (stat(path, &sb) == -1) {
        fprintf(stderr, "error check stat for file %s\n", path);
    }

    if (S_ISREG(sb.st_mode) && (sb.st_mode & S_IXUSR)) {
        printf("Removing file %s...\n", path);
        remove(path);
    }
}

const char *exe_name[] = {".so", ".sh", ".clr", "remexe"};
#define EXE_NAME_LEN 4

int check_exe_name(const char *name) {
    char *f;
    for(int i = 0; i < EXE_NAME_LEN; i++) {
        if ((f = strstr(name, exe_name[i])) == NULL) {
            continue;
        } else {
            return -1;
        }
    }
    return 0;
}

void scan_dir(char *full_path) {
    DIR *dir = opendir(full_path);
    if (dir == NULL) {
        fprintf(stderr, "Cant open dir %s\n", full_path);
    }
    struct dirent *dd;
    printf("Check dir %s...\n", full_path);

    while((dd = readdir(dir)) != NULL) {
        if (strcmp(dd->d_name, ".") == 0 ||strcmp(dd->d_name, "..") == 0) {

        } else {
            if (dd->d_type == DT_DIR) {
                char *path_cpy = malloc(sizeof(char) * 512);
                strcpy(path_cpy, full_path);
                strcat(path_cpy, "/");
                strcat(path_cpy, dd->d_name);
                scan_dir(path_cpy);
                free(path_cpy);
            } else if (dd->d_type == DT_REG) {
                char pathcpy[512];
                strcpy(pathcpy, full_path);
                strcat(pathcpy, "/");
                strcat(pathcpy, dd->d_name);
                if (check_exe_name(dd->d_name) == 0) {
                    remove_exe(pathcpy);
                }
            }
        }
    }
}


int main() {
    char *path = get_local_dir();
    scan_dir(path);

    free(path);

    return 0;
}
