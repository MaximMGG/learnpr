#include <iostream>
#include <stdlib.h>

enum SEX{
    MALE, FEMALE
};

typedef struct {
    std::string name;
    unsigned int age;
    enum SEX sex;
} team;
struct my_reg {
    unsigned int SS : 4;
    unsigned int : 4;
    bool flag : 1;
    bool access : 1;
};

void print_team(team *t_s, int size) {
    team *t = t_s;
    for(int i = 0; i < size; i++) {
        std::string sex = t->sex == 0 ? "MALE" : "FEMALE";
        std::cout << "Name is: "<< t->name << "\nAge: " << t->age << "\nSEX: " << sex << std::endl;
        t++;
    }
}


int main() { 
    int size = 10;
    team *basket = (team *)malloc(sizeof(team) * size);
    basket[0].name = "Bill";
    basket[0].age = 23;
    basket[0].sex = MALE;
    basket[1].name = "Bob";
    basket[1].age = 41;
    basket[1].sex = FEMALE;
    print_team(basket, 2);

    team footbol{"Nick", 33, MALE};

    print_team(&footbol, 1);
    
    team test = basket[1];
    free(basket);

    std::cout << test.name << std::endl;
    // std::cout << basket->name;
    //

    std::cout << sizeof(team) << std::endl;
    std::cout << sizeof(struct my_reg) << std::endl;
    return 0;
}
