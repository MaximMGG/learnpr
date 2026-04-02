#include <iostream>


typedef struct {
    float x, y;
} vec;

char *left(vec v = {.x = 1, .y = 2}, int i = 1) {

    return nullptr;
}

char *left(const char * str, double x);


int calc(int& a, int& b) {
    a += b;
    for(int i = 1; i < 4; i++)
        a += *(&a + i) + *(&b + i);

    return a;
}


int main() {
    int arr[4] {1, 2, 3, 4};
    int arr2[4] {1, 2, 3, 4};

    int c = calc(arr[0], arr2[0]);
    left({.x = 2, .y = 6}, 34);
    left("Hello", 0);
    left();

    std::cout << c << std::endl;
    return 0;
}
