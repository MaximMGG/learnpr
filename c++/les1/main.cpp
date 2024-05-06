#include <iostream>



class Example {

    private:
        int x;
        int y;
    public:
        int sum();
        void increase_x(int i);
        void increase_y(int i);

        Example(int x, int y);
        ~Example();
};


    int Example::sum() {
        return this->x + this->y;
    }

    void Example::increase_x(int i) {
        this->x += i;
    }

void Example::increase_y(int i) {
    this->y += i;
}
    
Example::Example(int x, int y) {
    this->x = x;
    this->y = y;
}


int main() {


    Example *e = new Example(1, 2);


    std::cout << "x + y = " << e->sum() << '\n';

    e->increase_x(10);
    e->increase_y(10);

    std::cout << "agane: x + y = " << e->sum() << '\n';


    return 0;
}
