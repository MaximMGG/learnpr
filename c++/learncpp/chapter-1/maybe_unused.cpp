#include <iostream>


int main() {

    [[maybe_unused]]int a {1};
    [[maybe_unused]]int b {3};
    [[maybe_unused]]int c {4};


    std::cout << a << " " << b << '\n';


    return 0;
}
