#include "Matrix.hpp"


int main() {

    double arr1[] {
        1, 3, 7,
        3, 4, 1,
        6, 1, 2
    };

    double arr2[] {
        1,
        3,
        2
    };

    Matrix<double> a1 (3, 3, arr1);
    Matrix<double> a2 (3, 1, arr2);

    a1.print();
    a2.print();
    Matrix res = a1 * a2;

    res.print();


    return 0;
}
