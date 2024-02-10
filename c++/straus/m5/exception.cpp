#include <iostream>


void error(std::string a1, std::string a2) {
    throw std::runtime_error(a1 + a2);
}


class Bad_area {
    std::string name;
    public:

    Bad_area() {
        name = "Error";
    };

    std::string getError() {
        return name;
    }
};




int do_something(int x) {
    if (x < 0) throw Bad_area();
    
    return 0;
}

int main() {
    error("Hello", "how are you?");

    return 0;
}
