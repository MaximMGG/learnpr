#include <iostream>

class Printable {
    public:
        virtual ~Printable() {}
        virtual std::string GetClassName() = 0;
};


class Entity : public Printable {
    public:
        virtual std::string GetName() {return "Entity";}
        std::string GetClassName() override {return "Entity";}
};

class Player : public Entity {
    private:
        std::string m_Name;
    public:
        Player(const std::string& name) : m_Name(name) {};
        std::string GetName() override {return m_Name;}
        std::string GetClassName() override {return "Player";}
};

void Print(Printable* obj) {
    std::cout << obj->GetClassName() << '\n';

}

template <typename T> void max(T& t, T& t2, T& res){
    res = t > t2 ? t : t2;
}

int main() {

    Entity *e = new Player("");
    Print(e);

    Player *p = new Player("Two");
    Print(p);


    int a = 4;
    int b = 99;
    int c {};
    max(a, b, c);

    std::cout << c << '\n';


    return 0;
}
