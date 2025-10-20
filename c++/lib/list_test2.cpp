#include <vector>
#include <iostream>

#define COUNT 10000000

int main() {
    std::cout << "List 2 test starting\n";

    std::vector<int> l;

    for(int i = 0; i < COUNT; i++) {
        l.push_back(i + 1);
    }

    std::cout << l[4] << '\n';
    l[4] = 123123;
    std::cout << l[4] << '\n';


    std::cout << l[COUNT - 1] << '\n';
    l[COUNT - 1] = 999;
    std::cout << l[COUNT - 1] << '\n';

    std::cout << "List 2 test neding\n";
    return 0;
}
