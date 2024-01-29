#include <iostream>
#include <vector>


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

    game();

    return 0;
}
