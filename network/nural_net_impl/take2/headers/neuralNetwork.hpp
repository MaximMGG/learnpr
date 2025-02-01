#ifndef NEURALNETWORK_HPP
#define NEURALNETWORK_HPP

#include <vector>
#include "matrix.hpp"
#include "layer.hpp"

class NeuralNetwork {
    public:

        NeuralNetwork(std::vector<int> topology);
        void setCurrentInput(std::vector<double> input);
        void printToConsole();

        std::vector<Layer*>& getLayers();


    private:
        int topologySize;
        std::vector<int> topology;
        std::vector<Matrix*> weightMatrices;
        std::vector<Layer*> layers;
        std::vector<double> input;

};


#endif //NEURALNETWORK_HPP
