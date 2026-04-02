#include <iostream>


struct tt {
    int tt;
    char b;
};


void func(void *p) {
    // struct tt p_T = (struct tt) *p;
}


int main() {
    struct tt b;
    func(&b);

    return 0;
}
