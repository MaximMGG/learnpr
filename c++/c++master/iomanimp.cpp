#include <iomanip>
#include <iostream>


int main() {

    std::cout << "Hello world!\n";

    std::cout << std::setw(20) << "Hello world\n";
    std::cout << std::left;
    std::cout << std::setfill('#');
    std::cout << std::setw(20) << "Hello world";
    std::cout << "\n";
    std::cout << std::showpos;
    std::cout << 123123 << '\n';

    const char *str = "Bob running";

    std::cout << std::hex << 12 << '\n';

    std::cout << std::noshowpos;

    double a{3.1415926535897932384626433832795};
    double b{2006.0};
    double c{1.34e-10};

    std::cout << "\n";
    std::cout << "double values (default) : " << '\n';
    std::cout << "a: " << a << '\n';
    std::cout << "b: " << b << '\n';
    std::cout << "c: " << c << '\n';
    std::cout << '\n';

    std::cout << "double values (fixed) : " << '\n';
    std::cout << std::fixed;
    std::cout << "a: " << a << '\n';
    std::cout << "b: " << b << '\n';
    std::cout << "c: " << c << '\n';

    std::cout << std::endl;

    std::cout << "double values (scientific) : " << '\n';
    std::cout << std::scientific;
    std::cout << "a: " << a << '\n';
    std::cout << "b: " << b << '\n';
    std::cout << "c: " << c << '\n';
    std::cout << '\n';

    std::cout << "double values (back to defaults) : " << '\n';
    std::cout.unsetf(std::ios::scientific | std::ios::fixed);
    std::cout << "a: " << a << '\n';
    std::cout << "b: " << b << '\n';
    std::cout << "c: " << c << '\n';

    std::cout << '\n';

    std::cout << "a (default precision(6)) : " << a << '\n';
    std::cout << std::setprecision(10);
    std::cout << "a (precision(10)) : " << a << '\n';
    std::cout << std::setprecision(20);
    std::cout << "a (precision(20)) : " << a << '\n';
    std::cout << std::fixed;
    std::cout << "c (precision(20)) : " << c << '\n';
    std::cout.unsetf(std::ios::scientific | std::ios::fixed);

    std::cout << std::setprecision(6);

    double d{12};
    double e{2};


    std::cout << "a: " << a << '\n';
    std::cout << "d: " << d << '\n';
    std::cout << "e: " << e << '\n';

    std::cout << std::showpoint;
    std::cout << "Whith points\n";
    std::cout << "a: " << a << '\n';
    std::cout << "d: " << d << '\n';
    std::cout << "e: " << e << '\n';
    std::cout << '\n';
    std::cout << std::flush;




    return 0;
}
