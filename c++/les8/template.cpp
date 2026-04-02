#include <iostream>


typedef struct {
    std::string name;
    double salary;
    int age;
} job;

template <typename T>
void swap(T& a, T& b) {
    T temp;
    temp = a;
    a = b;
    b = temp;
}

template <> void swap<job>(job& a, job& b) {
    double temp = a.salary;
    a.salary = b.salary;
    b.salary = temp;
}

void swap(job& a, job& b) {
    int temp = a.age;
    a.age = b.age;
    b.age = a.age;
}

template <typename T, typename C> 
T shown(T a, C b) {
    decltype(a + b) ab = a + b; 
}

auto h(double a, double b) -> double {

    return 0.0;
};

template<typename T, typename C>
auto hello(T t, C c) -> decltype(t + c) {
    return t + c;
}




int main() {
    std::cout.setf(std::ios::fixed, std::ios::floatfield);
    std::string one = "Hello";
    std::string two = " Bill";

    job a {"Misha", 22.3, 20};
    job b {"Tanya", 33.3, 25};

    swap(a, b);

    std::cout << "Name is: "<< a.name << " " << " salary is: " << a.salary << " , age is: " << a.age << std::endl;

    int baba = 123;
    double ller = 34234.0;
    job j {"John", 11.0, 33};
    job t {"John", 11.0, 33};

    auto resa = hello(baba, ller);


    return 0;
}
