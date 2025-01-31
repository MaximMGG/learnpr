#include "calc.h"



int main() {

    std::cout << "Hello in clac\n";
    std::cout << "Enter expression: \n";


    char buf[512]{0};

    std::cin.getline(buf, 512, '\n');


    Compute c(buf);


    c.pars_expression();

    c.print_expression();

    c.compute_expr();
    c.print_expression();

    return 0;
}
