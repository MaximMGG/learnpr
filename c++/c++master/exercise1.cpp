#include <iostream>
#include <limits>


int max_subsequence_sum(int sequence[], unsigned int size) {
    int sum {};
    int max_sum {std::numeric_limits<int>::min()};
    for(int i = 0; i < size; i++) {
        for(int j = i; j < size;  j++) {
            for(int k = j; k < size - j + i; k++) {
                sum += sequence[k];
            }
            if (sum > max_sum) max_sum = sum;
            sum = 0;
        }
    }

    return max_sum;
}


int main() {

    int data[] {-2, 2, 3};
    std::cout << max_subsequence_sum(data, 3) << '\n';

    return 0;
}
