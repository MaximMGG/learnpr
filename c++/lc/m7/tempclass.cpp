#include <iostream>



template <typename T>
class Pair {
    T first {};
    T second {};

    public:
        Pair(T t, T b) : first(t), second(b) {};
};

template <typename T>
struct Sur {
    T first {};
    T second {};
};

template <typename T>
Sur(T t, T b) -> Sur<T>;

int main() {
    Pair<double> d {3.4, 2.1};
    Pair<int> c {1, 2};
    Pair<int> cc {0, 0};
    Sur<int> s {1, 2};
    Sur b {2.3, 5.1};

    Sur<Pair<int>> aca {cc, c};

    return 0;
}
