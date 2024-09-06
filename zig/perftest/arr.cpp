#include <iostream>
#include <cstdio>
#include <list>


int main() {

    std::list<const char *> list;

    for(int i = 0; i < 10000000; i++) {
        if (i % 7 == 0 || i % 10 == 7) {
            list.push_back("SMAC");
        } else {
            char buf[32] {0};
            sprintf(buf, "%d", static_cast<int>(i));
            list.push_back(buf);
        }
    }
    for(auto i = list.begin(); i != list.end(); i++) {
        std::cout << *i << '\n';
    }

    // std::cout << "list len is: " << list.size() << '\n';

    return 0;
}
