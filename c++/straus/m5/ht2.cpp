#include <iostream>
#include <vector>

int main() {
    int number_count;
    std::cout << "Enter count of summed numbers: \n";
    std::cin >> number_count;

    if (number_count < 1) {
        std::cout << "Numbers of count less then 1";
        exit(1);
    }

    std::cout << "Enter several numbers or | for end of input\n";

    std::vector<int> numbers {};
    int temp;

    while(std::cin >> temp) {
        if (temp == 0)
            std::cout << "Can't cast to int\n";
        numbers.push_back(temp);
    }
    int sum {0};

    std::cout << "Sum of first " << number_count << " (";
    auto a = numbers.begin();

    for(int i = 0; i < number_count; i++) {
        // sum += numbers[i];
        sum += *a;
        std::cout << *a;
        a++;
        if (i < number_count - 1) 
            std::cout << " ";
    }
    std::cout << ") is " << sum << '\n';

    return 0;
}


