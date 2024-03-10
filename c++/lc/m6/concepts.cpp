#include <iostream>

template <typename T>
concept Multipliable = requires (T t){t * t;};

template <typename T>
requires (Multipliable<T>)T mult(T x, T y) {
    return x * y;
}

template <typename T>
concept _is_this_array  = requires (T t) {t[0];};


template <typename T>
requires (_is_this_array<T>) void print_arr(T& t, const int size) {
    std::cout << "[";
    for(int i = 0; i < size; i++) {
        std::cout << t[i] << ", ";

    }
    std::cout << "]\n";
}

class Rect {
    private:
        int m_cont_size;
    public:
        int x;
        int y;
        int *cont;

        Rect (int cont_size) {
            cont = new int [cont_size];
            m_cont_size = cont_size;
        }

        Rect (int xx, int yy, int cont_size) {
            x = xx;
            y = yy;
            if (cont_size > 0) {
                cont = new int [cont_size];
                m_cont_size = cont_size;
            } else {
                cont = nullptr;
            }
        }
        
        ~Rect () {
            if (cont != nullptr) {
                delete[] cont;
            }
        }
        
        Rect operator*(Rect& r) {
            x *= r.x;
            y *= r.y;
            return *this;
        }

        int& operator[](const int& i) {
            if (i >= 0 && i < m_cont_size) {
                return this->cont[i];
            } else {
                return this->cont[0];
            }
        }
};


int main() {
    std::string a {"Hello"};
    std::string b {"Bye"};

    int x {12};
    int y {14};
    mult(x, y);

    Rect i {1, 2, 0};
    Rect j {4, 5, 0};

    mult(i, j);

    int buf[10] {1, 2, 3, 4, 5, 6, 7};

    print_arr(buf, 10);
    Rect arr = {0, 0, 10};

    for(int i = 0; i < 10; i++) {
        arr.cont[i] = i;
    }

    std::cout << arr[1] << '\n';

    print_arr(arr, 10);

    return 0;
}
