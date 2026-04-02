#include <iostream>
#include <cctype>
#include <array>



void first() {
    using namespace std;


    char buf[1000];
    int i = 0;
    char ch;
    cin.get(ch);

    while(ch != '@') {
        if (isalpha(ch)) {
            if (islower(ch)) {
                ch = toupper(ch);
            } else if (isupper(ch)) {
                ch = tolower(ch);
            }
        }
        cout << ch;
        cin.get(ch);
    }
}

void second() {
    using namespace std;
    std::array<double ,10> arr_double;
    double ch_d;
    int ch;
    double avarage = 0;
    int move_avarage = 0;
    cin >> ch_d;

    while(ch_d != 0.0) {
        arr_double[ch++] = ch_d;
        if (ch == 10) {
            break;
        }
        cin >> ch_d;
    }

    for(int i = 0; i < arr_double.size(); i++) {
        avarage += arr_double[i];
    }
    avarage /= arr_double.size();
    for(int i = 0; i < arr_double.size(); i++) {
        if (arr_double[i] > avarage) {
            move_avarage++;
        }
    }
    cout.setf(ios_base::fixed);

    for(double x : arr_double) {
        cout << x << " ";
    }
    cout << "avarage is: " << avarage << "count numbers more then avarage is: " << move_avarage << endl;
}

static bool contein(char ch, std::array<char, 4> ch_ar) {
    for(char c : ch_ar) {
        if (c == ch) {
            return true;
        }
    }
    return false;
}


void third() {
    using namespace std;
    char ch;
    array<char, 4> ch_arr;
    ch_arr[0] = 'q';
    ch_arr[1] = 'w';
    ch_arr[2] = 'e';
    ch_arr[3] = 'r';

    cout << "Please enter one of following choices: " << endl;
    cout << "q) Dog             w) Cat\n";
    cout << "e) Perrot          r) Fish\n";

    cin.get(ch).get();
    while(!contein(ch, ch_arr)) {
        cout << "Don't have that option " << ch << " please enter q, w, e, or r : ";
        cin.get(ch).get();
    }

    switch(ch) {
        case 'q':
            cout << "Anemal is Dog!" << endl;
            break;
        case 'w':
            cout << "Anemal is Cat!" << endl;
            break;
        case 'e':
            cout << "Anemal is Perrot!" << endl;
            break;
        case 'r':
            cout << "Anemal is Fish!" << endl;
            break;
    }
}



int main() {
    // first();
    // second();
    third();


    return 0;
}
