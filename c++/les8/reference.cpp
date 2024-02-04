#include <iostream>

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


    std::cout << c << std::endl;
    return 0;
}
