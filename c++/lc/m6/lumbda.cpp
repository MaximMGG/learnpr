#include <iostream>


int main() {

    // auto func = [](double a, double b) {
    //     std::cout << "Hello world" << '\n';
    //     std::cout << "Sum is " << a + b << '\n';
    // };

    auto resutl = [](double a, double b) {
        return a + b;
    }(10, 20);

    std::cout << resutl << '\n';
    int x = 12;
    int y = 444;

    std::cout << "test lumbda " << [](int x, int y)->int { return x * y;} (x, y) << '\n';

    int a = 1;
    int b = 2;
    auto max = [&]() {return a > b ? ++a : ++b;};
    std::cout << max() << '\n';


    return 0;
}
