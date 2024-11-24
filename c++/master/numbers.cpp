#include <iostream>
#include <iomanip>


int main() {
    // int e;
    // int b {};
    // int c {10};
    // int d {1414};
    //
    // std::cout << "Number e - " << e << '\n';
    // std::cout << "Number b - " << b << '\n';
    // std::cout << "Number c - " << c << '\n';
    // std::cout << "Number d - " << d << '\n';
    //
    //
    unsigned char c {1};
    unsigned short s {2};
    unsigned int i {3};
    unsigned long l {4};
    unsigned long long int ll {5};
    long double d {3.398273492873498};
    double dd {3.14e-8};
    std::cout << std::setprecision(20);
    std::cout << "Value is: " << c << " size is: " << sizeof(c) << '\n';
    std::cout << "Value is: " << s << " size is: " << sizeof(s) << '\n';
    std::cout << "Value is: " << i << " size is: " << sizeof(i) << '\n';
    std::cout << "Value is: " << l << " size is: " << sizeof(l) << '\n';
    std::cout << "Value is: " << ll << " size is: " << sizeof(ll) << '\n';
    std::cout << "Value is: " << d << " size is: " << sizeof(d) << '\n';
    std::cout << "Value is: " << dd << " size is: " << sizeof(dd) << '\n';



    return 0;
}
