#include <iostream>


class Dog {
    public:
        Dog(std::string name, int age) : name(name), age(age) {}
        ~Dog(){}
        friend class Cat;

        friend void debug_dog_info(const Dog& dog);
        friend void debug_dog_info();

    private:
        std::string name;
        int age;

};

class Cat {
    public:
        Cat(std::string name) : name(name){}

        void show_dog_info(const Dog& dog) {
            std::cout << "Dog name : " << dog.name << '\n';

        }


    private:
        std::string name;

};


void debug_dog_info(const Dog& dog) {
    std::cout << "Dog name : " << dog.name << '\n';
    std::cout << "Dog age : " << dog.age << '\n';
}

void debug_dog_info() {

}




int main() {

    Dog d ("Kyke", 1);
    debug_dog_info(d);

    Cat a("Super cat");
    a.show_dog_info(d);



    return 0;
}
