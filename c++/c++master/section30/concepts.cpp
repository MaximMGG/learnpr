#include <iostream>
#include <type_traits>
#include <concepts>



class Dog {

    private:
        std::string name;


    public:

        Dog(const char *name) {this->name = name;}
        ~Dog(){}

        void setName(const char *name) {
            this->name = name;
        }

        std::string& getName() {return name;}

        void bark() {
            std::cout << "I can bark and my name is : " << getName() << '\n';
        }

};

class Cat {

    private:
        std::string name;
    public:


        Cat(const char *name) {
            this->name = name;
        }
        ~Cat(){}


        void setName(const char *name) {
            this->name = name;

        }

        std::string& getName() {
            return name;
        }

        void miy() {
            std::cout << "I can miy\n";
        }

};

template <typename T>
concept canBark = requires(T t) {t.bark();};

template <canBark T>
//requires canBark<T>
void letBark(T& t) {
    t.bark();
}

/*
template <typename T>
requires canBark<T>
void letBark(T &t) {
    t.bark();
}
 */


template <typename T>
concept odd = requires(T t) {t % 2 == 0;};


template <std::integral T>
T add( T a, T b) requires odd<decltype(a)> {return a + b;}


int main() {
    std::cout << "consepts\n";

    double a {1.4};
    double b {3.4};

    std::cout << add(22, 33) << '\n';


    Dog d{"Bylly"};
    Cat c{"Fluffy"};

    letBark(d);
    letBark(*(Dog *)&c);


    return 0;
}
