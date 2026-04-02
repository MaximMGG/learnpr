#include "cylinder.hpp"


Cylinder::Cylinder() = default;
Cylinder::Cylinder(double radius_param, double height_param) {
    base_radius = radius_param;
    height = height_param;

}
Cylinder::~Cylinder(){
    std::cout << "Distructor works for objcet " << this << "\n";
}

double Cylinder::volum() {
    return this->base_radius * this->height;
}


void Cylinder::print() {
    std::cout << "base_radius : " << this->base_radius << " height : " << this->height << '\n';

}

void Cylinder::set_base_radius(double radius) {
    base_radius = radius;

}

void Cylinder::set_height(double height) {
    this->height = height;
}

double Cylinder::get_base_radius() {
    return base_radius;

}

double Cylinder::get_height() {
    return height;
}
