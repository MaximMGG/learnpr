#include <iostream>

using namespace std;

int calc(int count) {

    while(count--) {
        cout << "a";
    }

    return 0;
}

int main() {
    calc(1000000);
    return 0;
}
