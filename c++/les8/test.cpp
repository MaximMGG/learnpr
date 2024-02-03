#include <iostream>
#include <array>
#include <limits>
#include <limits.h>
#include <float.h>
#include <stdio.h>
#include <string.h>

extern "C" int sum(int x, int y);


int main (){ 
    // int sums = sum(1, 2);
    // std::cout << sums << std::endl;
    // std::cout << "Hello" << std::endl;

    // int arr[3]{1,2,3};
    // int arr[3] = {1,2,3};
    // int arr[3];
    // arr[0] = 1;
    // arr[1] = 2;
    // arr[2] = 3;
    // int *ar;
    // int *ar2 = new int[3];
    // std::array<int, 3> ar_a = {1, 2, 3};
    // int *ar3 = (int *) malloc(sizeof(int) * 3);

    // long l = LONG_MAX;
    // unsigned long long e = ULLONG_MAX;
    // long long w = LLONG_MAX;
    // long double d = LDBL_MAX;
    // d = LDBL_MAX / 20;
    double dd = DBL_MAX;
    // std::cout.setf(std::ios_base::fixed);
    // std::cout << sizeof(l) << std::endl;
    // std::cout << sizeof(w) << std::endl;
    // std::cout << sizeof(d) << std::endl;
    // std::cout << l << std::endl;
    // std::cout << w << std::endl;
    // std::cout << e << std::endl;
    // std::cout << dd << std::endl;
    // std::cout << std::endl;
    // std::cout << d << std::endl;
    // char buf[10000] = {0};
    // snprintf(buf, 10000, "%llf", d);
    // std::cout << strlen(buf) << std::endl;
    // std::cout << std::endl;
    long double max = DBL_MAX;
    for(int i = 0; i < 10; i++) {
        max += dd;
        std::cout << max << std::endl;
    }

    // delete [] ar2;
    // free(ar3);
    return 0;
}
