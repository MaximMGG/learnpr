#include "Matrix.hpp"


int main() {

    double arr[9] {
        1, 2, 3,
        4, 5, 6,
        7, 8, 9
    };


    Matrix<double> e(3, 3, arr);

    e.print();
    std::cout << "Transporent\n";
    Matrix<double> m = e.transporent();
    m.print();

    return 0;
}
