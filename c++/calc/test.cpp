#include <iostream>
#include <vector>


int main() {

    std::vector<int> arr;

    for(int i = 0; i < 10; i++) {
        arr.push_back(i);
    }

    auto a = arr.begin();
    a += 3;
    arr.erase(a);

    for(int i = 0; i < arr.size(); i++) {
        std::cout << arr[i] << ' ';
    }
    std::cout << '\n';


    return 0;
}
