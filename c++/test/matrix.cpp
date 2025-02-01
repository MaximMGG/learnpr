#include <iostream>
#include <vector>
#include <cstring>

template <typename T>
class Matrix {

    class Matrix_exeption : std::exception {
        public:
            Matrix_exeption(const char *msg) {
                std::strcpy(buf, msg);
            }

            const char *getError() {return static_cast<const char *>(buf);}

        private:
            char buf[512]{0};

    };



    public:
        Matrix(int rows, int cols) : rows(rows), cols(cols){
            for(int i = 0; i < rows; i++) {
                std::vector<T> tmp;
                for(int j = 0; j < cols; j++) {
                    tmp.push_back(0);
                }
                matrix.push_back(tmp);
            }
        }

        Matrix<T> operator*(Matrix& b) {
            if (this->rows != b.cols || this->cols != b.rows) {
                std::cerr << "Incorrect matrixies\n";
                throw Matrix_exeption("Incorrect matrixis");
            }

            Matrix<T> nm (this->rows, b->cols);

            for(int i = 0; i < this->rows; i++) {
                for(int j = 0; j < b.cols; j++) {
                    for(int k = 0; i < this->rows; k++) {


                    }
                }
            }




        }


    private:
        std::vector<std::vector<T>> matrix;
        int rows;
        int cols;
};





int main() {



    return 0;
}
