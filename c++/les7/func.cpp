#include <iostream>


const double *p1(const double[], int);
const double *p2(const double*, int);
const double *p3(const double*, int a);

int main() {
    const double *(*a1[])(const double *, int){p1, p2, p3};
    // const double *(*(*a2))(const double *, int){p1, p2, p3};
    //

    const double *(**b1)(const double *, int) = a1;

    const double *bb;
    (*(b1 + 1))(bb, 1);

    return 0;
}

