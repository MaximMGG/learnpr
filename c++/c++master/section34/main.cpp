#include <iostream>
#include "point.hpp"



int main() {


    std::cout << "coun: " << Point::m_point_count << '\n';

    Point x(123, 1);
    Point y{12.3, 141.1};

    x.print_info();
    y.print_info();

    std::cout << "coun: " << Point::m_point_count << '\n';

    return 0;
}
