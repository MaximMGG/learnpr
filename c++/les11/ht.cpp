#include "complex0.h"
#include <iostream>


int main() {

    complex a(3.0, 4.0);
    complex c{0};
    std::cout << "Enter a complex number (q to quit): \n";
    while(std::cin >> c) {
        std::cout << "c is " << c << std::endl;
        complex b = a + c;
        std::cout << "a + c is " << b << std::endl;
        b = a - c;
        std::cout << "a - c is " << b << std::endl;
        b = a * c;
        std::cout << "a * c is " << b << std::endl;
        b = 2 * c;
        std::cout << "2 * c is " << b << std::endl;
        std::cout << "Enter a complex number (q to quit): \n";
    }
    std::cout << "Done!\n";

    return 0;
}
