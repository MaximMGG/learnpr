#include <iostream>


template <typename T> T add(T t, T b) {
    return t + b;
}

template <typename T> T mult(T t, int i) {
    return (T) (t * i);
}



int main() {

    // std::cout << add(2, 3) << '\n';
    // std::cout << add(1.2, 3.4) << '\n';
    std::cout << mult(2, 3) << '\n';
    std::cout << mult(1.2, 3) << '\n';
    

    return 0;
}
