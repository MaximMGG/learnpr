#include <iostream>

int sum(int a, int b) {
    return a + b;
}



int main() {

    // int a {2};
    // int b {3};

    const int c {6};
    const int d {6};

    constexpr int e {11};
    constexpr int f {11};


    // std::cout << "int int : " << sum(a, b) << '\n';
    std::cout << "cosnt int const int : " << sum(c, d) << '\n';
    std::cout << "constexpr int constexpr int : " << sum(e, f) << '\n';
    std::cout << "literal literal : " << sum(20, 20) << '\n';


    return 0;
}
