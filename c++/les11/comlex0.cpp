#include "complex0.h"


complex::complex() {
    this->a = 0.0;
    this->bi = 0.0;
}
complex::complex(double a, double b) {
    this->a = a;
    this->bi = b;
}


complex complex::operator+(const complex& b) const {
    return complex(this->a + b.a, this->bi + b.bi);
}

complex complex::operator-(const complex& b) const {
    return complex(this->a - b.a, this->bi - b.bi);
}

complex complex::operator*(const complex& b) const {
    return complex(this->a * b.a - this->bi * b.bi, this->a * b.bi + this->bi * b.a);
}

std::ostream& complex::operator<<(std::ostream& os) {
    return os << this->a << " - A value, and " << this->bi << " B value";
}

std::ostream& operator<<(std::ostream& os, complex& b) {
    return os << b.a << " - A value, and " << b.bi << " B value";
}

std::istream& operator>>(std::istream& in, complex& bi) {
    double a;
    double b;
    in >> a >> b;
    bi = complex(a, b);
    return in;
}

complex operator*(double a, const complex& b) {
    return complex(a * b.a, a * b.bi);
}
