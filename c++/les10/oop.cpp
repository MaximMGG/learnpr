#include "oop.hpp"
#include <iostream>

Stock::Stock(std::string name, long capasity, double average) {
    this->name = name;
    this->capasity = capasity;
    this->average = average;
}

Stock::~Stock() {
    delete this;
}

void Stock::set_name(const char *name) {
    this->name = name;
}

std::string Stock::get_name() const{
    return this->name;
}

void Stock::set_capasity(long capasity) {
    this->capasity = capasity;
}

long Stock::get_capasity() const{
    return this->capasity;
}

void Stock::set_average(double average) {
    this->average = average;
}

double Stock::get_average() const{
    return this->average;
}

void Stock::show_stock() const{
    std::cout << "Name is: " << this->name << " ,capasity is: " << this->capasity << ", average is: " << this->average << std::endl;
}

bool Stock::compare(Stock& s) {
    if (s.name == this->name) {
        return true;
    }
    return false;
}



