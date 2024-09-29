#ifndef ARRAYLIST_H
#define ARRAYLIST_H
#include <stdlib.h>
#include <pthread.h>


#define DEF_SIZE 20


template <typename T>
struct arraylist {
    private:
        T *data;
        unsigned int len;
        unsigned int size;
        pthread_mutex_t mut;
    public:
        arraylist<T>() {
            data = (T *)malloc(sizeof(T) * DEF_SIZE);
            len = 0;
            pthread_mutex_init(&mut, NULL);
        };
        ~arraylist<T>() {
            free(data);
            pthread_mutex_destroy(&mut);
        };
        void add(const T &data) {
            this->data[len++] = data;
        }
        T get(unsigned int index) {
            return data[index];
        }
};



#endif
