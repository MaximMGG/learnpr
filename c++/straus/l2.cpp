#include <algorithm>
#include <string>
#include <vector>
#include <iostream>


void read_data() {
    std::vector<char> n;
    for(char a; std::cin >> a; ) {
        if (a == '1') break;
        n.push_back(a);
    }
}



int main() {

    std::string b = "Hello";
    b += "e";
    std::cout << b << std::endl;
    b[0] = '2';

    constexpr double rad = 2.5;

    int asd = 1;

    switch(asd) {
        case 2:
            break;
        case 3:
            break;
        default:
            std::cout << "Heoijasdf\n";

    }

    std::vector<int> v = {1, 2, 3};
    std::vector<std::string> names {"Nadya", "Bobo"};
    std::cout << names[0] << " " << names[1] << std::endl;

    for(int x : v) {
        std::cout << x << " ";
    }
    std::cout << std::endl;

    for (std::string s : names) {
        std::cout << s << " ";
    }
    std::cout << std::endl;

    names.push_back("Julia");
    names.push_back("Mila");
    for(std::string s : names) {
        std::cout << s << " ";
    }
    std::cout << std::endl;

    read_data();
    return 0;
}


int cont(int n) {
    const int o1 = n + 3;


    return o1;
}

