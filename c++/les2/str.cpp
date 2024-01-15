#include <string>
#include <iostream>
#include <vector>

using namespace std;

int main() {
    cout << "Enter your name" << endl;
    string first_name;
    cin >> first_name;
    cout << "Hello " << first_name << endl;
    cout << first_name.length() << endl;
    int b = 123;
    unsigned int naumber;
    naumber = 0xffffffff;
    cout << naumber << endl;
    first_name = first_name + " bye";
    cout << first_name << endl;

    return 0;
}
