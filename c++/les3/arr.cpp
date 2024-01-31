#include <iostream>
#include <string>

using namespace std;

int main() {

    int age;
    cout << "Enter age: " << endl;
    // (cin >> age).get();
    char name[20];
    cout << "Enter name\n";
    // cin.getline(name, 20);

    cout << "Your name is " << name << ", age is: " << age << endl;


    string name2{"Petro"};
    name2 = "Ne petor";
    name2 += " a olya";

    wchar_t tile[] = L"Hello"; 
    char16_t title[] = u"Super tittle";
    char32_t tittle[] = U"Super duper tittle";

    cout << tile << " "  << title << " " << tittle << endl;
}
