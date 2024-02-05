#include <iostream>


template <typename T>
T *babble_sort(T *t, int n) {
    bool ch;

    for(int i = 0; i < n; i++) {
        ch = false;
        for(int j = 0; j < n - 1; j++) {
            if (t[j] > t[j + 1]) {
                T temp = t[j];
                t[j] = t[j + 1];
                t[j + 1] = temp;
                ch = true;
            }
        }
        if (ch == false) return t;
    }
    return t;
}

template <typename T>
static int get_min(T *t, int n, int start_p) {
    T min = 999999999;
    int p = 0;
    for (int i = start_p; i < n; i++) {
        if (t[i] < min) {
            min = t[i];
            p = i;
        }
    }
    return p; 
}


template <typename T>
T *chose_sort(T *t, int n) {
    for(int i = 0; i < n; i++) {
        int m = get_min(t, n, i);
        T temp = t[i];
        t[i] = t[m]; 
        t[m] = temp;
    }
    return t;
}

template <typename T>
static T *fast_sort_helpe(T *t, int start, int end) {
    return t;
}

template <typename T>
T *fast_sort(T *t, int n) {
    struct temp {
        T *arr;
        int size;
    };
    T *arr = fast_sort_helpe(t, 0, n);
    return arr;
}


void *sssfast_sort_helper(int *ar, int l, int r) {
    int len = r - l + 1;
    struct temp {
        int *t;
        int size;
    };
    temp *left = new temp;
    temp *right = new temp;


    if (len > 2) {
        if (len % 2 != 0) {
            left->t = new int[len / 2];
            right->t = new int[len / 2 + 1];
        } else {
            left->t = new int[len / 2];
            right->t = new int[len / 2];
        }
        left = (temp *)sssfast_sort_helper(ar, l, l + len / 2 - 1);
        right = (temp *)sssfast_sort_helper(ar, l + len / 2, r);
    } else {
        left->t = new int[len];
        right->t = new int[len];
        
        if (len == 1) {
            left->t[0] = ar[l];
            left->size = 1;
            return left;
        }
        if (len == 2) {
            if (ar[l] > ar[r]) {
                left->t[0] = ar[r];
                left->t[1] = ar[l];
            } else {
                left->t[0] = ar[l];
                left->t[1] = ar[r];
            }
            left->size = 2;
            return left;
        }
    }

    int arr_len = left->size + right->size;
    temp *arr = new temp;
    arr->t = new int[arr_len];
    arr->size = arr_len;

    for (int i = 0, l_p = 0, r_p = 0; i < arr_len; i++) {
        if (l_p < left->size) {
            if (r_p < right->size) {
                if (left->t[l_p] > right->t[r_p]) {
                    arr->t[i] = right->t[r_p++];
                } else {
                    arr->t[i] = left->t[l_p++];
                }

            } else {
                arr->t[i] = left->t[l_p++];
            }
            continue;
        }
        if (r_p < right->size) {
            if (l_p < left->size) {
                if (left->t[l_p] > right->t[r_p]) {
                    arr->t[i] = right->t[r_p++];
                } else {
                    arr->t[i] = left->t[l_p++];
                }
            } else {
                arr->t[i] = right->t[r_p++];
            }
        }
        continue;
    }
    delete [] left->t;
    delete [] right->t;
    delete left;
    delete right;
    return arr;
}



int *sssfast_sort(int *ar, int n) {

    struct temp {
        int *arr;
        int size;
    };

    temp *a = (temp *)sssfast_sort_helper(ar, 0, n - 1);
    return a->arr;
}



int *ssssort(int *ar, int n) {
    bool change = false;
    for(int i = 0; i < n; i++) {
        change = false;
        for(int j = 0; j < n - 1; j++) {
            if (ar[j] > ar[j + 1]) {
                int temp = ar[j];
                ar[j] = ar[j + 1];
                ar[j + 1] = temp;
                change = true;
            }
        }
        if (change == false) return ar;
    }
    return ar;
}








template <typename T>
void print_arr(T t[], int n) {
    std::cout << "{";
    for(int i = 0; i < n; i++) {
        if (i == n - 1) {
            std::cout << t[i];
            break;
        }
        std::cout << t[i] << ", ";
    }
    std::cout << "}\n";
}

#define ARR_LEN 100000

int main() {



#ifdef BABLE
    std::cout << "BUBLE START" << std::endl;
    int *arr = new int[ARR_LEN];
    for(int i = 0; i < ARR_LEN; i++) {
        arr[i] = rand() % 1000; 
    }
    babble_sort(arr, ARR_LEN);
    // print_arr(arr, ARR_LEN);
    std::cout << "BUBLE FINISH" << std::endl;
    delete [] arr;
#endif
#ifdef CHOSE
    std::cout << "CHOSE START" << std::endl;
    int *arr = new int[ARR_LEN];
    for(int i = 0; i < ARR_LEN; i++) {
        arr[i] = rand() % 1000; 
    }
    chose_sort(arr, ARR_LEN);
    // print_arr(arr, ARR_LEN);
    std::cout << "CHOSE FINISH" << std::endl;
    delete [] arr;
#endif
#ifdef FAST
    std::cout << "FAST START" << std::endl;
    int *arr = new int[ARR_LEN];
    for(int i = 0; i < ARR_LEN; i++) {
        arr[i] = rand() % 1000; 
    }
    int *a = sssfast_sort(arr, ARR_LEN);
    print_arr(a, ARR_LEN);
    std::cout << "FAST FINISH" << std::endl;
    delete [] arr;
#endif

    return 0;
}
