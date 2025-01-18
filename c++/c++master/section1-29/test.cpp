#include <unistd.h>
#include <iostream>
#include <cstring>

int main() {

     char *buf = new char [100] {0};
     char *buf_name = new char [100] {0};


     std::cout << "cwd is : " << getcwd(buf, 100) << '\n';
     getlogin_r(buf_name, 100);
     std::cout << "user login : " << buf_name << '\n';
     
     std::cout << "strstr\n";
     std::cout << std::strstr(buf, "/home/") << '\n';

     char *token = std::strtok(buf, "/");

     while(token) {
         std::cout << token << '\n';
         token = std::strtok(nullptr, "/");
     }

     delete [] buf;
     delete [] buf_name;

    return 0;
}
