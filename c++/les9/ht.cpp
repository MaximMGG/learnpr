#include <iostream>
#include <cstring>
#include "sal.h"


//exersizes===============

struct chaff {
    char dross[20];
    int slag;
};
char buf[200];

void third() {
    chaff *arr = new (buf) chaff[2];
    strcpy(arr[0].dross, "Werigj");
    arr[0].slag = 22;
    strcpy(arr[1].dross, "a;slkdfjaosdfp");
    arr[1].slag = 11;

    chaff *arr2 = new chaff[2];
    strcpy(arr2[0].dross, "Werigj");
    arr2[0].slag = 22;
    strcpy(arr2[1].dross, "a;slkdfjaosdfp");
    arr2[1].slag = 11;


    for (int i = 0; i < 2; i++) {
        std::cout << arr[i].dross << ", " << arr[i].slag << std::endl; 
    }
    for (int i = 0; i < 2; i++) {
        std::cout << arr2[i].dross << ", " << arr2[i].slag << std::endl; 
    }

    delete [] arr2;
}









//exersizes===============


int main() {
    using std::cout;
    using std::cin;

    double b;
    // cin >> b;
    // cout << b << std::endl;
    // third();
    SALES::Sales s;
    double ar[] {123.0, 2.4, 142.555, 8686.000, 0.1};
    SALES::setSales(s, ar, 5);
    SALES::Sales q;
    SALES::setSales(q);
    SALES::showSales(s);
    SALES::showSales(q);


    return 0;
}
