#include "sal.h"
#include <float.h>
#include <iostream>

template <typename T> 
T sorting (T t[], int n) {
    int first_len = n / 2;
    int last_len = n % 2 == 0 ? n / 2 : n / 2 + 1;





}

// {1, 4,5, 12, 345, 1, 23, 55, 65, 3, 16, 77, 88, 345, 2, 55, 6};
// 1, 4, 5, 12, 1, 23, 55, 345
// 1, 1, 4, 5, 12, 23, 55, 345  2, 3, 6, 15, 55, 65, 77, 88, 345
// 1, 1, 2, 3, 4, 5, 6, 12, 15, 23, 55, 55, 65, 77, 88, 345, 345  





namespace SALES {
    void setSales(Sales& s, const double ar[], int n) {
        if (n > 4) {
            for(int i = 0; i < QUARTERS; i++) {
                s.sales[i] = ar[i];
            }
            n = QUARTERS;
        } else {
            for(int i = 0; i < QUARTERS; i++) {
                if (i < n)
                    s.sales[i] = ar[i];
                else 
                    s.sales[i] = 0.0;
            }
        }
        s.max = 0;
        s.min = DBL_MAX;
        s.average = 0;
        for(int i = 0 ;i < n; i++) {
            if (s.sales[i] > s.max) {
                s.max = s.sales[i]; 
            }
            if (s.sales[i] < s.min) {
                s.min = s.sales[i];
            }
            s.average += s.sales[i];
        }
        s.average /= n;
    }

    void setSales(Sales& s) {
        std::cout << "Enter sales for four quarters:\n";
        for(int i = 0; i < QUARTERS; i++) {
            std::cin >> s.sales[i];
        }
        s.min = DBL_MAX;
        for(int i = 0; i < QUARTERS; i++) {
            if (s.sales[i] > s.max) {
                s.max = s.sales[i]; 
            }
            if (s.sales[i] < s.min) {
                s.min = s.sales[i];
            }
            s.average += s.sales[i];
        }
        s.average /= QUARTERS;
    }

    void showSales(const Sales& s) {
        std::cout << "Sales for four quarters is: \n";
        std::cout << s.sales[0] << " " << s.sales[1] << " " << 
            s.sales[2] << " " << s.sales[3] << std::endl;
        std::cout << "Max sales is: " << s.max << std::endl;
        std::cout << "Min sales is: " << s.min << std::endl;
        std::cout << "Average sales is: " << s.average << std::endl;
    }
}
