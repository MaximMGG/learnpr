#include <iostream>
#include <cmath>


const double GRAVITY {9.8};


int main() {
    double t_height;
    std::cout << "Enter the tower height: ";
    double falen;
    std::cin >> t_height;
    for(int i = 0; i <=5; i++) {
        falen = GRAVITY * pow(i, 2) / 2;
        if (falen > t_height) {
            std::cout << "At " << i << " seconds, the ball is on the ground.\n";
            break;
        }
        std::cout << "At " << i << " seconds, the ball is at height: " << t_height - falen << " meters\n";
    }
    return 0;
}
