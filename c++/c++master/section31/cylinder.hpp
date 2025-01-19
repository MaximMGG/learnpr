#ifndef CYLINDER_H
#define CYLINDER_H

#include <iostream>

class Cylinder {
    static constexpr double PI = 3.14;

    private:
        double base_radius {1};
        double height {1};

    public:

        Cylinder();
        Cylinder(double radius_param, double height_param);
        ~Cylinder();

        void set_base_radius(double radius);
        void set_height(double height);

        double get_base_radius();
        double get_height();



        double volum();

        void print();
};

#endif //CYLINDER_H
