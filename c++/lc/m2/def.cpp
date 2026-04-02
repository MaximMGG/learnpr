#include <iostream>


void doSo() {
#ifdef PRINT
    std::cout << "print" << std::endl;
#endif
#ifndef PRINT
    std::cout << "not print" << std::endl;
#endif
}

