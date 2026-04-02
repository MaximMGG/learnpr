#include <iostream>
#include <stdio.h>
#include <type_traits>

constexpr int greater(int x, int y) { 
    if (std::is_constant_evaluated()) {
        std::cout << "Yes\n"; 
    } else {
        std::cout << "NO\n";
    }
    return x > y ? x : y; 
}

inline int min(int l, int r) { return l > r ? r : l; }

int main() {

  printf("Min is %d\n", min(4, 5));
  printf("Min is %d\n", min(12, 8));
  printf("Min is %d\n", min(234, 99));

  greater(1, 2);


  return 0;
}
