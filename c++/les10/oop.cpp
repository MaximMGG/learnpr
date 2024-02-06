#include "oop.hpp"


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

std::string Stock::get_name() {
    return this->name;
}

void Stock::set_capasity(long capasity) {
    this->capasity = capasity;
}

long Stock::get_capasity() {
    return this->capasity;
}

void Stock::set_average(double average) {
    this->average = average;
}

double Stock::get_average() {
    return this->average;
}



