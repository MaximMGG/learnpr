#ifndef LIB_LIST_HPP
#define LIB_LIST_HPP
#include <string.h>

#include "types.hpp"

template<typename T>
class List {
private:
    static const u32 DEFAULT_CAPACITY = 32;
    T *data = nullptr;
    u32 capacity;
    u32 len;
public:
    List<T>() {
        data = new T [DEFAULT_CAPACITY];
        capacity = DEFAULT_CAPACITY;
        len = 0;
    }

    List<T>(T *data, u32 len) {
        capacity = DEFAULT_CAPACITY > len ? DEFAULT_CAPACITY : ((len / DEFAULT_CAPACITY) + 1) * DEFAULT_CAPACITY;
        len = len;
        this->data = new T [capacity];
        memcpy(this->data, data, sizeof(T) * len);
    }

    List<T>(u32 capacity) {
        data = new T [capacity];
        len = 0;
        capacity = capacity;
    }

    ~List<T>() {
        delete [] data;
    }

    void append(T data) {
        this->data[len] = data;
        len++;
        if (len == capacity) {
            capacity <<= 1;
            T *new_data = new T [capacity];
            memcpy(new_data, this->data, sizeof(T) * len);
            delete [] this->data;
            this->data = new_data;
        }
    }

    void append_many(T *data, u32 len) {
        while (this->capacity - this->len < len) {
            this->capacity <<= 1;
            T *new_data = new T [capacity];
            memcpy(new_data, this->data, sizeof(T) * this->len);
            delete [] this->data;
            this->data = new_data;
        }

        memcpy(this->data + this->len, data, sizeof(T) * len);
        this->len += len;
    }

    //this is qyte expensive operation, try to avoid it
    void insret(T *data, u32 len) {

    }

    //0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    //         ^
    void remove_ordered(u32 index) {
        if (index > len - 1) {
            return;
        }

        T *tmp_buf = new T [len - index - 1];
        memcpy(tmp_buf, this->data + (index + 1), sizeof(T) * (len - index - 1));
        memcpy(this->data + index, tmp_buf, sizeof(T) * (len - index - 1));
        len--;
        delete [] tmp_buf;
    }

    void remove_unordered(u32 index) {
        if (index > len - 1) {
            return;
        }

        data[index] = data[len - 1];
        len--;
    }

    inline u32 size() {
        return len;
    }

    T& operator[](u32 index) {
        if (index < len) {
            return data[index];
        }
        return data[0];
    }

    void operator<<(T data) {
        append(data);
    }
};

#endif //LIB_LIST_HPP
