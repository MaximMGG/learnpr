#include <iostream>
#include <thread>
#include <mutex>
#include <atomic>


#if defined(_ATOMIC)
std::atomic_int c;
#elif defined (_MUTEX)
int c;
std::mutex m;
#else
int c;
#endif


#define CYCLES 100000

void foo() {
    for(int i = 0; i < CYCLES; i++) {
#ifdef _MUTEX
    m.lock();
    c++;
    m.unlock();
#else
    c++;
#endif
    }
}



int main() {

    std::thread t(foo);

    for(int i = 0; i < CYCLES; i++) {
#ifdef _MUTEX
    m.lock();
    c++;
    m.unlock();
#else
    c++;
#endif
    }

    t.join();

    std::cout << c << '\n';
    return 0;
}
