#include <iostream>
#include <vector>


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
    // error("Hello", "how are you?");
    try {
        std::vector<int> vec;

        for(int i{0}; i < 5; i++) {
            vec.push_back(i);
        }
        for(int i{0}; i <= vec.size(); i++) {
            std::cout << "vec[" << i << "] == " << vec[i] << '\n'; 
        }
    } catch (std::out_of_range) {
        std::cerr << "Out of range\n";
    } catch (...) {
        std::cerr << "Error\n";
    }


    return 0;
}
