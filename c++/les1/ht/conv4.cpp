#include <iostream>

using namespace std;


#define MAX_HOURS 24
#define MAX_MINUTES 60

void showTime(int h, int m) {
    if (h >= MAX_HOURS || h < 0) {
        cerr << "Wrong time, hours more the 23 hours or less then 0" << endl;
        exit(1);
    }
    if (m >= MAX_MINUTES || m < 0)
        cerr << "Wrong time, minutes more the 60 or less 0" << endl;
    cout << h << " : " << m << endl;
}


int main() {
    int hours; 
    int minutes;

    cout << "Enter the number of hours: ";
    cin >> hours;
    cout << "Enter the number if minutes: ";
    cin >> minutes;
    showTime(hours, minutes);

    return 0;
}
