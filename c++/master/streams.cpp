#include <iostream>


int main() {

    std::string hello {"Hello"};
    std::string log {"THis in log string"};
    std::string forinput {};
    std::string err_string = "Error";

    std::cout << hello << '\n';
    std::clog << log << '\n';
    std::cin >> forinput;
    std::cout << "Inpurt was -> " << forinput << '\n';
    std::cerr << err_string << '\n';

    std::getline(std::cin, forinput);

    int age {};
    std::string name;

    std::cout << "Hello, please enter your name and age" << '\n';

    std::getline(std::cin, name) >> age;

    std::cout << "Your name is: " << name << " and your age is: " << age << '\n';

    return 0;
}
