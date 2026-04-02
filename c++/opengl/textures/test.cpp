#include <fstream>
#include <iostream>
#include <sys/stat.h>
#include <filesystem>


int main() {
    std::fstream f;
    f.open("vertex.glsl", std::ios_base::in);
    struct stat st;
    stat("vertex.glsl", &st);
    int size = st.st_size;

    char *buf = new char[st.st_size];
    f.read(buf, st.st_size);

    std::cout << buf << '\n';

    f.close();
    delete [] buf;

    return 0;
}
