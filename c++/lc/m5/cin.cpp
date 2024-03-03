#include <iostream>
#include <string>


int main() {

    std::string name {};
    std::cout << "Enter your name\n";

    std::getline(std::cin >> std::ws, name);

    std::cout << "Your name is " << name << "\n";


    return 0;
}
