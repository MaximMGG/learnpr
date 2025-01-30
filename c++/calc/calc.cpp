#include "calc.h"



int main() {

    std::cout << "Hello in clac\n";
    std::cout << "Enter expression: \n";


    char buf[512]{0};

    std::cin >> buf;


    Compute c(buf);


    c.pars_expression();
    c.print_expression();

    return 0;
}
