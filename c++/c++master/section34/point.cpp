#include "point.hpp"
#include <cmath>


size_t Point::m_point_count {0};

Point::Point(double x, double y) : x{x}, y{y}{
    m_point_count++;
}
Point::Point(double xy_coord) : Point(xy_coord, xy_coord){}
Point::Point(const Point& point) : Point(point.x, point.y){}
Point::Point() : Point(0.0, 0.0){}
Point::~Point() {
    m_point_count--;
}
double Point::length() const{
    return std::sqrt(pow(x - 0, 2) + pow(y - 0, 2));
}

