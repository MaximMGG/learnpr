#include <iostream>


struct Monster {
    enum Type_of_monster {
        DRAGON, ORC, GIANT_SPIDER, SLIME
    };
    std::string_view m_name;
    int m_helth;
    Type_of_monster m_type;

    void printMonster() {
        const char *type_name = [](Type_of_monster r){
            switch(r) {
                case DRAGON:
                    return "dragon";
                    break;
                case ORC:
                    return "orc";
                    break;
                case GIANT_SPIDER:
                    return "giant spider";
                    break;
                case SLIME:
                    return "slime";
                    break;
            }
            return "Hello";}(m_type);

        std::cout << "This " << type_name << " is named " << m_name << " and has " << m_helth << " health.\n";
    }
};


template <typename T>
class Triade {
    public:
    T one {};
    T two {};
    T three {};

    Triade<T>(T x, T y, T z) {
        one = x;
        two = y;
        three = z;
    }
};

// template <typename T>
// Triade(T x, T y, T z) -> Triade<T>;

template <typename T>
void print(const Triade<T>& t) {
    std::cout << "[" << t.one << ", " << t.two << ", " << t.three << "]";
}


int main() {

    // Monster orc {"Pedro", 123, Monster::ORC};
    // orc.printMonster();
    // Monster spider {.m_name = "Hylio", .m_helth = 199, .m_type = Monster::GIANT_SPIDER};
    // spider.printMonster();

    Triade t1 {1, 2, 3};
    print(t1);

    Triade t2 {1.2, 3.4, 5.6};
    print(t2);


    return 0;
}
