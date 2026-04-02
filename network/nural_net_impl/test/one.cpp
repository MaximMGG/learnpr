#include <cinttypes>
#include <iostream>
#include <pthread.h>
#include <vector>
#include <cmath>
#include "Matrix.hpp"

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
        std::vector<double> mistakes;
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

        Matrix<double> weightMatrixFromLayer() {
            Matrix<double> m (layer[0].getWeight().size(), layer.size());
            for(int i = 0; i < layer[0].getWeight().size(); i++) {
                for(int j = 0; j < layer.size(); j++) {
                    m.at(j, i) = layer[j].getWeight()[i];
                }
            }
            return m;
        }

        Matrix<double> valueMatrixFromLayer() {
            Matrix<double> m (layer.size(), 1);

            for(int i = 0; i < layer.size(); i++) {
                m.at(i, 0) = layer[i].getVal();
            }
            return m;
        }

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
                this->layers.push_back(Layer(0));
            }
        }

        ~Network(){}

        void activate(int l_index) {
            std::cout << "Matrix from layer : " << l_index << '\n';
            Matrix<double> m_weight = layers[l_index].weightMatrixFromLayer();
            Matrix<double> m_val = layers[l_index].valueMatrixFromLayer();
            m_weight.print();
            m_val.print();

            Matrix<double> res = m_weight * m_val;
            std::cout << "Before activation : " << l_index << '\n';
            res.print();


            for(int i = 0; i < res.rows; i++) {
                res.at(i, 0) = 1 / (1 + std::pow(E, -(res.at(i, 0))));
            }

            if (l_index <= layers.size() - 1) {

                for(int i = 0; i < layers[l_index + 1].getLayer().size(); i++) {
                    double input = res.at(i, 0);
                    layers[l_index + 1].getLayer()[i].setVal(input);
                }
            }

            std::cout << "Activated layer " << l_index << '\n';
            res.print();
        }


        std::vector<Layer>& getLayers() {return layers;}


    private:
        int count_layers;
        std::vector<Layer> layers;

};


int main() {

    double values1[3] {0.9, 0.1, 0.8};
    double w1[3] {0.9, 0.3, 0.4};
    double w2[3] {0.2, 0.8, 0.2};
    double w3[3] {0.1, 0.5, 0.6};
    double **weights = new double * [3];
    weights[0] = w1;
    weights[1] = w2;
    weights[2] = w3;

    Layer input (3, values1, weights, 3);

    double values2[3]{0, 0, 0};

    double w4[3] {0.3, 0.7, 0.5};
    double w5[3] {0.6, 0.5, 0.2};
    double w6[3] {0.8, 0.1, 0.9};

    double **weights2 = new double * [3];
    weights2[0] = w4;
    weights2[1] = w5;
    weights2[2] = w6;

    Layer first(3, values2, weights2, 3);

    Network nn (3);
    Layer last(0);
    

    nn.getLayers().push_back(input);
    nn.getLayers().push_back(first);
    nn.getLayers().push_back(last);

    nn.activate(0);
    nn.activate(1);

    //std::cout << "first neuron : " << nn.getLayers()[1].getLayer()[0].getVal() << 
     //           " second neuron : " << nn.getLayers()[1].getLayer()[1].getVal() << '\n';

    delete [] weights;
    delete [] weights2;

    return 0;
}
