#include <iostream>

extern "C" int sum(int x, int y);


int main (){ 
    int sums = sum(1, 2);
    std::cout << sums << std::endl;
    // std::cout << "Hello" << std::endl;
    return 0;
}
