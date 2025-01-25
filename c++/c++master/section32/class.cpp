#include <iostream>


class Dog {
    public:
        Dog(){}
        Dog(std::string_view name, std::string_view breed_param, int age) {
            this->name = name;
            this->breed_param = breed_param;
            this->age = age;
        }
        // Dog(const char *name, const char *breed_param, int age) {
        //     this->name = name;
        //     this->breed_param = breed_param;
        //     this->age = age;
        // }
        ~Dog(){}
        void set_name(const std::string_view dog_name) {
            this->name = dog_name;
        }
        void set_dog_breed(const std::string_view dog_breed) {
            this->breed_param = dog_breed;
        }
        void set_dog_age(const int age) {
            this->age = age;
        }
        std::string_view get_name() const {
            return this->name;
        }
        std::string_view get_breed() const {
            return this->breed_param;
        }
        int get_age() const {
            return this->age;
        }
        void print_info() const{
            std::cout << "Dog (" << this << "), name : " << this->name << ", breed : " << this->breed_param << ", age : " << this->age << '\n';
        }


    private:
        std::string_view name{"DNF"};
        std::string_view breed_param{"DNF"};
        int age{0};
};



void print_dog(const Dog& d) {
    std::cout << "name : " << d.get_name() << '\n';
    std::cout << "breed : " << d.get_breed() << '\n';
    std::cout << "age : " << d.get_age() << '\n';

}



int main() {

    const Dog d{"Bobbyt", "treple", 12};

    const Dog *p_d = &d;

    d.print_info();

    print_dog(d);

    return 0;
}
