#include <iostream>
#include <cstdlib>
#include <cstring>
#include <array>


#define DEF_SIZE 10
#define let auto

template <typename T>
T REALLOC(T ptr, int size) {




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

        void resize(int size) {
            arr = new (arr) T[size];
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
    //
    // char m1[10] = "Name";
    // char m2[10] = "Bybe";
    //
    // names[0] = m1;
    // names[1] = m2;




    // names.resize(14);

    // std::cout << "Names is: " << names[0] << " " << names[1] << '\n';

    // std::string *names = new std::string[5];
    //
    // names[0] = "Alla";
    // names[1] = "Bobe";
    //
    // std::cout << "Names is: " << names[0] << " " << names[1] << '\n';
    //
    //
    // delete [] names;

    int *arr = new int[10];
    let *buf = new int[14];

    for(int i = 0; i < 20; i++) {
        arr[i] = i;
        if (i == 9) {
            arr = new (arr) int [20];
        }
    }

    delete []arr;

    return 0;
}
