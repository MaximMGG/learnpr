#ifndef MATRIX_HPP
#define MATRIX_HPP
#include <vector>
#include <cstring>
#include <iostream>
#include <iomanip>

template <typename T>
class Matrix {

    class Matrix_error : std::exception {
        public:
            char buf[512]{0};
            Matrix_error(const char *msg) {
                std::strcpy(buf, msg);
            }

            const char *get_error() const {
                return (const char *) buf;
            }

    };

    public:
        int rows;
        int cols;
        std::vector<T> matrix;

        Matrix(int rows, int cols) : rows(rows), cols(cols){
            matrix.resize(rows * cols, 0);
        }
        Matrix(int rows, int cols, T arr[]) : rows(rows), cols(cols) {
            matrix.resize(rows * cols, 0);
            int k{0};
            for(int i = 0; i < rows; i++) {
                for(int j = 0; j < cols; j++) {
                    matrix[i * cols + j] = arr[k++];
                }
            }
        }

        T& at(int row, int col) {
            return matrix[row * cols + col];
        }

        Matrix operator*(Matrix &b) {
            if (this->cols != b.rows && this->rows != b.cols) {
                throw Matrix_error("rows not the same as cols");
            }

            Matrix<T> nm (this->rows, b.cols);

            for(int i = 0; i < nm.rows; i++) {
                for(int j = 0; j < nm.cols; j++) {
                    double sum{0};
                    for(int k = 0; k < b.rows; k++) {
                        sum += this->at(i, k) * b.at(k, j);
                    }
                    nm.at(i, j) = sum;
                }
            }
            return nm;
        }


        Matrix<T> transporent() {
            Matrix<T> m (this->cols, this->rows);

            for(int i = 0; i < this->rows; i++) {
                for(int j = 0; j < this->cols; j++) {
                    m.at(j, i) = this->at(i, j);
                }
            }

            return m;
        }

        void print() {
            std::cout << '/';
            for(int i = 0; i < rows; i++) {
                if (i == rows - 1) std::cout <<'\\';
                else if (i != 0) std::cout << '|';
                for(int j = 0; j < cols; j++) {
                    std::cout << std::setw(4) << matrix[i * cols + j];
                }
                if (i == 0) std::cout << std::setw(4) << '\\';
                else if (i == rows - 1) std::cout << std::setw(4) << '/';
                else std::cout << std::setw(4) << '|';
                std::cout << '\n';
            }
            std::cout << '\n';
        }

};


#endif //MATRIX_HPP
