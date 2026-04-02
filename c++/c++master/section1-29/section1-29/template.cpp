#include <iostream>
#include <string>
#include <cstring>


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

auto var(int a, int b) -> double {

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

    return 0;
}
