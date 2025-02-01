#ifndef MATRIX_HPP
#define MATRIX_HPP

#include <vector>
#include <iostream>


class Matrix {
    public:

        Matrix(int numRows, int numCols, bool isRandom);

        Matrix *transpose();

        void setValue(int r, int c, double val);
        double getValue(int r, int c);
        double getRandomNumber();

        void printToConsole();

        int getNumRows() {return this->numRows;}
        int getNumCols() {return this->numCols;}

    private:
        int numRows;
        int numCols;
        
        std::vector<std::vector<double>> values;
};


#endif //MATRIX_HPP
