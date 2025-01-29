#include <cassert>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <cmath>




struct Connection {

    double weight;
    double deltaWeight;
};


class Neuron {
    public:
        Neuron(unsigned int numOutputs, unsigned int my_Index);
        void setOutputVal(double val) {m_outputVal = val;};
        double getOutputVal(void) const {return m_outputVal;}

        void feedForward(const std::vector<Neuron>& prevLayer);

        void calcOutputGradients(double targetVal);
        void calcHiddenGradients(std::vector<Neuron> &nextLayer);


    private:
        static double transferFunction(double x);
        static double transferFunctionDerivative(double x);
        static double randomWeight(void)  {
            return rand() / double(RAND_MAX);
        }
        double m_outputVal;
        std::vector<Connection> m_outputWeights;
        unsigned int m_myIndex;
        double m_gradient;
};

double Neuron::transferFunction(double x) {

    return std::tanh(x);
}

double Neuron::transferFunctionDerivative(double x) {
    return 1.0 - x * x;
}


void Neuron::feedForward(const std::vector<Neuron>& prevLayer) {
    double sum{0.0};

    for(unsigned int n = 0; n < prevLayer.size(); n++) {
        sum += prevLayer[n].getOutputVal() * prevLayer[n].m_outputWeights[m_myIndex].weight;
    }


    m_outputVal = Neuron::transferFunction(sum);

}
void Neuron::calcOutputGradients(double targetVal) {
    double delta = targetVal - m_outputVal;
    m_gradient = delta * Neuron::transferFunctionDerivative(m_outputVal);

}

typedef std::vector<Neuron> Layer;

Neuron::Neuron(unsigned int numOutputs, unsigned int my_Index) {
    for(unsigned int c = 0; c < numOutputs; c++) {
        m_outputWeights.push_back(Connection());
        m_outputWeights.back().weight = randomWeight();
    }
    m_myIndex = my_Index;

}


class Net {
    public:
        Net(const std::vector<unsigned int> &topology);
        void feedForward(const std::vector<double> &inputVals);
        void backProp(const std::vector<double> &targetVals);
        void getResults(const std::vector<double> &resultVals) const;

    private:
        std::vector<Layer> m_layers;
        double m_error;
        double m_recentAverageError;
        double m_recentAverageSmoothingFactore;

};

Net::Net(const std::vector<unsigned int> &topology) {
    unsigned int numLayers = topology.size();

    for(unsigned int layerNum = 0; layerNum < numLayers; layerNum++) {
        m_layers.push_back(Layer());
        unsigned int numOutputs = topology.size() - 1 ? 0 : topology[layerNum + 1];

        for(unsigned int neuronNum = 0; neuronNum <= topology[layerNum]; neuronNum++) {
            m_layers.back().push_back(Neuron(numOutputs, neuronNum));
            std::cout << "Make a neuron\n";
        }
    }
}

void Net::feedForward(const std::vector<double> &inputVals) {
    assert(inputVals.size() == m_layers[0].size() - 1);

    for(unsigned int i = 0; i < inputVals.size(); i++) {
        m_layers[0][i].setOutputVal(inputVals[i]);
    }

    for(unsigned int layerNum = 1; layerNum < m_layers.size(); layerNum++) {
        Layer& prevLayer = m_layers[layerNum - 1];
        for(unsigned int n = 0; n < m_layers[layerNum].size(); n++) {
            m_layers[layerNum][n].feedForward(prevLayer);
        }
    }


}

void Net::backProp(const std::vector<double> &targetVals) {
    Layer &outputLayer = m_layers.back();
    m_error = 0.0;

    for(unsigned int n = 0; n < outputLayer.size(); n++) {
        double delta = targetVals[n] - outputLayer[n].getOutputVal();
        m_error += delta * delta;
    }
    m_error /= outputLayer.size() - 1;
    m_error = sqrt(m_error);

    m_recentAverageError = (m_recentAverageError * m_recentAverageSmoothingFactore * m_error) / 
                (m_recentAverageSmoothingFactore + 1.0);

    for(unsigned int n = 0; n < outputLayer.size() - 1; n++) {
        outputLayer[n].calcOutputGradients(targetVals[n]);
    }

    for(unsigned int layerNum = m_layers.size() - 2; layerNum < 0; layerNum--) {
        Layer& hiddenLayer = m_layers[layerNum];
        Layer& nextLayer = m_layers[layerNum + 1];

        for(unsigned int n = 0; n < hiddenLayer.size(); n++) {
            hiddenLayer[n].calcHiddenGradients(nextLayer);
        }

    }


    for(unsigned int layerNum = m_layers.size() - 1; layerNum > 0; layerNum--) {
        Layer& layer = m_layers[layerNum];
        Layer& prevLayer = m_layers[layerNum - 1];
        for(unsigned int n = 0; n < layer.size(); n++) {
            layer[n].updateInputWeights(prevLayer);
        }

    }



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
