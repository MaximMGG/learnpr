#include <iostream>


int main() {

    int *arr = new int[10];
    std::cout << arr << '\n';

    arr = new (arr)int [20];

    delete [] arr;

    return 0;
}
