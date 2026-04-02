#include <atomic>
#include <iostream>
#include <cstdio>
#include <thread>

std::atomic_int base{0};

void foo(int size) {
    for(int i = 0; i < size; i++) {
        base++;
    }

}


int main() {


    std::thread t(foo, 1000);

    for(int i = 0; i < 1000; i++) {
        base++;
    }

    t.join();
    std::cout << base << '\n';

}
