#include <iostream>
#include <string>
#include <array>
#include <vector>

using namespace std;

#define EXP_LENGTH 1000000


#ifdef DYN_ARR

long calc() {
    cout << "dyn_arr" << endl;
    int *arr = new int[EXP_LENGTH];
    long res = 0;

    int *p = arr;

    for(int i = 0; i < EXP_LENGTH; i++) {
        *p = rand() % 10;
        p++;
    }

    p = arr;

    for(int i = 0; i < EXP_LENGTH; i++) {
        res += *p;
        p++;
    }

    delete[] (arr);

    return res;
}
#endif


#ifdef OLD_ARR

long calc() {
    cout << "old_arr" << endl;
    int arr[EXP_LENGTH];
    long res = 0;

    for(int i = 0; i < EXP_LENGTH; i++) {
        arr[i] = rand() % 10;
    }

    for(int i = 0; i < EXP_LENGTH; i++) {
        res += arr[i];
    }

    return res;
}
#endif

#ifdef NEW_ARR

long calc() {
    cout << "new_arr" << endl;
    std::array<int, EXP_LENGTH> arr;
    long res = 0;

    for(int i = 0; i < EXP_LENGTH; i++) {
        arr[i] = rand() % 10;
    }

    for(int i = 0; i < EXP_LENGTH; i++) {
        res += arr[i];
    }

    return res;
}
#endif



#ifdef VECTOR

long calc() {
    cout << "vector" << endl;
    std::vector<int> arr(EXP_LENGTH);
    long res = 0;

    for(int i = 0; i < EXP_LENGTH; i++) {
<<<<<<< HEAD
=======
        // arr.push_back(rand() % 10);
>>>>>>> 845f96e (jeck some singth)
        arr[i] = rand() % 10;
    }

    for(int i : arr) {
        res += i;
    }

    return res;
}
#endif





void arrays() {
    double a1[4] = {1.2, 2.3, 3.4, 4.5};
    std::array<double, 4> a2 = {1.2, 2.3, 3.4, 4.5};
    std::vector<double> a3(4); 
    a3[0] = 1.2;
    a3[1] = 2.3;
    a3[2] = 3.4;
    a3[3] = 4.5;


    for(int i = 0; i < 4; i++) {
        cout << "a1" << endl;
        cout << "Value is: " << a1[i] << " address is: " << &a1[i] << endl;
    }
    for(int i = 0; i < 4; i++) {
        cout << "a2" << endl;
        cout << "Value is: " << a2[i] << " address is: " << &a2[i] << endl;
    }
    for(int i = 0; i < 4; i++) {
        cout << "a3" << endl;
        cout << "Value is: " << a2[i] << " address is: " << &a3[i] << endl;
    }
}

int main() {

    // int age;
    // cout << "Enter age: " << endl;
    // // (cin >> age).get();
    // char name[20];
    // cout << "Enter name\n";
    // // cin.getline(name, 20);
    //
    // cout << "Your name is " << name << ", age is: " << age << endl;
    //
    //
    // string name2{"Petro"};
    // name2 = "Ne petor";
    // name2 += " a olya";
    //
    // wchar_t tile[] = L"Hello"; 
    // char16_t title[] = u"Super tittle";
    // char32_t tittle[] = U"Super duper tittle";
    //
    // cout << tile << " "  << title << " " << tittle << endl;
    //
    // cout << "=========================================\n";

    long res = calc();
    cout << res << endl;

    // arrays();
}
