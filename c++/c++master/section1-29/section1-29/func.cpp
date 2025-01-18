#include <iostream>
//#include "headers/compare.h"


constexpr int get_value(int multipler) {
    return 3 * multipler;
}


void print_sum(int *a, int *b) {
    std::cout << *a + *b << '\n';
}


void foo3(int a, int b) {
    a += b;
    std::cout << a << '\n';
}


void compute(int age = 32, double weight = 70.5, double distance = 4) {
    std::cout << "Doint computations on age : " << age
        << " weight : " << weight
        << " distance : " << distance << '\n';
}


double min(double a, double b) {return a > b ? b : a;}


void foo(int& a, int *b) {
    a++;
    (*b)++;
}

void foo2(int *a, int *b) {
    *a++;
}

double sum(const double (&arr)[5]) {
    double s{};
    for(double d : arr) {
        s += d;
    }

    return s;
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

double sum_m(const double array[][3], size_t size) {
    double sum_t{};
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < 3; j++) {
            sum_t += *(*array + i) + j;
        }

    }
    return sum_t;
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

    //std::cout << comp_int(res, res2) << '\n';

    unsigned long long int i1 = 123432;
    unsigned long long int i2 = 2200330022;

    std::cout << std::boolalpha << is_palindrome(i1) << '\n';
    std::cout << std::boolalpha << is_palindrome(i2) << '\n';

    int x{3};
    int y{4};
    foo2(&x, &y);
    const double d_arr[][3] {
                {2.2, 2.2, 2.2},
                {1.1, 1.1, 1.1},
                {3.3, 3.3, 3.3}
                            };

    double d_arr_sum = sum_m(d_arr, 3);

    std::cout << "d_arr_sum : " << d_arr_sum << '\n';

    compute(111, 23.1);

    compute();

    print_sum(&res, &res2);

    int aa {1};
    int bb {2};

    foo3(aa, bb);

    std::cout << get_value(bb) << '\n';

    std::cout << x << '\n';

    double arr[] {14.1, 2, 4, 5, 1};

    std::cout << sum((arr)) << '\n';

    return 0;
}
