#ifndef LIST_HPP
#define LIST_HPP
#include <string.h>

template <typename T>
class List {
    private:
        T *buf;
        unsigned len = 0;
        unsigned capacity = 20;

    public:

        List() {
            this->buf = new T [this->capacity];
        }
        ~List() {
            delete [] this->buf;
        }

        void append(T data) {
            this->buf[this->len] = data;
            this->len++;
            if (this->len == this->capacity) {
                this->capacity <<= 1;
                T *tmp = new T [this->capacity];
                memcpy(tmp, this->buf, sizeof(T) * this->capacity >> 1);
                delete [] this->buf;
                this->buf = tmp;
            }
        }

        bool contain(T data) {
            for(int i = 0; i < this->len; i++) {
                if (data == this->buf[i]) {
                    return true;
                }
            }
            return false;
        }

        T* operator[](int i) {
            return &this->buf[i];
        }

        unsigned size() {
            return this->len;
        }
};

#endif
