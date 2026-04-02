#include <iostream>
#include <array>

void first() {
    using namespace std;

    string first_name;
    // char first_name[60];
    string last_name;
    char deserve;
    int age;
    cout << "What is your first name?";
    getline(cin, first_name);
    cout << "What is your last name?";
    getline(cin, last_name);
    cout << "What letter grade do you deserve?";
    deserve = (char)cin.get();
    cout << "What is your age?";
    cin >> age;
    cout << "Name: " << last_name << ", " << first_name << endl;
    cout << "Grade: " << ++deserve << endl;
    cout << "Age: " << age << endl;
}


int main() {
    first();

    double x1 = {2.3};
    double x2 = {3.5};
    int c = static_cast<int>(x1 + x2);

    return 0;
}
