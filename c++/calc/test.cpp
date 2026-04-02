#include <iostream>
#include <cstdlib>


int main(int argc, char **argv) {
    if (argc < 3) {
        std::cout << "Usage: enter y = , x = \n";
        return 1;
    }
    double mistake {0.01};

    double x{std::stof(argv[1])};
    double y{std::stof(argv[2])};

    double A {10.00001};

    std::cout << "Entered value is : X - " << x << ", Y - " << y << '\n';
    std::cout << "Started A - " << A << '\n';

    while(true) {
        double res = A * x;
        if (res >= y - mistake && res <= y + mistake) {
            break;
        } else {
            A = (((y - res) / x)) * 0.5 + A;
        }

        std::cout << "A - " << A << '\n';
    }


    std::cout << "Final result : " << y << " = " << A << " * " << x << '\n';

    return 0;
}
