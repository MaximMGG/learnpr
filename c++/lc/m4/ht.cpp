#include <iostream>
#include <stdio.h>


int main() {

    double a{};
    double b{};
    double result{};
    char operation{};

    std::cout << "Enter the first value: ";
    std::cin >> a;
    std::cout << "Enter the second value: ";
    std::cin >> b;
    std::cout << "Enter the operation (+, -, /, *): ";
    std::cin >> operation;

    switch (operation) {
        case '+': {
            result = a + b;
        } break;
        case '-': {
            result = a - b;
        } break;
        case '/': {
            result = a / b;
        } break;
        case '*': {
            result = a * b;
        } break;
        default: {
            exit(0);
        }
    }

    printf("Result of expression %.2lf %c %.2lf is: %.2lf\n", a, operation, b, result);

    return 0;
}
