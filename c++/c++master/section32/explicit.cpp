#include <iostream>



class Square {

    private:
        double size_param;
        std::string color_param;
        int shading_param;
        double poisition;

    public:

        Square(double size_param);
        Square(double sizeparam, std::string color_param, int shading_param);

        void print();

};


Square::Square(double size_param) : Square(size_param, "Superduper", 9){
    std::cout << "Body of Square constructor with signle param\n";
}

Square::Square(double size_param, std::string color_param, int shading_param) : 
    size_param(size_param), color_param(color_param), shading_param(shading_param){
        std::cout << "Body of Square constructor with multiple params\n";
}

void Square::print() {
    std::cout << "--\n"         <<
        size_param << '\n'      <<
        color_param << '\n'     <<
        shading_param << '\n'   <<
        "--\n";
}


class Point {
    private:
        double x;


    public:

        explicit Point(double x = 12.0) : x(x){}
        ~Point(){}

        double get_x() const {
            return x;
        }

};


bool compare(const Point& x, const Point& y) {
    if (x.get_x() > y.get_x()) {
        return true;
    } else {
        return false;
    }
}





int main() {

    Point a{123};
    Point b{333};

    std::cout << std::boolalpha << compare(a, b) << '\n';
    // std::cout << std::boolalpha << compare(a, 777) << '\n';
    //


    std::string name {"Hello"};


    Square c {123};
    Square d {123, name, 3};

    c.print();
    d.print();

    return 0;
}
