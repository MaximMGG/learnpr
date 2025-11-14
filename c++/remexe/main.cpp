#include <iostream>
#include <string>
#include <cstdio>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

void print_level(int level) {
    for(int i = 0; i < level; i++) std::cout << "  ";
}


void process_dir(std::string dir_name, int level) {
    print_level(level);
    std::cout << "Check dir: " << dir_name << '\n';
    DIR *d = opendir(dir_name.c_str());
    if (d == NULL) {
        return;
    }
    struct dirent *di;
    while((di = readdir(d)) != NULL) {
        if (di->d_name[0] == '.') continue;
        if (di->d_type == DT_DIR) {
            process_dir(dir_name + "/" + di->d_name, level + 1);
            continue;
        } else if (di->d_type == DT_REG) {
            struct stat st;
            std::string file_name(dir_name + "/" + di->d_name);
            stat(file_name.c_str(), &st);
            if (st.st_mode & S_IXUSR) {
                print_level(level);
                std::cout << "Remove file: " << file_name << '\n';
                remove(file_name.c_str());
            }
        }

    }
    closedir(d);
}


int main() {
    process_dir(".", 0);
    return 0;
}
