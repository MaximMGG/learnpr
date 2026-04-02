#include <iostream>

class Point {
    private:
        double *x{nullptr};
        double *y{nullptr};


        void invalidate() {
            x = nullptr;
            y = nullptr;
        }


    public:

        Point(double x, double y) : x(new double (x)), y(new double (y)){
            std::cout << "Constructed object : " << this << '\n';
        }
        ~Point(){
            std::cout << "Destruct object : " << this << '\n';
            delete x;
            delete y;
        }
        Point(const Point& source_point) : Point(*source_point.get_x(), *source_point.get_y()){
            std::cout << "Copy constructor\n";
            std::cout << "Copyed : " << &source_point << '\n';
            std::cout << "New : " << this << '\n';
        }
        Point(const Point&& source_point) : Point(*source_point.get_x(), *source_point.get_y()){
            std::cout << "Copy && constructor\n";
            std::cout << "Copyed : " << &source_point << '\n';
            std::cout << "New : " << this << '\n';
        }

        void set_x(double x) {
            *this->x = x;
        }
        void set_y(double y) {
            *this->y = y;
        }

        double *get_x() const {
            return x;
        }
        double *get_y() const {
            return y;
        }

        void print_info() {
            std::cout << "Object : " << this << " x : " << (*x) << " y : " << (*y) << '\n';
        }
};




int main() {

    Point p1 (10.3, 15.9);
    p1.print_info();

    Point p2 (p1);
    p2.print_info();

    std::cout << "--\n"; 
    Point p3 (Point(20.3, 30.3));
    p3.print_info();


    return 0;
}
