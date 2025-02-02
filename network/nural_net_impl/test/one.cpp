#include <iostream>
#include <pthread.h>
#include <vector>
#include <cmath>

#define E 2.71828



class Neuron {
    public:
        Neuron(double val,  double weights[] = nullptr, int weight_size = 1) : val(val){
            if (weights != nullptr) {
                for(int i = 0; i < weight_size; i++) {
                    weight.push_back(weights[i]);
                }
            }
        }

        ~Neuron(){}
        void setActivate(double activate) {
            this->activate = activate;
        } 

        double getActivate() {return activate;}
        double getVal() {return val;}
        std::vector<double>& getWeight(){return weight;}

        void setVal(double val) {this->val = val;}
        void setWeight(std::vector<double> weight){this->weight = weight;}

    private:
        double val;
        std::vector<double> weight;
        double activate{0.5};
};

class Layer {

    public:

        Layer(int rows) : rows(rows){
            for(int i = 0; i < rows; i++) {
                layer.push_back(Neuron(0));
            }
        }

        Layer(int rows, double arr[]) : rows(rows){
            for(int i = 0; i < rows; i++) {
                layer.push_back(Neuron(arr[i]));
            }
        }
        Layer(int rows, double arr[], double **weights, int count_next_layer) {
            for(int i = 0; i < rows; i++) {
                layer.push_back(Neuron(arr[i], weights[i], count_next_layer));
            }
        }

        std::vector<Neuron>& getLayer() {return layer;}

    private:
        std::vector<Neuron> layer;
        int rows;

};

class Network {
    public:
        Network(int count_layers, double layers[] = nullptr) : count_layers(count_layers){
            if (layers != nullptr) {
                for(int i; i < count_layers; i++) {
                    this->layers.push_back(Layer(layers[i]));

                }

            }
        }
        ~Network(){}

        void activate() {
            for(int i = 1; i < layers.size(); i++) {
                for(int j = 0; j < layers[i].getLayer().size(); j++) {
                    double sum{0};
                    auto& tmp = layers[i - 1].getLayer();

                    for(int k = 0; k < layers[i - 1].getLayer().size(); k++) {
                        sum += tmp[k].getVal() * tmp[k].getWeight()[j];
                    }

                    double activ = 1 / (1 + std::pow(E, -sum));
                    if (activ > layers[i].getLayer()[j].getActivate()) {
                        layers[i].getLayer()[j].setVal(activ);
                    }
                 }
            }
        }
        std::vector<Layer>& getLayers() {return layers;}


    private:
        int count_layers;
        std::vector<Layer> layers;

};


int main() {

    double values[2] {1.0, 0.5};
    double w1[2] {0.9, 0.2};
    double w2[2] {0.3, 0.8};
    double **weights = new double * [2];
    weights[0] = w1;
    weights[1] = w2;

    Layer input (2, values, weights, 2);
    Layer first(2);
    Network nn (2);
    nn.getLayers().push_back(input);
    nn.getLayers().push_back(first);

    nn.activate();

    std::cout << "first neuron : " << nn.getLayers()[1].getLayer()[0].getVal() << 
                " second neuron : " << nn.getLayers()[1].getLayer()[1].getVal() << '\n';


    delete [] weights;

    return 0;
}
