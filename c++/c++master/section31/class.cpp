#include <iostream>
#include "cylinder.hpp"



int main() {


    //std::cout << c.volum() << '\n';


    Cylinder d (123.4, 999.0);
    std::cout << "volume : " << d.volum() << '\n';
    d.print();
    
    d.set_base_radius(9999.9);
    d.set_height(111.2323);


    std::cout << "volume : " << d.volum() << '\n';
    d.print();

    std::cout << "radius : " << d.get_base_radius() << '\n';
    std::cout << "height : " << d.get_height() << '\n';

    std::cout << "Object d is : " << &d << '\n';
    Cylinder *c = new Cylinder{3434.2, 11.0};
    c->print();

    std::cout << "Object c is : " << c << '\n';


    delete c;

    std::cout << "Done\n";


    return 0;
}
