#include <stdio.h>


template <typename T>
struct DArr {
  T *data;
  int len = 0;
  int cap = 8;
  DArr() {
    this->data = new T [this->cap];
  }
  ~DArr() {
    delete [] this->data;
  }

  T& operator[](int index) {
    if (index < 0 || index >= this->len) {
      return this->data[0];
    }
    return this->data[index];
  }
  void append(T t) {
    this->data[this->len++] = t;
  }
};

int main() {

  DArr<int> arr{};

  arr.append(3);
  arr.append(7);
  arr.append(89898);

  arr[2] = 3;

  for(int i = 0; i < arr.len; i++) {
    printf("%d\n", arr[i]);
  }

  return 0;
}



