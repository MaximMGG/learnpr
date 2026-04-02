#include <iostream>

template <typename T>
struct JSON_OBJ {
    std::string key_name;
    T value;
    struct JSON_OBJ<T> table;
};

class JSON {

    enum JSON_OBJ_TYPE {
        NUMBER, STRING, BOOLEAN, ARRAY, TABLE
    };

    JSON() {};



};



int main() {


    return 0;
}
