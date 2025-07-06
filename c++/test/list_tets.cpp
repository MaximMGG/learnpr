#include <list>
#include <iostream>


int main() {

    std::list<int> l{};

    for(int i = 0; i < 100000; i++) {
        l.push_back(i);
    }

    std::cout << l.size() << '\n';

    return 0;
}
