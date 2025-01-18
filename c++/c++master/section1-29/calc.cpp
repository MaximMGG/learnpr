#include <iostream>
#include <cstring>
#include <cstdlib>

int main(int argc, char **argv) {

    if (argc < 4) {
        std::cerr << "argc les the 4, please try agane\n";
        return 1;
    }
    double first_val = std::atof(argv[1]);
    double second_val = std::atof(argv[3]);
    char operation = argv[2][0];


    switch(operation) {
        case '+' :
            std::cout << first_val << " + " << second_val << " = " << first_val + second_val << '\n'; 
        break;
        case '-' :
            std::cout << first_val << " - " << second_val << " = " << first_val - second_val << '\n'; 
        break;
        case '*' :
            std::cout << first_val << " * " << second_val << " = " << first_val * second_val << '\n'; 
        break;
        case '/' :
            std::cout << first_val << " / " << second_val << " = " << first_val / second_val << '\n'; 
        break;
    }
    return 0;
}
