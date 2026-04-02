#include <iostream>


class Dog {
    private:
        std::string name;
        std::string breed;
        int age;
        mutable int count{0};

    public:

        Dog(){}
        Dog(const std::string_view name, const std::string_view breed, int age){
            this->name = name;
            this->breed = breed;
            this->age = age;
        }
        ~Dog(){
            std::cout << "Print was called : " << count << " times\n";
        }


        const std::string& get_name() const {
            return this->name;
        }
        std::string& get_name() {
            return this->name;
        }
        const std::string& get_breed() const {
            return this->breed;
        }
        std::string& get_breed() {
            return this->breed;
        }
        const int& get_age() const {
            return this->age;
        }
        int& get_age() {
            return this->age;
        }

        void print_info() const {
            count++;
            std::cout << "Dog :(" << this << ") name : " << get_name() << ", breed : " 
                << get_breed() << ", age : " << get_age() << '\n';
        }
};


int main() {
    Dog d("Bobby", "Threatment", 5);
    d.print_info();
    //d.get_name() = "Mishta";
    d.print_info();


    return 0;
}
