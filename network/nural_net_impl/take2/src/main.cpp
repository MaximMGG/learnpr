#include "../headers/neuron.hpp"
#include "../headers/matrix.hpp"
#include "../headers/neuralNetwork.hpp"


int main() {

    std::vector<int> topology;
    topology.push_back(3);
    topology.push_back(2);
    topology.push_back(3);

    std::vector<double> input;
    input.push_back(1.0);
    input.push_back(0.0);
    input.push_back(0.1);

    NeuralNetwork *nn = new NeuralNetwork(topology);
    nn->setCurrentInput(input);

    std::vector<Layer *> &layers = nn->getLayers();

    // for(int i = 0; i < layers.size(); i++) {
    //     Matrix *m = layers[i]->matrixifyVals();
    //     m->printToConsole();
    //     delete m;
    // }
    
    nn->printToConsole();
    delete nn;

    return 0;
}
