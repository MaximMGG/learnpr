#include <iostream>

int main() {

    int x{};
    int y{};
    std::cout << "Enter an integer: ";
    std::cin >> x;
    std::cout << "Enter another integer: ";
    std::cin >> y;
    std::cout << y << " + " << x << " is " << y + x << ".\n";
    std::cout << y << " - " << x << " is " << y - x << ".\n";

    return 0;
}
