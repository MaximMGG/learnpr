#include <iostream>

class Point {
    public:
        static size_t m_point_count;


        Point(double x, double y);
        Point(double xy_coord);
        Point();
        Point(const Point& point);
        ~Point();
        double length() const;

        size_t get_point_count() const {
            return m_point_count;
        }

        void print_info() const {
            std::cout << "Point : [&x: " << &x << ", &y: " << &y << "]" << '\n';
        }

    private:
        double x;
        double y;
};
