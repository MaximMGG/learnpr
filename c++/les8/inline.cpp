#include <iostream>


#define SQR(x, y) x * y
inline double sqr(double x, double y) {return x * y;}

int main() {

    double x = 2.2, y = 4.5;
    double c = sqr(x, y);
    double d = SQR(x, y);

    std::cout << c << std::endl;
    std::cout << d << std::endl;

    return 0;
}
