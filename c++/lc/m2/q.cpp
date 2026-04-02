#include <iostream>


int doubleNumber(int a ) {

    return a * 2;
}

int main() {

    int x{};
    std::cout << "Enter the number: ";
    std::cin >> x;
    std::cout << doubleNumber(x) << std::endl;

    return 0;
}

