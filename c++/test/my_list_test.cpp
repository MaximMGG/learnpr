#include "list.hpp"
#include <iostream>


int main() {

    List<int> l{};

    for(int i = 0; i < 100000; i++) {
        l.append(i);
    }

    std::cout << l.size() << '\n';


    return 0;
}
