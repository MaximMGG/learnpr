#include <iostream>


class Entity {
    public: 
        float x, y;

        Entity(float x = 0.0f, float y = 0.0f) {
            this->x = x;
            this->y = y;
            std::cout << "Entity create\n";
        }

        ~Entity() {
            std::cout << "Destroy entity\n";
        }

        void Print() {
            std::cout << x << ", " << y << std::endl;
        }
};



void getEntity() {
    Entity e{99.2, 1.1};
    e.Print();
}

int main() {

    getEntity();
    return 0;
}
