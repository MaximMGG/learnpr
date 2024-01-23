#include <iostream>

using namespace std;

int main() {
    int b[3] = {12, 13, 14};
    int *b_p = b + 1;
    cout << *b_p << endl;
    b_p++;
    cout << *b_p << endl;
    b_p++;
    cout << *b_p << endl;
}
