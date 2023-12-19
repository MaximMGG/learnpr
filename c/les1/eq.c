#include <stdio.h>
#include <math.h>


double discrim(double a, double b, double c) {
    return b * b - 4 * a * c;
}

int main() {
    double a, b, c, d; 
    a = 10.2;
    b = 0.7;
    c = 12.9;
    d = discrim(a, b, c);


    printf("%lf\n", d);



    return 0;
}
