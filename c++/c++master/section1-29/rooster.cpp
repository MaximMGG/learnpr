#include <iostream>

int addNumber(const int a = 1, const int b = 1) {
    return a + b;
}



int main() {

    const int a = addNumber();
    const int b = addNumber(a);

    std::cout << a + b  << '\n';

    const int c = addNumber(b, 28);
    std::cout << c + b << '\n';

    return 0;
}
