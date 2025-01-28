#include <cassert>
#include <vector>
#include <iostream>
#include <cstdlib>

struct Connection {

    double weight;
    double deltaWeight;
};


class Neuron {
    public:
        Neuron(unsigned int numOutputs);
        double setOutputVal(unsigned int outputVal);

    private:
        static double randomWeight(void)  {
            return rand() / double(RAND_MAX);
        }
        double m_outputVal;
        std::vector<Connection> m_outputWeights;
};

Neuron::Neuron(unsigned int numOutputs) {
    for(unsigned int c = 0; c < numOutputs; c++) {
        m_outputWeights.push_back(Connection());
        m_outputWeights.back().weight = randomWeight();

    }

}

typedef std::vector<Neuron> Layer;


class Net {
    public:
        Net(const std::vector<unsigned int> &topology);
        void feedForward(const std::vector<double> &inputVals);
        void backProp(const std::vector<double> &targetVals);
        void getResults(const std::vector<double> &resultVals) const;

    private:
        std::vector<Layer> m_layers;

};

Net::Net(const std::vector<unsigned int> &topology) {
    unsigned int numLayers = topology.size();

    for(unsigned int layerNum = 0; layerNum < numLayers; layerNum++) {
        m_layers.push_back(Layer());
        unsigned int numOutputs = topology.size() - 1 ? 0 : topology[layerNum + 1];

        for(unsigned int neuronNum = 0; neuronNum <= topology[layerNum]; neuronNum++) {
            m_layers.back().push_back(Neuron(numOutputs));
            std::cout << "Make a neuron\n";
        }
    }
}

void Net::feedForward(const std::vector<double> &inputVals) {
    assert(inputVals.size() == m_layers[0].size() - 1);

    for(unsigned int i = 0; i < inputVals.size(); i++) {
        m_layers[0][i].setOutputVal(inputVals[i]);

        //finished at 34:38 https://www.youtube.com/watch?v=sK9AbJ4P8ao&ab_channel=AbhishekPandey
    }


}

void Net::backProp(const std::vector<double> &targetVals) {

}

void Net::getResults(const std::vector<double> &resultVals) const {

}

int main() {

    std::vector<unsigned int> topology;
    topology.push_back(3);
    topology.push_back(2);
    topology.push_back(1);
    Net myNet(topology);

    std::vector<double> inputVals;

    myNet.feedForward(inputVals);

    std::vector<double> targetVals;
    myNet.backProp(targetVals);
    std::vector<double> resultVals;
    myNet.getResults(resultVals);

    return 0;
}
