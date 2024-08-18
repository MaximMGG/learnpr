#include <iostream>
#include <list>


int main() {

    std::list<const char *> list;

    for(int i = 0; i < 1000000; i++) {
        list.push_back("a");
    }

    std::cout << "list len is: " << list.size() << '\n';

    return 0;
}
