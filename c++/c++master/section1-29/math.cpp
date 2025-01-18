#include <iostream>
#include <cmath>


#define NL '\n'

int main() {
    double weight {4.4};
    double savings {-5000};
    std::cout << "Weight rounded to ceil " << std::ceil(weight) << '\n';
    std::cout << "Weight rounded to floor " << std::floor(weight) << '\n';
    std::cout << "Abs of weight is: " << std::abs(weight) << '\n';
    std::cout << "Abs of savings is: " << std::abs(savings) << '\n';
    double exponentioal = std::exp(10);
    std::cout << "The exponential of 10 is: " << exponentioal << '\n';
    std::cout << "3 ^ 4 is : " << std::pow(3, 4) << '\n';
    std::cout << "9 ^ 3 is : " << std::pow(9, 3) << '\n';

    std::cout << "Log; to get 54.59, you would elevate e to the power of : " << std::log(54.59) << '\n';
    std::cout << "To get 1000, you'd need to elevate 10 to the poewr of : " << std::log10(10000) << '\n';

    std::cout << "Expe 54.59  " << std::exp(3.99985) << '\n';
    std::cout << "The square root os 81 is : " << std::sqrt(81) << '\n';
    std::cout << "3.654 rounded to : " << std::round(3.654) << NL;
    std::cout << "2.5 rounded to : " << std::round(2.5) << NL;
    std::cout << "2.4 rounded to : " << std::round(2.4) << NL;


    double side = 6.7;
    double hex_area = ((3 * std::sqrt(3)) / 2) * std::pow(side, 2);
    std::cout << "Hexagon area is : " << hex_area << NL;


    short var1 {10};
    short var2 {20};

    char var3 {40};
    char var4 {50};

    std::cout << "size of var1 : " << sizeof(var1) << NL;
    std::cout << "size of var2 : " << sizeof(var2) << NL;
    std::cout << "size of var3 : " << sizeof(var3) << NL;
    std::cout << "size of var4 : " << sizeof(var4) << NL;


    auto result1 = var1 + var2;
    auto result2 = var3 + var4;

    std::cout << "size of result1 : " << sizeof(result1) << NL;
    std::cout << "size of result2 : " << sizeof(result2) << NL;



    

    return 0;
}
