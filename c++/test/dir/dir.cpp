#include <iostream>
#include <filesystem>
#include <fstream>
#include <istream>
#include <ostream>
#include <unistd.h>


int main() {
    char buf[100];
    getcwd(buf, 100);

    const std::filesystem::path p {buf};


    for(const auto& dir_enty : std::filesystem::directory_iterator{p}) {
        std::cout << dir_enty.path() << std::endl;
    }



    return 0;
}
