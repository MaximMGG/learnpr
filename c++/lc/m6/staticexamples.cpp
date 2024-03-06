#include <iostream>


struct Entity {
    static int x, y;

    static void Print() {  
        std::cout << " x " << x << ", y "  << y << "\n";
    }
};

int Entity::x;
int Entity::y;


int main() {

    Entity e;
    e.x = 2;
    e.y = 3;

    Entity e1;
    e1.x = 45;
    e1.y = 33;
    Entity::Print();

    return 0;
}
