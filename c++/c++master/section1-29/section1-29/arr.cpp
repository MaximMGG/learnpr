#include <iostream>

int main() {

    double *arr {new double[10]{0.1, 0.2, 0.3}};

    double *it = arr;
    for(int i = 0; i < 10; i++) {
        std::cout << *it << '\n';
        it++;
    }

    delete [] arr;

    return 0;
}
