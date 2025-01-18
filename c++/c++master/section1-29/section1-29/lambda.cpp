#include <iostream>

#include <regex.h>

auto klj = []() {
    std::cout << "autside the main";
};



int main() {

    auto a = []() -> int {
        std::cout << "Hello from lambda\n";
        return 1;
    };

    int cc {a()} ;

    std::cout << "size of lambda > " << sizeof(a) << '\n';

    [](double a, double b) {
        std::cout << "sum " << a << " and " << b << " = " << a + b << '\n';

    }(11.4, 98.9);

    auto res = [](double a, double b) -> double {
        return a + b;
    }(11.4, 98.9);

    std::cout << res << "\n";

    auto bb = [](int a, int b) -> int {
        return a * b;
    };

    auto bb1 = [](double a, double b) -> double {
        return a + b;
    };
    int c = 123;
    int d = 333;

    auto bund = [bb1, c, d]() -> double {
        double e = bb1(11.2, 313.2);
        e += c + d;
        return e;
    };


    std::cout << bb(1, 4) << '\n';
    std::cout << bb(213, 4) << '\n';
    std::cout << bb(99, 4) << '\n';
    std::cout << bb(999999999, 4) << '\n';

    std::cout << bund() << '\n';

    auto func = [c]() {
        // std::cout << p << '\n';
    };
    func();
    std::cout << c << ' ' << d << '\n';

    klj();


    return 0;
}
