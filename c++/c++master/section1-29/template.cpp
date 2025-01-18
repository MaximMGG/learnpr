#include <iostream>
#include <string>
#include <cstring>
#include <type_traits>


template <typename T> T maximum(T a, T b) {
    return a > b ? a : b;
}

template <> char maximum(char a, char b) {
    return 'Q';
}

template <> const char *maximum(const char *a, const char *b) {
    return std::strcmp(a, b) > 0 ? a : b;
}

template <typename T> int hunt(T v, T* col, int size) {

    return -1;
} 

template <> int hunt<const char *>(const char *val, const char **col, int size) {
    for(int i = 0; i < size; i++) {
        if (strcmp(val, col[i]) == 0) return i;
    }
    return -1;
}


template <typename T, typename P> auto prob_max(T a, P b) {
    return a > b ? a : b;
}



template <typename T, typename P> std::string concat(T a, P b) {
    return std::string(std::to_string(a) + std::to_string(b));
}

template <typename T, typename P> auto foo(T a, P p) -> decltype(a + p){
    return a + p;
}


template <int threshold, typename T>
bool is_valid(T collection[], size_t size) {
    T sum {};
    for(size_t i = 0; i < size; i++) {
        sum += collection[i];
    }
    if (sum >= threshold) return true;
    else return false;
}


template <typename T>
inline constexpr bool is_integral = std::is_integral_v<T>;


template <typename T>
void print_type(T a) {
    if constexpr(std::is_integral_v<T>) {
        std::cout << "This is integral\n";
    } else if constexpr(std::is_pointer<T>::value) {
        std::cout << "This is pointer\n";
    } else if constexpr (std::is_floating_point_v<T>) {
        std::cout << "This is floating point\n";
    }
}



int main() {

    char ac {'A'};
    char bc {'B'};

    int ai {4};
    int bi {88};
    double ad{53.8585};
    double bd{3.9999};

    std::string as {"Mister Dog"};
    std::string bs {"Missis Dog"};
    const char *cs {"Hello world"};
    const char *ds {"Qys"};

    std::cout << maximum(ac, bc) << '\n';
    std::cout << maximum(ai, bi) << '\n';
    std::cout << maximum(ad, bd) << '\n';
    std::cout << maximum(as, bs) << '\n';
    std::cout << maximum(cs, ds) << '\n';


    std::string bob {"bob"};
    const char *names[] {"Musha", "Colur", "bob", "chear"};

    std::cout << hunt(bob.c_str(), names, 4) << '\n';

    std::cout << prob_max(bi, ad) << '\n';

    int c {prob_max<char, char>(ad, bd)};
    std::cout << char(c) << '\n';
    auto p = foo(ai, bd);
    std::cout << sizeof(p) << '\n';

    double arr[] {11.0, 1.9, 333.8, 1.3, 84.2};

    std::cout << std::boolalpha << is_valid<3000>(arr, std::size(arr)) << '\n';



    auto func = [] <typename T> (T a, T b) {
        return a + b;
    };

    std::cout << "lambda call : " << func.operator()(30, 40) << '\n';
    std::cout << func(30, 11) << '\n';
    std::operator<<(std::cout, "Hello\n");

    std::cout << "Type traits------------------\n";

    int a {45};


    std::cout << std::boolalpha;

    std::cout << "std::is_integral<int> : " << std::is_integral<int>::value << '\n';
    std::cout << "std::is_integral<double> : " << std::is_integral<double>::value << '\n';
    std::cout << "std::is_float_point<int> : " << std::is_floating_point<int>::value << '\n';
    std::cout << "std::is_integral<int> : " << std::is_integral<decltype(a)>::value << '\n';

    bool bb = is_integral<decltype(a)>;
    std::cout << bb << '\n';

    const char *msg = "Hello";

    std::cout << std::is_pointer<decltype(msg)>() << '\n';

    print_type(a);
    print_type(ad);
    print_type(msg);



    return 0;
}
