#include <iostream>
#include <limits>
#include <bitset>
#include <unistd.h>


constexpr int foo(const int a, const int b) {
    return a * b + a - b + b / a;
}

// const constinit int age1 {123};


int main() {

    constexpr int a{213341};
    constexpr int b{34343434};
    constexpr int VERS{1};
    std::cout << "Constexpr code from foo: " << foo(a, b) << '\n';

    static_assert(VERS == 1);
    std::cout << "Vers\n";

    int c = 3;
    const int aa = 1;
    constexpr int r {aa};


    double d1 {23423482937483742.0023434};
    int i1 = 33;
    int i2 = 44;
    int i3 = (int)d1;

    std::cout << i1 << '\n';
    std::cout << i2 << '\n';
    std::cout << i3 << '\n';
    std::cout << std::numeric_limits<int>::min() << '\n';
    int for_bit {255};

    std::cout << "bin representation : " << std::bitset<sizeof(double) * 8>(d1) << "\n";
    std::cout << "bin representation : " << std::bitset<sizeof(for_bit) * 8>(for_bit) << "\n";

    auto a1 = std::bitset<32>(i1);
    auto a2 = std::bitset<32>(i2);

    unsigned long magic {std::numeric_limits<unsigned short>::max()};

    while(true) {
        for(int i = 0; i < 48; i++) {
            magic <<= 1;
            std::cout << std::bitset<64>(magic) << '\n';
            usleep(20000);
        }
        for(int i = 0; i < 48; i++) {
            magic >>= 1;
            std::cout << std::bitset<64>(magic) << '\n';
            usleep(20000);
        }
    }

    return 0;
}
