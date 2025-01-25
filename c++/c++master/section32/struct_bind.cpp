#include <iostream>

struct Vec3 {
    double x;
    double y;
    double z;

    void print_vec() {
        std::cout << x << y << z << '\n';
    }


};



int main() {

    Vec3 vec1 {12.2, 3.4, 9.2};

    auto& [a, b, c] = vec1;
    vec1.print_vec();

    b = 9999.9;

    vec1.print_vec();
    std::cout << "a : " << a << " b : " << b << " c : " << c << '\n';


    return 0;
}
