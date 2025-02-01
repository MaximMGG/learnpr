#include "../headers/layer.hpp"


Layer::Layer(int size) {
    for(int i = 0; i < size; i++) {
        Neuron *n = new Neuron(0.0);
        this->neurons.push_back(n);
    }
}

void Layer::setVal(int i, double val) {
    neurons[i]->setVal(val);
}

Matrix *Layer::matrixifyVals() {
    Matrix *m = new Matrix(1, this->neurons.size(), false);
    for(int i = 0; i < neurons.size(); i++) {
        m->setValue(0, i, neurons[i]->getVal());
    }
    return m;

}
Matrix *Layer::matrixifyActivatedVals() {
    Matrix *m = new Matrix(1, this->neurons.size(), false);
    for(int i = 0; i < neurons.size(); i++) {
        m->setValue(0, i, neurons[i]->getActivatedVal());
    }

    return m;
}
Matrix *Layer::matrixifyDerivedVals() {
    Matrix *m = new Matrix(1, this->neurons.size(), false);
    for(int i = 0; i < neurons.size(); i++) {
        m->setValue(0, i, neurons[i]->getDerivedVal());
    }
    return m;
}

