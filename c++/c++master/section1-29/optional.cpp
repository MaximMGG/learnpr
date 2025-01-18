#include <iostream>
#include <string>
#include <optional>


int main() {

    std::optional<int> i {3};
    std::optional<std::string> s {"Danya"};
    std::optional<int> a {};
    std::cout << i.value() << '\n';
    i.reset();
    //std::cout << i.value() << '\n';
    std::cout << *i << '\n';
    i.has_value();
    if (i != std::nullopt) {

    }

    i.value_or(8);

    std::cout << a.value() << '\n';



    return 0;
}
