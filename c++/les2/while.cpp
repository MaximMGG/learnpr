#include <string>
#include <iostream>

using namespace std;

int main() {

    int word_counter = 0;
    string previous = " ";
    string cur;
    while(cin >> cur) {
        word_counter++;
        if (previous == cur) {
            cout << "Repited word is: " << cur << endl;
            cout << "In position " << word_counter << endl;
        }
        previous = cur;
    }

    return 0;
}
