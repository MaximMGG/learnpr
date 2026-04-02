#include <iostream>



class Entity{
    public:
        float X, Y;


        void Move(float xa, float ya) {
            X += xa;
            Y += ya;
        }
};

class Player: public Entity {
    public:
        const char *name;

        void PrintName() {
            std::cout << "name is " << name << '\n';

        }
};

void print_entity(Entity e) {
    std::cout << "x " << e.X << ", y " << e.Y << '\n';
}


int main() {

    Player p;
    p.X = 3.3;
    p.Y = 4.4;
    p.Move(2, 3.09);
    Entity e;
    e.X = 1.1;
    e.Y = 2.2;
    print_entity(e);
    print_entity(p);

    return 0;
}
