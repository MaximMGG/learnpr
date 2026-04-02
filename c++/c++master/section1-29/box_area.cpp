#include <iostream>


int main() {
    float length{};
    float width{};
    float height{};
    float a{}, b{}, c{};
    std::cout << "Welcome to box calculator. Please type in length, width and height information : \n";
    std::cout << "length: ";
    std::cin >> length;
    std::cout << "width : ";
    std::cin >> width;
    std::cout << "height : ";
    std::cin >> height;
    // std::cout << '\n';
    float base_area {width * length};
    std::cout << "The base area is : " << base_area << '\n';
    std::cout << "The volume is : " << base_area * height << '\n';

    return 0;
}
