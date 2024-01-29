#include <iostream>


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
    try{
        do_something(-1);
    } catch (Bad_area a) {
        std::cout << a.getError() << std::endl;
    }


    return 0;
}
