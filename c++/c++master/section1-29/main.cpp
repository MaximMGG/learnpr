//#include "util.h"
#include <iostream>

template <typename T, typename P>
auto add(T a, P b) -> decltype(a > b ? a : b);


template <typename T, typename P>
decltype(auto) bar(T t, P p) {
    return t > p ? t : p;
}

template <typename Ret = double, typename T, typename P>
Ret maximum(T a, P b) {
    return a > b ? a : b;
}


template <int threshold, typename T>
bool is_valid(T collection[], size_t size) {
    T sum{};

    for(size_t i{}; i < size; i++) {
        sum += collection[i];
    }
    return (sum > threshold) ? true : false;
}




int main() {


    char a = 123;
    int b = 3;
    int c = 5;


    auto result = add(11, 22ul);
    std::cout << "result: " << result << '\n';
    std::cout << "size of result : " << sizeof(result) << '\n';

    std::cout << bar(char('a'), 12l) << '\n';
    
    auto res = maximum(b, c);
    std::cout << res << " sizeof : " << sizeof(res) << '\n';

    auto res2 = maximum<char, double, double>(b, c);
    std::cout << static_cast<double>(res2) << " sizeof : " << sizeof(res2) << '\n';
    


    double temperature[] = {10, 20, 30.0, 40,0, 50,0, 61,9};

    bool valid = is_valid<700>(temperature, std::size(temperature));

    std::cout << std::boolalpha << valid << '\n';







    return 0;
}


template <typename T, typename P>
auto add(T a, P b) -> decltype(a > b ? a : b){
    return a + b;

}
