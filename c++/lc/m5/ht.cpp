#include <iostream>
#include <string>
#include <cstdint>


void tehas() {

    std::cout << "How old are yor?\n";
    std::uint8_t age {};
    std::cin >> age;

    std::cout << "Allowed to drive a car in Texas [";
    if (age >= 16) {
        std::cout << "x";
    } else {
        std::cout << ' ';
    }
    std::cout << "]\n";
}


void name_age() {
  std::string name{};
  int age;
  std::cout << "Enter your full name: ";
  std::getline(std::cin >> std::ws, name);
  std::cout << "Enter your age ";
  std::cin >> age;

  std::cout << "Your age + length of name is " << name.length() + age << '\n';
}


const double getTowerHeight() {
    double towerHeight {};
    std::cout << "Enter the height of the tower in meters: ";
    std::cin >> towerHeight;
    return towerHeight;
}

double calculateBallHeight(const double towerHeight, const int seconds) {
    constexpr double gravity {9.8};

    const double distanceFallen {(gravity * (seconds * seconds)) / 2.0};
    double currentHeight {towerHeight - distanceFallen};
    return currentHeight;

}

void printBallHeight(double ballHeight, const int seconds) {
    if (ballHeight > 0.0)
        std::cout << "At " << seconds << " seconds, the ball is at height: " << ballHeight << " meters\n";
    else 
        std::cout << "At " << seconds << " seconds, the ball is on the ground\n";

}
void printCalculatedBallHeight(const double towerHeight, const int seconds) {
    double ballHeight {calculateBallHeight(towerHeight, seconds)};
    printBallHeight(ballHeight, seconds);
}


int main2() {

    const double towerHeight {getTowerHeight()};

    printCalculatedBallHeight(towerHeight, 0);
    printCalculatedBallHeight(towerHeight, 1);
    printCalculatedBallHeight(towerHeight, 2);
    printCalculatedBallHeight(towerHeight, 3);
    printCalculatedBallHeight(towerHeight, 4);
    printCalculatedBallHeight(towerHeight, 5);


    return 0;
}


void main3() {

    std::string person1 {};
    std::string person2 {};
    int age1 {};
    int age2 {};
    std::cout << "Eneter name of person #1: ";
    std::getline(std::cin >> std::ws, person1);
    std::cout << "Enter age of " << person1 << ": ";
    std::cin >> age1;
    std::cout << "Eneter name of person #2: ";
    std::getline(std::cin >> std::ws, person2);
    std::cout << "Enter age of " << person2 << ": ";
    std::cin >> age2;

    if (age1 > age2) {
        std::cout << person1 << " (age " << age1 << ") is older than " << person2 << " (age " << age2 << ").\n";
    } else {
        std::cout << person2 << " (age " << age2 << ") is older than " << person1 << " (age " << age1 << ").\n";
    }
}
constexpr std::string_view getQuantityPhrase(int apples) {
    if (apples < 0)
        return "negative";
    switch(apples) {
        case 0:
            return "no";
            break;
        case 1:
            return "a single";
            break;
        case 2:
            return "a couple of";
            break;
        case 3: 
            return "a few";
            break;
    }
    return "many";
}

constexpr std::string_view getApplesPluralized(int apples) {
    if (apples == 1)
        return "apple";
    else 
        return "apples";
}

void main4() {
    constexpr int maryApples {3};
    std::cout << "Mary has " << getQuantityPhrase(maryApples) << ' ' << getApplesPluralized(maryApples) << ".\n";

    std::cout << "How many apples do you have? ";
    int numApples{};
    std::cin >> numApples;
    std::cout << "You have " << getQuantityPhrase(numApples) << ' ' << getApplesPluralized(numApples) << ".\n";
}


int main() {

    // name_age();
    // tehas();
    // main2();
    // main3();
    main4();


    return 0;
}
