#include <string.h>
#include <stdio.h>


template <typename T>
class Matrix {
public:
  T data[4][4];

  Matrix() {
    memset(data, 0, sizeof(T) * 16);
  }

  Matrix(T val) {
    data[0][0] = val;
    data[1][1] = val;
    data[2][2] = val;
    data[3][3] = val;
  }


  Matrix<T> operator+(Matrix b) {
    Matrix<T> res;
    res[0][0] = data[0][0] + b.data[0][0];
    res[0][1] = data[0][1] + b.data[0][1];
    res[0][2] = data[0][2] + b.data[0][2];
    res[0][3] = data[0][3] + b.data[0][3];

    res[1][0] = data[1][0] + b.data[1][0];
    res[1][1] = data[1][1] + b.data[1][1];
    res[1][2] = data[1][2] + b.data[1][2];
    res[1][3] = data[1][3] + b.data[1][3];

    res[2][0] = data[2][0] + b.data[2][0];
    res[2][1] = data[2][1] + b.data[2][1];
    res[2][2] = data[2][2] + b.data[2][2];
    res[2][3] = data[2][3] + b.data[2][3];

    res[3][0] = data[3][0] + b.data[3][0];
    res[3][1] = data[3][1] + b.data[3][1];
    res[3][2] = data[3][2] + b.data[3][2];
    res[3][3] = data[3][3] + b.data[3][3];
    return res;
  }

  Matrix<T> operator*(T val) {
    Matrix<T> res;

    for(int i = 0; i < 4; i++) {
      for(int j = 0; j < 4; j++) {
        res[i][j] = this->data[i][j] * val;
      }
    }

    return res;
  }

  inline T* operator[](int index) {
    return data[index];
  }

  void print() {
    printf("[%.2f %.2f %.2f %.2f]\n[%.2f %.2f %.2f %.2f]\n[%.2f %.2f %.2f %.2f]\n[%.2f %.2f %.2f %.2f]\n", 
        this->data[0][0],
        this->data[0][1],
        this->data[0][2],
        this->data[0][3],
        this->data[1][0],
        this->data[1][1],
        this->data[1][2],
        this->data[1][3],
        this->data[2][0],
        this->data[2][1],
        this->data[2][2],
        this->data[2][3],
        this->data[3][0],
        this->data[3][1],
        this->data[3][2],
        this->data[3][3]);

  }

};


template <typename T>
Matrix<T> operator+(Matrix<T> a, Matrix<T> b) {
  Matrix<T> res;
  res[0][0] = a.data[0][0] + b.data[0][0];
  res[0][1] = a.data[0][1] + b.data[0][1];
  res[0][2] = a.data[0][2] + b.data[0][2];
  res[0][3] = a.data[0][3] + b.data[0][3];

  res[1][0] = a.data[1][0] + b.data[1][0];
  res[1][1] = a.data[1][1] + b.data[1][1];
  res[1][2] = a.data[1][2] + b.data[1][2];
  res[1][3] = a.data[1][3] + b.data[1][3];

  res[2][0] = a.data[2][0] + b.data[2][0];
  res[2][1] = a.data[2][1] + b.data[2][1];
  res[2][2] = a.data[2][2] + b.data[2][2];
  res[2][3] = a.data[2][3] + b.data[2][3];
  
  res[3][0] = a.data[3][0] + b.data[3][0];
  res[3][1] = a.data[3][1] + b.data[3][1];
  res[3][2] = a.data[3][2] + b.data[3][2];
  res[3][3] = a.data[3][3] + b.data[3][3];
}


template <typename T>
Matrix<T> operator*(Matrix<T> a, Matrix<T> b) {
  Matrix<T> res;
  res[0][0] = a[0][0] * b[0][0] + a[0][1] * b[1][0] + a[0][2] * b[2][0] + a[0][3] * b[3][0];
  res[0][1] = a[0][0] * b[0][1] + a[0][1] * b[1][1] + a[0][2] * b[2][1] + a[0][3] * b[3][1];
  res[0][2] = a[0][0] * b[0][2] + a[0][1] * b[1][2] + a[0][2] * b[2][2] + a[0][3] * b[3][2];
  res[0][3] = a[0][0] * b[0][3] + a[0][1] * b[1][3] + a[0][2] * b[2][3] + a[0][3] * b[3][3];

  res[1][0] = a[1][0] * b[0][0] + a[1][1] * b[1][0] + a[1][2] * b[2][0] + a[1][3] * b[3][0];
  res[1][1] = a[1][0] * b[0][1] + a[1][1] * b[1][1] + a[1][2] * b[2][1] + a[1][3] * b[3][1];
  res[1][2] = a[1][0] * b[0][2] + a[1][1] * b[1][2] + a[1][2] * b[2][2] + a[1][3] * b[3][2];
  res[1][3] = a[1][0] * b[0][3] + a[1][1] * b[1][3] + a[1][2] * b[2][3] + a[1][3] * b[3][3];

  res[2][0] = a[2][0] * b[0][0] + a[2][1] * b[1][0] + a[2][2] * b[2][0] + a[2][3] * b[3][0];
  res[2][1] = a[2][0] * b[0][1] + a[2][1] * b[1][1] + a[2][2] * b[2][1] + a[2][3] * b[3][1];
  res[2][2] = a[2][0] * b[0][2] + a[2][1] * b[1][2] + a[2][2] * b[2][2] + a[2][3] * b[3][2];
  res[2][3] = a[2][0] * b[0][3] + a[2][1] * b[1][3] + a[2][2] * b[2][3] + a[2][3] * b[3][3];

  res[3][0] = a[3][0] * b[0][0] + a[3][1] * b[1][0] + a[3][2] * b[2][0] + a[3][3] * b[3][0];
  res[3][1] = a[3][0] * b[0][1] + a[3][1] * b[1][1] + a[3][2] * b[2][1] + a[3][3] * b[3][1];
  res[3][2] = a[3][0] * b[0][2] + a[3][1] * b[1][2] + a[3][2] * b[2][2] + a[3][3] * b[3][2];
  res[3][3] = a[3][0] * b[0][3] + a[3][1] * b[1][3] + a[3][2] * b[2][3] + a[3][3] * b[3][3];

  return res;
}

template <typename T>
Matrix<T> operator*(Matrix<T> a, T val) {
  Matrix<T> res;

  for(int i = 0; i < 4; i++) {
    for(int j = 0; j < 4; j++) {
      res[i][j] = a[i][j] * val;
    }
  }

  return res;
}


