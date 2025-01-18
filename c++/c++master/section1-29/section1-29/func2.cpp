#include <iostream>
#include <string>


std::string add_string(std::string a, std::string b) {
    std::string res {a + b};
    std::cout << "address of res is : " << &res << '\n';
    return res;
}



int main() {

    std::string h {"Hello "};
    std::string w {"world!"};
    std::string res = add_string(h, w);
    std::cout << "addres of res from main : " << &res << '\n';
    

    return 0;
}
