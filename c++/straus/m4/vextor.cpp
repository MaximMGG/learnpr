#include <iostream>
#include <vector>

void names() {
    using namespace std;
    vector<string> names;
    vector<int> ages;

    string temp_s = "";
    int temp_i = 0;

    cin >> temp_s >> temp_i;
    while(temp_s != "NoName" && temp_i != 0) {
        if (temp_s == "") {
            cerr << "You didnt enter name\n";
        } else {
            names.push_back(temp_s);
        }
        if (temp_i == 0) {
            cerr << "You didnt enter age\n";
        } else {
            ages.push_back(temp_i);
        }
        cin >> temp_s >> temp_i;
    }
    for(int i = 0; i < names.size(); i++) {
        cout << "Name is: " << names[i] << " ,age is: " << ages[i] << ".\n";
    }
}

void game() {
    using namespace std;

    char u = 0;
    int r = 0;

    for( ; u != 'e';) {
        cin >> u;
        r = rand();
        r %= 3;
        if (r == 0 && u == 'k') {
            cout << r << " " << "you win\n";
            continue;
        } else if (r == 1 && u == 'n') {
            cout << r << " " << "you win\n";
            continue;
        } else if (r == 2 && u == 'b') {
            cout << r << " " << "you win\n";
            continue;
        } else {
            cout << r << " " << "you lose\n";
            continue;
        }
    }
}


int main() {


    std::vector<int> nums;
    nums.push_back(1);
    nums.push_back(2);
    nums.push_back(3);
    nums.push_back(4);

    for(int a : nums) {
        std::cout << a << std::endl;
    }

    nums[0] = 2;
    nums[1] = 3;
    nums[2] = 4;

    for(int a : nums) {
        std::cout << a << std::endl;
    }

    std::cout << sizeof(nums[0]) << std::endl;

    // game();
    names();

    return 0;
}
