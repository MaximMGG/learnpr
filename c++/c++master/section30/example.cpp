#include <iostream>
#include <concepts>
#include <type_traits>


template <typename T, typename P>
concept ConvertibleToStdString = requires (T t, P p) {
    std::to_string(t);
    std::to_string(p);
};

template <typename T, typename P>
requires ConvertibleToStdString<T, P>
auto concatenate(const T n1, const P n2) -> decltype(std::to_string(n1) + std::to_string(n2));


int main() {

    auto res = concatenate(11, 22.22);
    std::cout << "res : " << res << '\n';

    float a {3.3};

    std::floating_point auto c = a;


    return 0;
}

template <typename T, typename P>
requires ConvertibleToStdString<T, P>
auto concatenate(const T n1, const P n2) -> decltype(std::to_string(n1) + std::to_string(n2)) {
    return std::to_string(n1) + std::to_string(n2);
}
