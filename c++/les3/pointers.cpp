#include <iostream>
#include <stdlib.h>
#include <cstring>
using namespace std;


void magic() {

    int *one = (int *) malloc(sizeof(int));
    int *two = (int *) malloc(sizeof(int));
    *one = 1;
    *two = 2;

    int *p = two;
    p++;
    *p = 666;
    cout << two << endl;
    cout << *two << endl;

    cout << *one << endl;
    cout << one << endl;
    cout << *p << endl;
    cout << p << endl;

    p -= 2;
    *p = 777;

    cout << *one << endl;
    cout << one << endl;
}

string getName() {
    string name2 = "Bob";
    char *name = new char[20];
    strcpy(name, "Bob");
    return name2;
}


int main() {
    int a = 123;
    int b = 1234;
    string bygag = "Hello";

    cout << a << endl;
    cout << &a << endl;

    cout << b << endl;
    cout << &b << endl;
    
    cout << bygag << endl;
    cout << &bygag << endl;
    

    //couch him)
    //
    int *p_a = &b;
    p_a++;
    *p_a = 4444;
    //

    cout << a << endl; // not 123
    cout << &a << endl; // still same
    cout << *p_a << endl;
    cout << p_a << endl;

    cout << "--------------------------\n";

    magic();

    int *n_p = new int;
    delete(n_p);

    int *arr= new int[10];
    delete[](arr);


    string test = "Hello";
    char *test_p = test.data();

    cout << test_p << endl;



    return 0;
}
