#include <iostream>
#include <limits>
#include <cstdio>
#include <cmath>





auto& max_ref(double& x, double &y);

void print_int(int x) {
    printf("%d\n", x);
}
void print_double(double x) {
    printf("%lf\n", x);
}
void print_char(char x) {
    printf("%c\n", x);
}

template <typename T> void print_t(T t) {
    std::cout << t << '\n';
}


#define s_c(type, val) static_cast<type>(val)
#define print(val) _Generic((val),      \
                    int: print_int,     \
                    double: print_double,       \
                    char: print_char)(val)


auto ret(int a, int b) {
    if (a > 1) {
        return s_c(double, 1);
    } else {
        return 4.2;
    }
}



const double *find_max_address(const double scores[], unsigned int count) {
    unsigned int max_index{};
    double max{scores[0]};
    for(unsigned int i = 0; i < count; i++) {
        if (scores[i] > max) {
            max = scores[i];
            max_index = i;
        }
    }
    return &scores[max_index];
}



double& mult(double& a, double &b) {
    std::cout << &a << '\n';
    return a *= b;
}


int max_subsequence_sum(int sequence[], unsigned int size) {
    int sum {};
    int max_sum {std::numeric_limits<int>::min()};
    for(int i = 0; i < size; i++) {
        for(int j = i; j < size;  j++) {
            for(int k = j; k < size - j + i; k++) {
                sum += sequence[k];
            }
            if (sum > max_sum) max_sum = sum;
            sum = 0;
        }
    }

    return max_sum;
}


int main() {

    double min {std::numeric_limits<double>::min()};
    int data[] {-2, 2, 3};
    std::cout << max_subsequence_sum(data, 3) << '\n';
    auto v {10.0};
    auto v2 {20.0};

    double res = mult(v, v2);
    std::cout << &res << '\n';


    std::cout << res << " v : " << v << '\n';
    v++;
    std::cout << res << " v : " << v << '\n';

    const double arr[] {-3.0, -2.0, -5.0};

    const double result {*find_max_address(arr, 3)};
    std::cout << "max val if : " << result << '\n';

    // print(123);
    // print(1.4);
    // print(char('x'));

    print_t(123);
    print_t(1.4);
    print_t(char('x'));
    int b {1};
    int c{4};
    c++;

    double val1 {10.0};
    double val2 {20.0};

    double& res2 = max_ref(val1, val2);


    return 0;
}

auto& max_ref(double& x, double &y) {
    return x *= y;
}
