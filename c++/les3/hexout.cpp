#include <iostream>


int main() {

    int chest {42};
    int waist = 42;
    int inseam = 42;

    std::cout << "Monsieur cuts a striking figure!" << "\n";
    std::cout << "chest = " << chest << " (decimal for 42)" << '\n';
    std::cout << std::hex;
    std::cout << "waist = " << waist << " (hexadecimal for 42)" << '\n';
    std::cout << std::oct;
    std::cout << "inseam = " << inseam << " (octal for 42)" << '\n';

    return 0;
}
