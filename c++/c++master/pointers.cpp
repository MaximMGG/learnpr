#include <iostream>


int main() {
    
    // int *p1 {new int};
    // int *p2 {new int (22)};
    // int *p3 {new int {33}};

    // int *p1 = new int;
    // int *p2 = new int (22);
    // int *p3 = new int {33};

    int *p1 = new int;
    int *p2 = new int;
    int *p3 = new int;
    *p1 = 0;
    *p2 = 22;
    *p3 = 33;

    printf("p1 : %p\n", p1);
    printf("*p1 : %d\n", *p1);

    printf("p2 : %p\n", p2);
    printf("*p2 : %d\n", *p2);

    printf("p3 : %p\n", p3);
    printf("*p3 : %d\n", *p3);

    // std::cout << "p1 : " << p1 << std::endl;
    // std::cout << "*p1 : " << *p1 << std::endl;
    //
    // std::cout << "p2 : " << p2 << std::endl;
    // std::cout << "*p2 : " << *p2 << std::endl;
    //
    // std::cout << "p3 : " << p3 << std::endl;
    // std::cout << "*p3 : " << *p3 << std::endl;

    delete p1;
    delete p2;
    delete p3;
    p1 = nullptr;
    p2 = nullptr;
    p3 = nullptr;

    return 0;
}
