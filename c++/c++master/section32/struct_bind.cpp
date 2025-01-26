#include <iostream>

struct Vec3 {
    double x;
    double y;
    double z;

    void print_vec() {
        std::cout << x << y << z << '\n';
    }


};



class Person {
    private:
        std::string first_name;
        std::string last_name;
        int *age;

    public:

        Person() = default;
        Person(std::string first_name) : Person(first_name, "DNF", 99){}
        Person(std::string first_name, std::string last_name) : Person(first_name, last_name, 99){}
        Person(std::string first_name, std::string last_name, int age) : 
            first_name(first_name), last_name(last_name), age(new int(age)){}

        Person(Person& old) : 
            first_name(old.get_first_name()), 
            last_name(old.get_last_name()), 
            age(new int (*old.get_age())){};

        Person(Person&& source_person) : 
            first_name(source_person.get_first_name()), 
            last_name(source_person.get_last_name()), age(new int(*source_person.get_age())) {}

        ~Person() {
            delete age;
        }

        std::string& get_first_name() {return first_name;}
        std::string& get_last_name() {return last_name;}
        int *get_age() {return age;}

        void print_person() {
            std::cout   << "first_name (" << &first_name << ") : " << first_name << '\n'
                << "last_name (" << &last_name << ") : " << last_name << '\n'
                << "age (" << age << ") : " << *age << '\n';
        }

}; 




int main() {

    Vec3 vec1 {12.2, 3.4, 9.2};

    auto& [a, b, c] = vec1;
    vec1.print_vec();

    b = 9999.9;

    vec1.print_vec();
    std::cout << "a : " << a << " b : " << b << " c : " << c << '\n';

    Person misha("Misha");
    Person mickle("Mickle", "Siments", 25);


    misha.print_person();
    *misha.get_age() = 33;
    misha.get_last_name() = "Kulcov";
    Person Misha2(misha);
    mickle.print_person();
    Misha2.print_person();


    return 0;
}
