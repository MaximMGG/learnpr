#include <stdio.h>


extern double do_sum(double x, double y);


int main() {

    double x = 1.0;
    double y = 2.0;
    printf("%lf\n", do_sum(x, y));

    return 0;
}
