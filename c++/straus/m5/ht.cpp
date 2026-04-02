#include <iostream>
#include <cmath>

class SQUD_EXE {
    public:
        std::string msg;
        SQUD_EXE(std::string msg) : msg(msg) {}
        void print_err() {
            std::cout << msg << '\n';
        }
};



double squd_mult(double a, double b, double c) {
    if (pow(b, 2) - (4 * a * c) < 0) {
        throw SQUD_EXE("b^2 - 4ac can not be 0");
    }

    double x_first = ((-b) + sqrt(pow(b, 2) - (4 * a * c))) / 2 * a;
    double x_second = ((-b) - sqrt(pow(b, 2) - (4 * a * c))) / 2 * a;

    std::cout << "+ = " << x_first << "\n";
    std::cout << "- = " << x_second<< "\n";

    return 0;
}



int main() {
    try {
        squd_mult(1.5, 125.3, 9.9);
    } catch (SQUD_EXE e) {
        e.print_err();
    }
    return 0;
}
