#include <iostream>
#include <cstdlib>
#include <cstring>


#define DEF_SIZE 10

template <int>
int *REALLOC(int *ptr, int size) {
    return ptr;
}

template <typename T>
class Arr {
    private: 
        T *arr;
        unsigned int len;
    public:
        Arr(int size = DEF_SIZE) {
            arr = new T[size];
        }       
        ~Arr() {
            delete []arr;
        }
        T& operator[] (int i) {
            return arr[i];
        }

};

int main() {

    // Arr<int> a(10);
    //
    // for(int i = 0; i < 5; i++) {
    //     a[i] = i;
    // }
    // for(int i = 0; i < 5; i++) {
    //     std::cout << a[i] << '\n';
    // }
    //
    //
    // Arr<std::string> names;
    //
    // char m1[10] = "Name";
    // char m2[10] = "Bybe";
    //
    // names[0] = m1;
    // names[1] = m2;
    //
    // std::cout << "Names is: " << names[0] << " " << names[1] << '\n';


    int *arr = new int[10];

    for(int i = 0; i < 20; i++) {
        arr[i] = i;
        if (i == 9) {
        }
    }

    delete []arr;

    return 0;
}
