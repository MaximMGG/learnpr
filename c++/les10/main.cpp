#include "oop.hpp"
#include <iostream>
#include "stack.h"


class Test {
    std::string s;

    public:
    Test(const char *s) {
        this->s = s;
    }
};

enum class egg {LARGE, MEDIUM, SMALLL};


int main() {

    Stock *s = new Stock("Hello", 124786124, 1541.4);
    Stock *ss = new Stock {"Kaijshdj"};
    Stock w = Stock("w", 13, 1.9);
    Stock ww = Stock{"ww", 123, 1.0};
    Stock b("Get is", 1L, 0.4);
    Stock c {"11", 34234, 81273.1};
    Stock cc = {"84848"};
    Test tes = "Hello";
    s->show_stock();
    w.show_stock();
    b.show_stock();
    c.show_stock();
    Stock fub[3] {{"a", 1, 1}, {"b", 2, 2}, {"c", 3, 3}};
    fub[0].show_stock();
    fub[1].show_stock();
    fub[2].show_stock();
    const Stock pul {"qwel", 123123, 99.0};
    pul.show_stock();
    std::cout << w.compare(*ss) << std::endl;
    //stack


    int max = MAX;











    return 0;

}
