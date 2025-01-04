#include <iostream>
#include "headers/compare.h"


double min(double a, double b) {return a > b ? b : a;}


void foo(int& a, int *b) {
    a++;
    (*b)++;
}


bool is_palindrome(unsigned long long int num) {
    unsigned long long int tmp = num;
    std::cout << "input : " << num << '\n';

    unsigned long long int res {};
    while(tmp != 0) {
        int a = tmp % 10;
        if (res == 0) {
            res = a;
        } else {
            res *= 10;
            res += a;
        }
        tmp /= 10;
    }

    std::cout << "revers : " << res << '\n';
    return res == num;
}



int main() {
    double a {1.8};
    double b {3.5};

    int res (min(a,b));
    int res2 {static_cast<int>(min(a,b))};
    int res3 {(int)min(a, b)};

    std::cout << "1 : " << res << ", 2 : " << res2 << ", 3 : " << res3 << '\n';

    foo(res, &res2);
    std::cout << "1 : " << res << ", 2 : " << res2 << ", 3 : " << res3 << '\n';

    std::cout << comp_int(res, res2) << '\n';

    unsigned long long int i1 = 123432;
    unsigned long long int i2 = 2200330022;

    std::cout << std::boolalpha << is_palindrome(i1) << '\n';
    std::cout << std::boolalpha << is_palindrome(i2) << '\n';



    return 0;
}
