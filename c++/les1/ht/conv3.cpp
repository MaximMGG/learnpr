#include <iostream>


long double conv(double year) {
    return year * 63240;
}


int main() {
    using namespace std;

    double year;
    cout << "Enter number of light years: ";
    cin >> year;
    long double distance = conv(year);
    cout << year << "light years = " << distance << " astronomical units." << endl;

    return 0;
}
