#ifndef FAST_SORT_HPP
#define FAST_SORT_HPP
#include <string.h>


template<typename T> 
void fast_sort(T *arr, unsigned int size) {
    if (size == 1) {
        return;
    } else if (size == 2) {
        if (arr[0] > arr[1]) {
            T tmp = arr[0];
            arr[0] = arr[1];
            arr[1] = tmp;
            return;
        }
    } else {
        unsigned l_arr_size = size / 2;
        unsigned r_arr_size = size % 2 == 0 ? size / 2 : (size / 2 + 1);
        T l_arr[l_arr_size];
        T r_arr[r_arr_size];
        memcpy(l_arr, arr, l_arr_size * sizeof(T));
        memcpy(r_arr, arr + l_arr_size, r_arr_size * sizeof(T));
        fast_sort<T>(l_arr, l_arr_size);
        fast_sort<T>(r_arr, r_arr_size);

        int l_i = 0;
        int r_i = 0;

        for(int i = 0; i < size; i++) {
            if (l_i == l_arr_size) {
                arr[i] = r_arr[r_i++];
                continue;
            }
            if (r_i == r_arr_size) {
                arr[i] = l_arr[l_i++];
                continue;
            }
            if (l_arr[l_i] > r_arr[r_i]) {
                arr[i] = r_arr[r_i++];
                continue;
            } else {
                arr[i] = l_arr[l_i++];
                continue;
            }
        }
    }
}


#endif
