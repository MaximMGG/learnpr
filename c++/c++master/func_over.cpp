#include <iomanip>
#include <iostream>
#include <limits>


// int max(int a, int b) {
//     std::cout << "int" << '\n';
//     return a > b ? a : b;
// }


double max(double a, double b) {
    std::cout << "double" << '\n';
    return a > b ? a : b;
}

std::string_view max(std::string_view a, std::string_view b) {
    std::cout << "std::string_view" << '\n';
    return a > b ? a : b;
}

int foo(int a) {

    return a + 1;
}
int foo(unsigned int a) {
    return a + 2;
}


int max(int *a, int b) {
    return *a > b ? *a : b;
}

const int& max(const int& a, const int& b) {
    std::cout << "int&\n";
    return a > b ? a : b;
}

int main() {

    unsigned int a = (int)'A' << 24;
    a |= (unsigned int)'A' << 16;
    a |= (unsigned int)'A' << 8;
    a |= (unsigned int)'A';
    a &= (unsigned int)0xFFFC;
    unsigned int ai {a};
    int bi {88};


    char A {'A'};
    unsigned int str {static_cast<unsigned int>(A)};
    str <<= 8;
    str |= A;
    str <<= 8;
    str |= A;
    str <<= 8;
    str |= A;


    char ac {'Q'};
    char bc {'I'};


    double ad{3.1};
    double bd{88.1};
    const char *b {"ihoih"};


    std::string_view as {"Cat"};
    std::string_view bs {"Dog"};
    std::string_view bb {(const char *)(&str)};

    std::cout << std::hex << ai << '\n';
    std::cout << max(ai, bi) << '\n';
    std::cout << std::setprecision(3) << max((int)ad, (int)bd) << '\n';
    std::cout << max(as, bs) << '\n';
    std::cout << bb << '\n';
    std::cout << max(bb, bs) << '\n';
    std::cout << max((int)ac, (int)bc) << '\n';

    std::cout << (const char *)(&ai) << '\n';

    char show = (char)(ai >> 24);
    std::cout << show << '\n';

    int o = 1;
    std::cout << foo(o) << '\n';


    return 0;
}
