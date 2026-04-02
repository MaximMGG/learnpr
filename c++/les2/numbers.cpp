#include <iostream>
#include <stdio.h>
#include <climits>
#include <cfloat>


int main() {

    using namespace std;

    char a;
    short b;
    int c;
    long d;
    long long e;
    float f;
    double g;
    long double h;
    std::cout << sizeof(a) << " "\
                << sizeof(b) << " " \
                << sizeof(c) << " " \
                << sizeof(d) << " " \
                << sizeof(e) << " " \
                << sizeof(f) << " " \
                << sizeof(g) << " " \
                << sizeof(h) << " " << std::endl;

    a = CHAR_MAX;
    b  = SHRT_MAX;
    c = INT_MAX;
    d = LONG_MAX;
    e = LLONG_MAX;

    printf("%d %d %d %ld %lld", a, b, c, d, e);


    int aa{12};

    std::cout.put('!');
    std::cout.put('\n');

    std::cout << '$' << std::endl;

    std::cout.put('$');
    std::cout.put('\n');


    int k\u00F6rper;
    std::cout << "Let them eat g\u00E2teau. \n";


    double ff = 1.534e+8;
    double fd = 1.534e-8;
    double dg = 1.534e10;
    std::cout << (double)ff << std::endl;
    std::cout << fd << std::endl;
    std::cout << dg << std::endl;

    float ti;

    printf("%lf\n", ff);
    printf("%lf\n", fd);
    printf("%lf\n", dg);

    float sum = 1.23e+11;
    float buym2 = sum + 1.0;

    cout << buym2 - sum << endl;


    return 0;
}
