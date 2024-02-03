#include <iostream>


extern "C" double do_sum(double x, double y);
inline double do_sum2(double x, double y) {
    return x + y;
}

typedef struct {
    double x;
    double y;
} vec;



extern "C" void vec_sum(vec *);
void vec_sum2(vec *v) {
    v->x += v->y;
}

int main() {

    double x = 1.24;
    double y = 434.131;

    std::cout << do_sum(x, y) << std::endl;
    std::cout << do_sum2(x, y) << std::endl;

    vec a {1.0, 2.0};
    vec_sum2(&a);
    std::cout << a.x << std::endl;
    vec_sum(&a);
    std::cout << a.x << std::endl;

    return 0;
}
