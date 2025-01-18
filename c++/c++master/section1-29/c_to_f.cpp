#include <iostream>


int main() {

    double enter;
    std::cout << "Please enter a degree value in Celsius : \n";
    std::cin >> enter;
    std::cout << enter << " Celsius is " << (9.0 / 5) * enter + 32 << " Fahrenheit\n";

    return 0;
}
