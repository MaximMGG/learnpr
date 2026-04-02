#include "sal.h"
#include <float.h>
#include <iostream>
#include "sort.h"

namespace SALES {
    void setSales(Sales& s, double *ar, int n) {
        double *sort_ar = fast_sort<double>(ar, n);
        if (n > 4) {
            for(int i = 0; i < QUARTERS; i++) {
                s.sales[i] = sort_ar[i];
            }
            n = QUARTERS;
        } else {
            for(int i = 0; i < QUARTERS; i++) {
                if (i < n)
                    s.sales[i] = sort_ar[i];
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
