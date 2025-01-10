#include <iostream>
#include <string>
#include <optional>


int main() {

    std::optional<int> i {3};
    std::optional<std::string> s {"Danya"};
    std::cout << i.value() << '\n';
    i.reset();
    //std::cout << i.value() << '\n';


    return 0;
}
