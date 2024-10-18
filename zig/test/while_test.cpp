#include <iostream>


int getNum(int a) {
    if (a % 2 == 0) return a + 1;
    else return a + 0;
}



int main() {
    int a = 1;

    while((a = getNum(a)) != -1) {
        if (a == 3333333) return 0;
        std::cout << a << '\n';
        a++;
    }

    return 0;
}
