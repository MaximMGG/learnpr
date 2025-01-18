#include <iostream>
#include <iomanip>
#include <limits>


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


    std::cout << "The range of char is: " << (int)std::numeric_limits<char>::min() << " to " << (int)std::numeric_limits<char>::max() << '\n';
    std::cout << "The range of short is: " << std::numeric_limits<short>::min() << " to " << std::numeric_limits<short>::max() << '\n';
    std::cout << "The range of int is: " << std::numeric_limits<int>::min() << " to " << std::numeric_limits<int>::max() << '\n';
    std::cout << "The range of long is: " << std::numeric_limits<long>::min() << " to " << std::numeric_limits<long>::max() << '\n';
    std::cout << "The range of long long is: " << std::numeric_limits<long long>::min() << " to " << std::numeric_limits<long long>::max() << '\n';

    // std::cout << std::fixed;
    // std::cout << std::setprecision(50);
    std::cout << "The range of float is: " << std::numeric_limits<float>::min() << " to " << std::numeric_limits<float>::max() << '\n';
    std::cout << "The range of double is: " << std::numeric_limits<double>::min() << " to " << std::numeric_limits<double>::max() << '\n';
    std::cout << "The range of long double is: " << std::numeric_limits<long double>::min() << " to " << std::numeric_limits<long double>::max() << '\n';


    return 0;
}
