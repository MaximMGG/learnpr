#include <iostream>
#include <string>

class Dog {
    std::string name;
    int age;

    public:

    Dog(std::string name, int age) {
        this->name = name;
        this->age = age;
    }
    ~Dog(){};


    void say_name_and_age() {
        std::cout << "My name is : " << this->name << '\n';
        std::cout << "My age is : " << this->age << '\n';
    }

};


typedef struct {
    int b;
    int c;
}A;

void foo3(Dog& dog) {
    std::cout << "From foo3, Address of dog : " << &dog << '\n';
    dog.say_name_and_age();
}

void foo2(A& a) {
    std::cout << "A.b : " << a.b << '\n';
    std::cout << "A.c : " << a.c << '\n';
}


void foo(int* &arr, int size) {
    for(int i = 0; i < size; i++) {
        std::cout << i << " : " << arr[i] << '\n';
    }
}



int main() {

    int a{233};
    double b{33.1414};

    int& a_ref {a};
    double &b_ref{b};

    std::cout << "a_ref : " << a_ref << '\n'; 
    std::cout << "b_ref : " << b_ref << '\n'; 
    std::cout << "a_ref size : " << sizeof(a_ref) << '\n';
    std::cout << "b_ref size : " << sizeof(b_ref) << '\n';

    std::cout << "&a : " << &a << '\n';
    std::cout << "&b : " << &b << '\n';

    std::cout << "&a_ref : " << &a_ref << '\n';
    std::cout << "&b_ref : " << &b_ref << '\n';

    a_ref += 3333;
    b_ref += 1.48859385;

    std::cout << "a_ref : " << a_ref << '\n'; 
    std::cout << "b_ref : " << b_ref << '\n'; 

    int *arr{new int[5]{1, 2, 3, 4, 5}};
    foo(arr, 5);

    delete[] arr;

    A aa{.b = 111, .c = 333};
    foo2(aa);

    Dog dog{"Banny", 23};
    std::cout << "Address of dog : " << &dog << '\n';

    foo3(dog);
    std::cout << "\n";
    dog.say_name_and_age();

    Dog *dog2 {new Dog{"Fluffy", 23}};
    std::cout << "Address of dog2 : " << dog2 << '\n';
    foo3(*dog2);
    dog2->say_name_and_age();

    delete dog2;


    return 0;
}
