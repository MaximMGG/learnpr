#include <iostream>
#include <string>

int main() {
    std::string one {"Hello "};
    std::string two {"World!"};

    one += two;

    std::cout << one << '\n';


    return 0;
}
