#include <iostream>

class Point {
    private:
        double m_x{1};
        double m_y{1};
        int b{44};
        std::string name{"Bobby"};

    public:
        Point() {};
        Point(double x, double y) {
            m_x = x;
            m_y = y;
        }
        ~Point(){}

        double x() {
            return m_x;
        }
        double y() {
            return m_y;
        }

        Point& set_x(double x){
            this->m_x = x;
            return *this;
        }
        Point& set_y(double y) {
            this->m_y = y;
            return *this;
        }
};


void print_point(Point &p) {
    std::cout << "Point : (" << &p << ") x: " << p.x() << ", y : " << p.y() << '\n';
}

int main() {

    Point p{2, 2};

    p.set_x(33).set_y(44);

    print_point(p);

    std::cout << sizeof(Point) << '\n';
    std::cout << sizeof(std::string) << '\n';

    return 0;
}
