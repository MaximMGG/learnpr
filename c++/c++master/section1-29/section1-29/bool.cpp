#include <iostream>


int main() {

    bool a {true};
    bool b {false};


    std::cout << "a -> " << a << '\n';
    std::cout << "b -> " << b << '\n';

    std::cout << std::boolalpha;

    std::cout << "a -> " << a << '\n';
    std::cout << "b -> " << b << '\n';

    return 0;
}
