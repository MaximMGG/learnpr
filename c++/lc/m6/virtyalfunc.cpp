#include <iostream>

class Entity {
    public:
        const char *name;

        virtual std::string GetName() {return "entity";}
        virtual ~Entity() {};
};

class Player : public Entity {
    private:
        std::string  m_Name;
    public:
        Player(const std::string& name) {m_Name = name;};

        std::string GetName() override { return m_Name;}
};

void PrintName(Entity *e) {
    std::cout << e->GetName() << '\n';
}

int main() {

    Entity *e = new Entity();
    e->name = "entity";
    PrintName(e);

    Player *p = new Player("Max");
    PrintName(p);

    Entity *entity = p;
    PrintName(entity);

    delete e;
    delete p;

    return 0;
}
