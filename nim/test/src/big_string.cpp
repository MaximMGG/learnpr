#include <iostream>
#include <string>



std::string getBigStering() {
    std::string s;
    for(int i = 0; i < 100000; i++) {
        s.append("ijij");
    }

    return s;
}


int main() {

    std::string t = "Hello world";
    std::string s = getBigStering();

    std::string r = t + s + t;

    std::cout << r << '\n';

    return 0;
}
