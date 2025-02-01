#include "../headers/matrix.hpp"
#include <random>


Matrix *Matrix::transpose() {
    Matrix *m = new Matrix(this->numCols, this->numRows, false);
    for(int i = 0; i < m->numRows; i++) {
        for(int j = 0; j < m->numCols; j++) {
            m->setValue(i, j, values[j][i]);
        }
    }

    return m;
}

Matrix::Matrix(int numRows, int numCols, bool isRandom) : numRows(numRows), numCols(numCols){
    
    for(int i = 0; i < numRows; i++) {
        std::vector<double> colValues;
        for(int j = 0; j < numCols; j++) {
            double r {0.0};
            if (isRandom) {
                r = getRandomNumber();
            }
            colValues.push_back(r);
        }
        values.push_back(colValues);
    }
}

void Matrix::printToConsole() {
    for(int i = 0; i < numRows; i++) {
        for(int j = 0; j < numCols; j++) {
            std::cout << values[i][j] << ' ';
        }
        std::cout << '\n';
    }
}

void Matrix::setValue(int r, int c, double val) {
    values[r][c] = val;
}

double Matrix::getValue(int r, int c) {
    return values[r][c];
}

double Matrix::getRandomNumber() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0, 1);

    return dis(gen);

}
