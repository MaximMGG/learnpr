#include <iostream>

long conftoya(int);

int main() {
    using namespace std;

    int far;
    cout << "Enter here distance in faralongs: ";
    cin >> far;
    int res = conftoya(far);
    cout << "This your distance in yards " << res  << " yeards "<< endl;

    return 0;
}

long conftoya(int distance) {
    return distance * 220;
}
