#include <string>
#include <iostream>
#include <limits>
#include <thread>


int main() {

    char *buf = new char[std::numeric_limits<int>::max()];

    for(long i = 0; i < 100000000000; i++);


    return 0;
}
