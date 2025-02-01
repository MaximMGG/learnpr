#ifndef LAYER_HPP
#define LAYER_HPP

#include "neuron.hpp"
#include "matrix.hpp"
#include <vector>

class Layer {
    public:
        Layer(int size);
        void setVal(int i, double val);
        ~Layer();

        Matrix *matrixifyVals();
        Matrix *matrixifyActivatedVals();
        Matrix *matrixifyDerivedVals();

    private:
        int size;

        std::vector<Neuron *> neurons;
};


#endif //LAYER_HPP
