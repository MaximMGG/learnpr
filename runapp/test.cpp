#include <iostream>


int main(int argc, char **argv) {

    std::cout << "Hello\n";
    if (argc > 1) {
        std::cout << "Here your args: \n";

        for(int i = 1; i < argc; i++) {
            std::cout << argv[i] << std::endl;
        }
    }

    return 0;
}
