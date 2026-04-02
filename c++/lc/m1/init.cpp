#include <iostream>
#include <ctime>

int get_int() {
    srand(time(NULL));
    return rand() % 100;
}


void do_something(int&) {

}



int main() {

    // std::cout << "Enter a number: ";
    // int x;
    // std::cin >> x;
    // std::cout << "You entered " << x << std::endl;
    // int b;
    // b = get_int();
    // std::cout << "Random number is: " << b << std::endl;
    // for(int i = 0; i < 100; i++) {
    //     std::cout << i << "  --  " << get_int() << "\n";
    // }

    int a;
    do_something(a);

    std::cout << a << '\n';

    return 0;
}
