#include <iostream>
#include <concepts>
#include <string>



template  <typename T>
concept ConvertibleToStdString = requires (T t) {
    std::to_string(t);
};


template <typename T>
requires (requires (T t){std::to_string(t);})
std::string concatenate(T a, T b) {
    return std::to_string(a) + std::to_string(b);
}


template <typename T>
concept TinyType = requires(T t) {
    sizeof(T) <= 4;
    requires sizeof(T) <= 4;
};

TinyType auto add(TinyType auto a, TinyType auto b) {
    return a + b;
}


template <typename T>
concept Addable = requires(T a, T b) {
    {a + b} -> std::convertible_to<int>;
};

int main() {

    int a {22};
    int aa {44};
    int b {33};
    double c {22.22};
    double d {33.33};

    const char *sa {"eujhrej"};
    const char *sb {"dkfjdkfj"};

    try {
        std::cout << "something interesting : " << concatenate(*(int *)sa, *(int *)sb) << '\n';


    } catch(std::exception e) {
        std::cout << e.what() << '\n';
    }

    std::cout << "concat two ints : " << concatenate(a, b) << '\n';
    std::cout << "concat two doubles : " << concatenate(c, d) << '\n';


    //std::cout << "add : " << add(c, d) << '\n';
    std::cout << "add : " << add(a, aa) << '\n';


    return 0;
}
