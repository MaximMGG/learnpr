#include <iostream>
#include <string_view>


int main() {

    std::string_view bob {"Bob"};
    std::string bob2 {bob};

    bob.remove_prefix(1);
    bob.remove_suffix(0);

    std::string a = static_cast<std::string>(bob);

    a += "bbb";
    std::cout << bob << " " << bob2 << '\n';

    return 0;
}
