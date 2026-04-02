#include <iostream>


const double *p1(const double arr[], int i);
const double *p2(const double*, int);
const double *p3(const double*, int);
int aaaa(int);

int main() {
    const double *(*a1[])(const double *, int){p1, p2, p3};
    int (*megafunc)(int) = aaaa;
    megafunc(2);
    // const double *(*(*a2))(const double *, int){p1, p2, p3};
    //

    const double *(**b1)(const double *, int) = a1;

    const double *bb {0};

    (*(b1 + 1))(bb, 1);

    std::cout << "Hello" << std::endl;
    return 0;
}

const double *p2(const double *arr, int x) {

    return arr;
}

