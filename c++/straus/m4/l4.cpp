#include <iostream>

constexpr double UAH_USD  = 37.5;
constexpr double UAH_PLN = 8.1;
using namespace std;

int old_square(int x) {
    int res = 0;
    for(int i = 0; i < x; i++) {
        res += x;
    }
    return res;
}

void mony() {
    double mony;
    int chose = 0;
    cout << "Plese enter count of UAH" << endl;
    cin >> mony;
    cout << "Chose a value\n";
    cout << "1. " << "USD" << "\n2. " << "PLN" << endl; 
    cin >> chose;
    if (chose != 1 && chose != 2) {
        cerr << "Dont have that option\n";
        exit(1);
    }
    if (chose == 1)
        cout << mony << " Hrivnas equals " << mony * UAH_USD << " USD" << endl;
    else 
        cout << mony << " Hrivnas equals " << mony * UAH_PLN << " PLN." << endl;
}


void char_count() {
    char a = 'a';

    for(int i = 0; i < 26; i++) {
        cout << a << " " << int(a) << endl;
        a++;
    }
}


int main() {
    // mony();
    char_count();
    cout << old_square(8) << endl;
    return 0;
}
