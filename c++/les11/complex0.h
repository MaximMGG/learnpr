#ifndef _COMPLEX_H_
#define _COMPLEX_H_
#include <iostream>

class complex {
    private:
        double a;
        double bi;
    public:
        complex(double a = 0.0, double bi = 0.0);
        complex();

        complex operator+(const complex& b) const;
        complex operator-(const complex& b) const;
        complex operator*(const complex& b) const;
        std::ostream& operator<<(std::ostream& os);
        friend std::istream& operator>>(std::istream& in, complex& b);
        friend std::ostream& operator<<(std::ostream& os, complex& b);
        friend complex operator*(double a, const complex& b);
};

#endif //_COMPLEX_H_
