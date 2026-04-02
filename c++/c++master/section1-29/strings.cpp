#include <cstring>
#include <iostream>
#include <iomanip>
#include <string>
#include <unistd.h>
#include <cstdlib>
#include <cassert>

int main() {
    char *loc = std::setlocale(LC_COLLATE, "cs_CZ.iso88592");
    assert(loc);

    std::string in1 = "hrnec";
    std::string out1(1 + std::strxfrm(nullptr, in1.c_str(), 0), ' ');
    std::string in2 = "chrt";
    std::string out2(1 + std::strxfrm(nullptr, in2.c_str(), 0), ' ');

    std::strxfrm(&out1[0], in1.c_str(), out1.size());
    std::strxfrm(&out2[0], in2.c_str(), out2.size());

    std::cout << "In Czech locale: ";
    if (out1 < out2)
        std::cout << in1 << " before " << in2 << '\n';
    else
        std::cout << in2 << " before " << in1 << '\n';

    std::cout << "In lexicographical comparison: ";
    if (in1 < in2)
        std::cout << in1 << " before " << in2 << '\n';
    else
        std::cout << in2 << " before " << in1 << '\n';

    std::cout << "std::strchr-----\n";
    const char *ex1 = "Hello, this is string for strchr\n";
    std::cout << "string after strchr: " << std::strchr(ex1, 'f');

    char *bu = new char[100] {0};

    std::cout << "user name : " << getcwd(bu, 100);


    delete [] bu;

    std::cout << "strcat\n";

    char msg[50] {"First "};
    char msg2[50] {"second"};

    std::strcat(msg, msg2);
    std::cout << "First + second = " << msg << '\n';

    std::cout << "==================\n";

    const char *test1 {"will old space the replace"};
    const char *test2 {"dkfj oioi build sky  kjdf"};
    const char *test3 {"kj ieif lksmd is ;aof"};
    const char *test4 {"ij  os kd blue aa "};
    char *res = new char [20];

    std::strncpy(res, std::strstr(test1, "the"), 4);
    std::cout << res << '\n';
    std::strncpy(res + std::strlen(res), std::strstr(test2, "sky"), 4);
    std::cout << res << '\n';
    std::strncpy(res + std::strlen(res), std::strstr(test3, "is"), 3);
    std::cout << res << '\n';
    std::strncpy(res + std::strlen(res), std::strstr(test4, "blue"), 4);

    std::cout << res << '\n';

    //comment


    return 0;
}
