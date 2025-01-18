#include <iostream>


struct A {
    int b;
};

struct B {
    int c;
};


int main() {

    struct A *a = new A;
    a->b = 49;
    struct B *b = (B *)a;
    struct B *c = reinterpret_cast<B *> (a);

    char value = 65;

    auto st = b;

    std::cout << "value: " << value << '\n';
    std::cout << "value(int): " << static_cast<int>(value) << '\n';
    std::cout << "value(int): " << int(value) << '\n';
    std::cout << "B *c->c: " << char(c->c) << '\n';
    std::cout << sizeof(*st) << '\n';


    return 0;
}
