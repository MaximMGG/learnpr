#include <iostream>
#include <cmath>
#include <stdlib.h>

int main() {

    using namespace std;

    double area;
    cout << "Enter the floor area, in square feet, of you home: " << endl;
    cin >> area;
    double size = sqrt(area); 
    cout << "That's the equivalent of a square " << size << " feet to the side." << endl;
    cout << "How fascinationg!" << endl;
    float roud;
    int *b = (int * )malloc(100);

    cout << sizeof(size) << endl;
    cout << sizeof(roud) << endl;
    cout << sizeof(*b) << endl;

    return 0;
}
