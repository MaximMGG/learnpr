#include <iostream>


template <typename T>
concept div_two = requires (T t) {t % 2 == 0;};

template <typename T>
requires (div_two<T>)
void some(T t) {
    std::cout << t << '\n';
}


int main (){

    int i{200};
    double b {200.3};

    some(i);
    // some(b);

    return 0;
}

