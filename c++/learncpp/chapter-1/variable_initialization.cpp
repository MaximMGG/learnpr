#include <iostream>

typedef struct {
    int a;
    int b;
} A;

typedef struct {
    float a;
    float b;
} B;


int main() {

    int a;
    int b = 5;

    int c = (int)4.4;

    A d{.a = 123, .b = 234};
    B e = *(B *) &d;

    std::cout << e.a << " " << e.b << '\n';


    return 0;
}
