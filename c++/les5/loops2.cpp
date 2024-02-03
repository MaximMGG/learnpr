#include <iostream>




void starts(int x) {
    using namespace std;
    for(int i = 1; i <= x; i++) {
        for(int j = 0; j < x - i; j++) {
            cout << '.';
        }
        for(int j = 0; j < i; j++) {
            cout << '*';
        }
        cout << endl;
    }
}



int main() {
    using namespace std;
    double arr[]{1.3, 3.4, 5.6, 1.1};

    for(double &d : arr) {
        d += 1.0;
        std::cout << d << std::endl;
    }

    for(double b : arr) {
        std::cout << b << std::endl;
    }
    cout << "------------------------\n";
    int s_count = 0;
    cin >> s_count;
    starts(s_count);

    // int count = 0;
    // char ch;
    // cin.get(ch);
    // while(ch != EOF) {
    //     cout << ch << endl;
    //     count++;
    //     cin.get(ch);
    // }
    // cout << count << endl;
    //



    return 0;
}
