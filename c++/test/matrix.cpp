#include <iomanip>
#include <iostream>
#include <vector>
#include <cstring>
#include <cstdlib>

template <typename T>
class Matrix {

    public:
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
        Matrix(int rows, int cols, T **arr) : rows(rows), cols(cols) {
            for(int i = 0; i < rows; i++) {
                std::vector<T> tmp;
                for(int j = 0; j < cols; j++) {
                    tmp.push_back(arr[i][j]);
                }
                matrix.push_back(tmp);
            }
        }

/*
 

   {1, 0, 3}            {3, 4, 4, 1}
   {2, 2, 4}            {1, 2, 2, 3}
   {3, 1, 3}            {2, 1, 1, 2}
   {2, 2, 1}
 
 */



        Matrix<T> operator*(Matrix& b) {
            if (this->rows != b.cols || this->cols != b.rows) {
                std::cerr << "Incorrect matrixies\n";
                throw Matrix_exeption("Incorrect matrixis");
            }

            Matrix<T> nm (this->rows, b.cols);
            nm.matrix.clear();

            for(int i = 0; i < this->rows; i++) {
                std::vector<T> tmp;
                for(int j = 0; j < b.cols; j++) {
                    T sum{0};
                    for(int k = 0; k < b.rows; k++) {
                        sum += this->matrix[i][k] * b.matrix[k][j];
                    }
                    tmp.push_back(sum);
                }
                nm.matrix.push_back(tmp);
            }
            return nm;
        }

        void printToConsole() {
            for(int i = 0; i < rows; i++) {
                if (i == 0) std::cout << "/ ";
                if (i != 0 && i < rows - 1) std::cout << "| ";
                if (i == rows - 1) std::cout << "\\ ";
                for(int j = 0; j < cols; j++) {
                    std::cout << std::setw(4) << this->matrix[i][j] << ' ';
                }
                if (i == 0) std::cout << "   \\";
                if (i != 0 && i < rows - 1) std::cout << "   |";
                if (i == rows - 1) std::cout << "   /";
                std::cout << '\n';
            }
            std::cout << '\n';
        }


    private:
        std::vector<std::vector<T>> matrix;
        int rows;
        int cols;
};

/*
   {1, 0, 3}            {3, 4, 4, 1}
   {2, 2, 4}            {1, 2, 2, 3}
   {3, 1, 3}            {2, 1, 1, 2}
   {2, 2, 1}
   */

int main() {

    double **arr1 = new double *[4];
    // double **arr1 = (double **)malloc(sizeof(double *) * 4);
    for(int i = 0; i < 4; i++) {
        arr1[i] = new double [3];
        // arr1[i] = (double *)malloc(sizeof(double) * 3);

    }
    double **arr2 = new double *[3];
    // double **arr2 = (double **) malloc(sizeof(double *) * 3);
    for(int i = 0; i < 3; i++) {
        arr2[i] = new double [4];
        // arr2[i] = (double *) malloc(sizeof(double) * 4);
    }

    double a1[][3] {
        {1, 0, 3},
        {2, 2, 4},
        {3, 1, 3},
        {2, 2, 1}
    };

    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 3; j++) {
            arr1[i][j] = a1[i][j];
        }
    }

    double a2[][4] {
        {3, 4, 4, 1},
        {1, 2, 2, 3},
        {2, 1, 1, 2}
    };

    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 4; j++) {
            arr2[i][j] = a2[i][j];
        }
    }

    Matrix<double> m1 {4, 3, arr1};
    Matrix<double> m2 {3, 4, arr2};

    m1.printToConsole();
    m2.printToConsole();

    Matrix res = m1 * m2;

    res.printToConsole();

    for(int i = 0; i < 4; i++) {
        delete [] arr1[i];
        // free(arr1[i]);
    }
    delete [] arr1;
    // free(arr1);

    for(int i = 0; i < 3; i++) {
        delete [] arr2[i];
        // free(arr2[i]);
    }
    delete [] arr2;
    // free(arr2);


    return 0;
}
