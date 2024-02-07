#include "mytime0.h"
#include <iostream>


int main() {
    Time weeding {4, 35};
    Time waxing {2, 47};
    Time total {0};
    Time diff {0};
    Time adjusted {};
    Time test;

    std::cout << "Weeding time = ";
    weeding.Show();
    std::cout << "Waxing time = ";
    std::cout << waxing;
    std::cout << "Total work time = ";
    total = weeding + waxing;
    total.Show();
    diff = weeding - waxing;
    std::cout << "Weeding time - waxing time = ";
    diff.Show();
    adjusted = total * 1.5;
    std::cout << "Adjusted work time = ";
    adjusted.Show();
    test = 2.4 * adjusted;
    std::cout << test << " day one, and " << diff << " day to\n";  

    return 0;
}
