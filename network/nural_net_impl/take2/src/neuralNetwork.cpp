#include "../headers/neuralNetwork.hpp"


NeuralNetwork::NeuralNetwork(std::vector<int> topology) : topologySize(topology.size()), topology(topology){
    for(int i = 0; i < topologySize; i++) {
        Layer *l = new Layer(topology[i]);
        layers.push_back(l);
    }

    for(int i = 0; i < topologySize - 1; i++) {
        Matrix *m = new Matrix(topology[i], topology[i + 1], true);
        weightMatrices.push_back(m);
    }
}

void NeuralNetwork::setCurrentInput(std::vector<double> input) {
    this->input = input;

    for(int i = 0; i < input.size(); i++) {
        this->layers[0]->setVal(i, input[i]);
    }
}

std::vector<Layer*>& NeuralNetwork::getLayers() {
    return layers;
}

void NeuralNetwork::printToConsole() {
    for(int i = 0; i < layers.size(); i++) {
        std::cout << "LAYER: " << i << '\n';
        if (i == 0) {
            Matrix *m = this->layers[0]->matrixifyVals(); 
            m->printToConsole();
            delete m;
        } else {
            Matrix *m = this->layers[i]->matrixifyActivatedVals(); 
            m->printToConsole();
            delete m;
        }
    }
}


NeuralNetwork::~NeuralNetwork() {
    for(int i = 0; i < weightMatrices.size(); i++) {
        delete weightMatrices[i];
    }
    for(int i = 0; i < layers.size(); i++) {
        delete layers[i];
    }
}

