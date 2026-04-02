#include <iostream>


int main() {

    float a {2.3};
    double b {2134.51515};


    std::cout.setf(std::ios_base::fixed, std::ios_base::floatfield);
    std::cout << "float: " << a << " and double: " << b << '\n';


    return 0;
}
