#include <iostream>
#include <thread>
#include <atomic>


std::atomic_int a;

void foo() {
    for(int i = 0; i < 1000000; i++) {
        a++;
    }
}

int main() {

    std::thread t(foo);

    for(int i = 0; i < 1000000; i++) {
        a++;
    }

    t.join();

    std::cout << a << '\n';
    return 0;
}
