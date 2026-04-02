#include <iostream>


namespace My {
    typedef enum {
        DVOR, NEMEC
    } Type;
class Dog {
    private:

    public:
        const char *name;
        Type t;
        int age;
        const char *owner_name;
};



    typedef struct {
        const char *name;
        int age;
    } rob;
    namespace Test {
        void print_rob(My::rob& r) {
            std::cout << r.name << " " << r.age << std::endl; 
        }
    }
}

namespace tt = My::Test;


typedef struct {
    float x, y;
    double z;
} vec;


char buf[100];
char buf2[100];

int main() {

    vec *v = new vec{1.0, 3.3, 1.1};

    int *p1 = new int;
    int *p2 = new int[10];
    int *p3 = new (buf)int[5]{1, 2, 3, 4, 5};
    char *str = new (buf2)char[100]{"Hello"};

    int *b1 = (int *)buf;

    std::cout << p2 << std::endl;
    std::cout << b1 << std::endl;
    std::cout << p3 << std::endl;
    std::cout << &p3[0] << std::endl;
    std::cout << buf2[0] << std::endl;
    std::cout << buf2[1] << std::endl;
    std::cout << buf2[2] << std::endl;


    My::rob r{"Rob", 12};
    My::Test::print_rob(r);

    My::Dog d{.name = "Byba", .t = My::DVOR, .age = 1, .owner_name = "Bill"};
    My::Dog *dd = new (buf2) My::Dog{"Byba", My::NEMEC, 2, "John"};

    std::cout << buf2 << std::endl;
    char *a = (char *) dd;
    for(int i = 0; i < 100; i++)
        std::cout << a + i;
    std::cout << std::endl;
    std::cout << dd << std::endl;
    tt::print_rob(r);
    
    return 0;
}
