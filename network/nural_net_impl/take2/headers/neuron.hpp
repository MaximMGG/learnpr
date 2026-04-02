#ifndef NEURON_HPP
#define NEURON_HPP

#include <iostream>
#include <cmath>

class Neuron {
    public:

        Neuron(double val);


        //Fast Sigmoid Function
        //f(x) = x / (1 + |x|)
        void activate();


        //Derivative for fast sigmoid function
        //f'(x) = f(x) * (1 - f(x))
        void derive();

        //Getter
        double getVal() {return this->val;}
        double getActivatedVal() {return this->activatedVal;}
        double getDerivedVal() {return this->derivedVal;}
        //Setter
        void setVal(double val);
    private:
        //1.5
        double val;
        //0-1
        double activatedVal;

        double derivedVal;
};


#endif //NEURON_HPP
