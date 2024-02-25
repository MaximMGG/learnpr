#include <iostream>
#include <bitset>
// #include <format>

#define NL '\n'

int main() {

    int c = 2'234'111;

    std::cout << "Decimal: " << std::dec << c << '\n';
    std::cout << "Hex: " << std::hex << c << '\n';
    std::cout << "Octal: " << std::oct << c << '\n';


    std::bitset<8> a {0b0000'0100};
    std::cout << "Bits: " << a << '\n';
    std::cout << "Bits count: " << a.size() << '\n';
    a.set(7);
    std::cout << "Bits: " << a << '\n';
    std::cout << "Bits setted: " << a.count() << NL;
    std::cout << "Checking: " << a.test(3) << '\n';
    a.flip(7);
    std::cout << "Bits: " << a << '\n';
    std::cout << "All set? " << a.all() << NL;
    std::cout << "Any set? " << a.any() << NL;
    a.reset(2);
    std::cout << "Bits: " << a << '\n';
    std::cout << "None bits " << a.none() << NL;
    std::cout << "-------------------------------" << NL;

    // std::cout << std::format("{:b}\n", 0b0100);


    return 0;
}
